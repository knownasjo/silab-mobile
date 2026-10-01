import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silab/app_config.dart';
import 'package:silab/core/common/entities/class/class_entity.dart';
import 'package:silab/core/common/widgets/custom_loading_indicator.dart';
import 'package:silab/core/device/device_id.dart';
import 'package:silab/core/network/api_client.dart';
import 'package:silab/features/classes/data/data_sources/classes_api_service.dart';
import 'package:silab/features/classes/data/repository/class_repository_impl.dart';
import 'package:silab/features/classes/domain/usecases/add_user_attendances_usecase.dart';
import 'package:silab/features/classes/domain/usecases/get_classmates_usecase.dart';
import 'package:silab/features/classes/domain/usecases/get_user_meetings_data_usecase.dart';
import 'package:silab/features/classes/domain/usecases/get_user_registered_classes_usecase.dart';
import 'package:silab/features/classes/presentation/bloc/classmates/classmates_bloc.dart';
import 'package:silab/features/classes/presentation/bloc/user_attendances/user_attendances_bloc.dart';
import 'package:silab/features/classes/presentation/bloc/user_meetings/user_meetings_bloc.dart';
import 'package:silab/features/classes/presentation/bloc/user_registered_class/user_registered_class_bloc.dart';
import 'package:silab/features/classes/presentation/pages/class_detail_page.dart';
import 'package:silab/features/classes/presentation/pages/qr_scan_page.dart';

import '../../helpers/real_font.dart';
import '../../helpers/small_phone_shell.dart';

class FakeDeviceId extends DeviceIdSource {
  @override
  Future<String?> read() async => 'hp-uji';
}

const scannerMethods =
    MethodChannel('dev.steenbakker.mobile_scanner/scanner/method');
const scannerEvents =
    EventChannel('dev.steenbakker.mobile_scanner/scanner/event');
const longLecturer = 'Dr. Ir. Budi Santoso Wibowo, S.T., M.Kom., IPM.';
const longTitle = 'Normalisasi Basis Data dan Desain Skema Lanjut 01';
const offline = 'Tidak dapat terhubung ke server. Periksa koneksi internet.';

Map<String, dynamic> meeting(int number,
        {bool open = false, bool attended = false, String? name}) =>
    {
      'id': 'm$number',
      'meeting_name': name ?? 'Pertemuan $number',
      'is_open': open,
      'submitted_at': attended ? '2026-10-01T01:00:00.000Z' : null,
      'is_attended': attended,
    };

void main() {
  late SharedPreferences prefs;
  late List<Map<String, dynamic>> meetings;
  late List<http.Request> attendancePosts;
  late Set<String> down;
  late bool cameraAllowed;
  late String lecturer;
  late ScrollController controller;
  Completer<void>? holdAttendance;

  setUpAll(loadRealFont);

  setUp(() async {
    AppConfig.create(baseUrl: 'http://silab.test');
    SharedPreferences.setMockInitialValues(
        {'accessToken': 'akses', 'refreshToken': 'segar'});
    prefs = await SharedPreferences.getInstance();
    meetings = [meeting(1), meeting(2, attended: true), meeting(3, open: true)];
    attendancePosts = [];
    down = {};
    cameraAllowed = true;
    lecturer = 'Dosen001';
    holdAttendance = null;
  });

  http.Response ok(Object? data, [String message = 'Berhasil']) =>
      http.Response(
          jsonEncode({'status': true, 'message': message, 'data': data}), 200);

  Map<String, dynamic> kelas() => {
        'id': 'k1',
        'subject_name': 'Basis Data',
        'subject_class': 'A',
        'lecturer': lecturer,
        'day': 'MONDAY',
        'session_time': '07.00 - 08.40',
      };

  Future<http.Response> backend(http.Request request) async {
    final path = request.url.path;
    if (down.contains(path)) throw http.ClientException('Connection refused');

    if (path == '/meeting/k1') return ok(meetings);
    if (path == '/class/k1/classmates') {
      return ok([
        {'id': 'u1', 'name': 'Budi Santoso', 'is_me': true},
      ]);
    }
    if (path == '/class/me') return ok([kelas()]);
    if (path == '/subject/classes/k1/meetings/m3/attendances') {
      attendancePosts.add(request);
      await holdAttendance?.future;
      meetings[2] = meeting(3, open: true, attended: true);
      return ok(null, 'Presensi berhasil');
    }
    return http.Response('{"status":false,"message":"Not Found"}', 404);
  }

  Future<void> settle(WidgetTester tester) async {
    for (var i = 0; i < 5; i++) {
      await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 20)));
      await tester.pump(const Duration(milliseconds: 100));
    }
    await tester.pumpAndSettle();
  }

  Future<void> openDetail(WidgetTester tester,
      {Size size = const Size(360, 640), double textScale = 1}) async {
    useSmallPhone(tester);
    tester.view.physicalSize = size * 3;
    tester.platformDispatcher.textScaleFactorTestValue = textScale;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    final messenger = tester.binding.defaultBinaryMessenger;
    messenger.setMockMethodCallHandler(scannerMethods, (call) async {
      return switch (call.method) {
        'state' => cameraAllowed ? 1 : 2,
        'request' => cameraAllowed,
        'start' => {
            'textureId': 1,
            'size': {'width': 640.0, 'height': 480.0},
            'numberOfCameras': 1,
            'currentTorchState': 0,
          },
        _ => null,
      };
    });
    messenger.setMockStreamHandler(
        scannerEvents, MockStreamHandler.inline(onListen: (_, __) {}));
    addTearDown(() {
      messenger.setMockMethodCallHandler(scannerMethods, null);
      messenger.setMockStreamHandler(scannerEvents, null);
    });

    final api = ApiClient(MockClient(backend), prefs);
    final classes = ClassRepositoryImpl(ClassesApiService(api, FakeDeviceId()));
    controller = ScrollController();
    addTearDown(controller.dispose);

    final router = GoRouter(
      initialLocation: '/home/class/k1',
      initialExtra:
          ClassDetailPageExtra(classEntity: ClassEntity.fromJson(kelas())),
      routes: [
        GoRoute(
          path: '/qr-scan',
          name: 'qr-scan',
          builder: (_, state) =>
              QrScanPage(qrScanPageExtra: state.extra as QrScanPageExtra),
        ),
        ShellRoute(
          builder: (context, state, child) => shellWithNavbar(
            title: 'Detail Kelas',
            controller: controller,
            child: child,
          ),
          routes: [
            GoRoute(
              path: '/home',
              name: 'home',
              builder: (_, __) => const Text('Halaman Beranda'),
              routes: [
                GoRoute(
                  path: 'class/:id',
                  name: 'class',
                  builder: (_, state) => ClassDetailPage(
                    classDetailPageExtra: state.extra as ClassDetailPageExtra,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UserMeetingsBloc(GetUserMeetingsDataUsecase(classes)),
        ),
        BlocProvider(
          create: (_) => ClassmatesBloc(GetClassmatesUsecase(classes)),
        ),
        BlocProvider(
          create: (_) => UserRegisteredClassBloc(
              GetUserRegisteredClassesUseCase(classes)),
        ),
        BlocProvider(
          create: (_) =>
              UserAttendancesBloc(AddUserAttendancesUsecase(classes)),
        ),
      ],
      child: MaterialApp.router(
        theme: ThemeData(fontFamily: realFontFamily),
        routerConfig: router,
      ),
    ));
    await settle(tester);
  }

  Finder rowOf(String title) => find
      .ancestor(of: find.text(title), matching: find.byType(Row))
      .first;

  Finder actionOf(String title) =>
      find.descendant(of: rowOf(title), matching: find.byType(InkWell)).last;

  Future<void> openScanner(WidgetTester tester) async {
    await openDetail(tester);
    await tester.tap(actionOf('Pertemuan 3'));
    await settle(tester);
    expect(find.byType(QrScanPage), findsOneWidget);
  }

  void scan(WidgetTester tester) =>
      tester.widget<MobileScanner>(find.byType(MobileScanner)).onDetect!(
        const BarcodeCapture(
          barcodes: [Barcode(rawValue: 'token-qr', displayValue: 'token-qr')],
        ),
      );

  Finder scanFrame() => find.byWidgetPredicate((widget) =>
      widget is Container &&
      widget.constraints == BoxConstraints.tight(const Size(300, 300)));

  group('Detail Kelas', () {
    testWidgets(
        '14 pertemuan di HP 360×640: seluruh halaman yang digeser, pertemuan terakhir bisa sampai di atas menu bawah',
        (tester) async {
      meetings = [for (var i = 1; i <= 14; i++) meeting(i)];
      await openDetail(tester);

      expect(controller.position.maxScrollExtent, greaterThan(0));
      for (final element in find.byType(Scrollable).evaluate()) {
        final position =
            ((element as StatefulElement).state as ScrollableState).position;
        if (position != controller.position &&
            position.axis == Axis.vertical) {
          expect(position.maxScrollExtent, 0,
              reason: 'tidak boleh ada kotak geser di dalam halaman');
        }
      }

      await scrollEverythingToEnd(tester);
      expect(tester.getRect(rowOf('Pertemuan 1')).bottom,
          lessThanOrEqualTo(navbarTop(tester)));
    });

    testWidgets(
        '14 pertemuan di HP tinggi 411×891: layar terisi, bukan kotak kecil berisi 5 baris',
        (tester) async {
      meetings = [for (var i = 1; i <= 14; i++) meeting(i)];
      await openDetail(tester, size: const Size(411, 891));

      final visible = [
        for (var i = 1; i <= 14; i++)
          if (tester.getRect(rowOf('Pertemuan $i')).bottom <=
              navbarTop(tester))
            i
      ];
      expect(visible.length, greaterThanOrEqualTo(7));
    });

    testWidgets(
        'kartu kelas: nama dosen panjang dipotong "…" dan huruf HP 1,3× tidak memotong kartu',
        (tester) async {
      lecturer = longLecturer;
      await openDetail(tester, textScale: 1.3);

      expect(tester.takeException(), isNull);
      final text = tester.widget<Text>(find.text(longLecturer));
      expect(text.maxLines, 1);
      expect(text.overflow, TextOverflow.ellipsis);
      expect(find.text('07.00 - 08.40'), findsOneWidget);
    });

    testWidgets('judul pertemuan 50 huruf dipotong "…", baris tidak meluap',
        (tester) async {
      meetings = [meeting(1, name: longTitle)];
      await openDetail(tester);

      expect(tester.takeException(), isNull);
      final text = tester.widget<Text>(find.text(longTitle));
      expect(text.maxLines, 1);
      expect(text.overflow, TextOverflow.ellipsis);
    });

    testWidgets(
        'sesi yang sedang dibuka: tombol "Scan QR" hanya di pertemuan terbuka yang belum presensi',
        (tester) async {
      meetings = [
        meeting(1),
        meeting(2, open: true, attended: true),
        meeting(3, open: true),
      ];
      await openDetail(tester);

      expect(find.text('Scan QR'), findsOneWidget);
      expect(
          find.descendant(
              of: rowOf('Pertemuan 3'), matching: find.text('Scan QR')),
          findsOneWidget);

      await tester.tap(find.text('Scan QR'));
      await settle(tester);
      expect(find.byType(QrScanPage), findsOneWidget);
    });

    testWidgets(
        'pertemuan yang sesinya tidak dibuka: "Sesi presensi sedang tidak dibuka."',
        (tester) async {
      await openDetail(tester);

      await tester.tap(actionOf('Pertemuan 1'));
      await tester.pump();

      expect(find.text('Sesi presensi sedang tidak dibuka.'), findsOneWidget);
      expect(find.textContaining('belum dibuka'), findsNothing);
      expect(find.byType(QrScanPage), findsNothing);
    });

    testWidgets(
        'server mati: tab Presensi dan Classmates punya Coba lagi yang memuat ulang',
        (tester) async {
      down = {'/meeting/k1', '/class/k1/classmates'};
      await openDetail(tester);

      expect(find.text(offline), findsOneWidget);
      down.clear();
      await tester.tap(find.text('Coba lagi'));
      await settle(tester);
      expect(find.text('Pertemuan 3'), findsOneWidget);

      await tester.tap(find.text('Classmates'));
      await tester.pumpAndSettle();
      expect(find.text(offline), findsOneWidget);
      await tester.tap(find.text('Coba lagi'));
      await settle(tester);
      expect(find.text('Budi Santoso'), findsOneWidget);
    });
  });

  group('Scan QR', () {
    testWidgets(
        'sedang mencatat presensi: ketukan di luar dan tombol kembali HP diabaikan, lalu kembali ke Detail Kelas',
        (tester) async {
      await openScanner(tester);

      holdAttendance = Completer<void>();
      scan(tester);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.byType(CustomLoadingIndicator), findsOneWidget);

      await tester.tapAt(const Offset(200, 300));
      await tester.pump(const Duration(milliseconds: 300));
      await tester.binding.handlePopRoute();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.byType(CustomLoadingIndicator), findsOneWidget);
      expect(find.byType(QrScanPage), findsOneWidget);

      holdAttendance!.complete();
      await settle(tester);

      expect(tester.takeException(), isNull);
      expect(attendancePosts, hasLength(1));
      expect(find.byType(QrScanPage), findsNothing);
      expect(find.byType(ClassDetailPage), findsOneWidget);
      expect(find.text('Halaman Beranda'), findsNothing);
      expect(find.text('Presensi berhasil'), findsOneWidget);
      expect(find.text('Scan QR'), findsNothing);
    });

    testWidgets(
        'izin kamera ditolak: pesan berbahasa Indonesia, Coba lagi menyalakan kamera',
        (tester) async {
      cameraAllowed = false;
      await openScanner(tester);

      expect(find.text('Camera permission denied.'), findsNothing);
      expect(
          find.text(
              'Izin kamera ditolak. Izinkan Kamera untuk SILAB di Pengaturan HP, lalu tekan Coba lagi.'),
          findsOneWidget);
      expect(scanFrame(), findsNothing);

      cameraAllowed = true;
      await tester.tap(find.text('Coba lagi'));
      await settle(tester);

      expect(find.textContaining('Izin kamera ditolak'), findsNothing);
      expect(scanFrame(), findsOneWidget);
    });

    testWidgets(
        'HP 360×640: tombol kembali di kiri atas, tidak menimpa bingkai scan',
        (tester) async {
      await openScanner(tester);

      final back = tester.getRect(find.byIcon(Boxicons.bx_chevron_left));
      final frame = tester.getRect(scanFrame());
      expect(back.overlaps(frame), isFalse);
      expect(back.bottom, lessThanOrEqualTo(frame.top));

      await tester.tap(find.byIcon(Boxicons.bx_chevron_left));
      await settle(tester);
      expect(find.byType(QrScanPage), findsNothing);
      expect(find.byType(ClassDetailPage), findsOneWidget);
    });
  });
}
