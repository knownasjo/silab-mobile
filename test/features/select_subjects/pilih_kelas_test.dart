import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silab/app_config.dart';
import 'package:silab/core/network/api_client.dart';
import 'package:silab/features/classes/data/data_sources/classes_api_service.dart';
import 'package:silab/features/classes/data/repository/class_repository_impl.dart';
import 'package:silab/features/classes/domain/usecases/get_user_registered_classes_usecase.dart';
import 'package:silab/features/classes/presentation/bloc/user_registered_class/user_registered_class_bloc.dart';
import 'package:silab/features/select_subjects/data/data_sources/selected_subject_api_service.dart';
import 'package:silab/features/select_subjects/data/repository/selected_subject_repository_impl.dart';
import 'package:silab/features/select_subjects/domain/usecases/add_selected_class_usecase.dart';
import 'package:silab/features/select_subjects/domain/usecases/get_user_class_option_by_paid_subject_usecase.dart';
import 'package:silab/features/select_subjects/domain/usecases/get_user_selected_subject_usecase.dart';
import 'package:silab/features/select_subjects/presentation/bloc/add_selected_class/add_selected_class_bloc.dart';
import 'package:silab/features/select_subjects/presentation/bloc/selected_subject_by_nim/selected_subject_by_nim_bloc.dart';
import 'package:silab/features/select_subjects/presentation/bloc/user_class_option_by_paid_subject/user_class_option_by_paid_subject_bloc.dart';
import 'package:silab/features/select_subjects/presentation/bloc/user_class_option_by_paid_subject/user_class_option_by_paid_subject_event.dart';
import 'package:silab/features/select_subjects/presentation/pages/pilih_kelas_page.dart';

import '../../helpers/real_font.dart';
import '../../helpers/small_phone_shell.dart';

const confirmTitle = 'Simpan Pilihan Kelas';
const succeeded = 'Anda sudah terdaftar di kelas praktikum';
const warning =
    'Kelas yang sudah disimpan tidak bisa diganti sendiri. Hubungi laboran jika perlu pindah.';
const bdA = 'Senin, 07.00 - 08.40';
const bdB = 'Selasa, 07.00 - 08.40';
const jkA = 'Rabu, 13.00 - 14.40';

Map<String, dynamic> option(
  String id,
  String subject,
  String name,
  String day,
  String time,
) =>
    {
      'id': id,
      'subject_name': subject,
      'subject_class': name,
      'semester': '3',
      'session_time': time,
      'quota': 30,
      'registered_students': 5,
      'day': day,
    };

void main() {
  late SharedPreferences prefs;
  late List<Map<String, dynamic>> options;
  late List<http.Request> posts;
  late bool optionsDown;
  Completer<void>? holdGet;
  Completer<void>? holdPost;
  http.Response? rejection;
  void Function()? onPost;

  setUpAll(loadRealFont);

  setUp(() async {
    AppConfig.create(baseUrl: 'http://silab.test');
    SharedPreferences.setMockInitialValues(
        {'accessToken': 'akses', 'refreshToken': 'segar'});
    prefs = await SharedPreferences.getInstance();
    posts = [];
    optionsDown = false;
    holdGet = null;
    holdPost = null;
    rejection = null;
    onPost = null;
    options = [
      option('bd-a', 'Basis Data', 'A', 'MONDAY', '07.00 - 08.40'),
      option('bd-b', 'Basis Data', 'B', 'TUESDAY', '07.00 - 08.40'),
      option('jk-a', 'Jaringan Komputer', 'A', 'WEDNESDAY', '13.00 - 14.40'),
    ];
  });

  http.Response ok(Object? data, [String message = 'Berhasil']) =>
      http.Response(
          jsonEncode({'status': true, 'message': message, 'data': data}), 200);

  Future<http.Response> backend(http.Request request) async {
    final path = request.url.path;

    if (path == '/class/registration' && request.method == 'GET') {
      await holdGet?.future;
      if (optionsDown) throw http.ClientException('Connection refused');
      return ok(options);
    }

    if (path == '/class/registration' && request.method == 'POST') {
      posts.add(request);
      await holdPost?.future;
      onPost?.call();
      return rejection ?? ok(null, 'Berhasil terdaftar di kelas yang dipilih');
    }

    if (path == '/activation' || path == '/class/me') return ok([]);

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

  Future<void> openPage(WidgetTester tester, {bool waitForData = true}) async {
    useSmallPhone(tester);

    final api = ApiClient(MockClient(backend), prefs);
    final subjects =
        SelectedSubjectRepositoryImpl(SelectedSubjectApiService(api));
    final controller = ScrollController();
    addTearDown(controller.dispose);

    final router = GoRouter(initialLocation: '/home/pilih-kelas', routes: [
      ShellRoute(
        builder: (context, state, child) => shellWithNavbar(
          title: 'Pilih Kelas',
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
                path: 'pilih-kelas',
                name: 'pilih-kelas',
                builder: (_, __) => const PilihKelasPage(),
              ),
            ],
          ),
        ],
      ),
    ]);
    addTearDown(router.dispose);

    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UserClassOptionByPaidSubjectBloc(
              GetUserClassOptionByPaidSubjectUsecase(subjects)),
        ),
        BlocProvider(
          create: (_) =>
              AddSelectedClassBloc(AddSelectedClassUseCase(subjects)),
        ),
        BlocProvider(
          create: (_) => SelectedSubjectByNimBloc(
              GetSelectedSubjectByNimUsecase(subjects)),
        ),
        BlocProvider(
          create: (_) => UserRegisteredClassBloc(
              GetUserRegisteredClassesUseCase(
                  ClassRepositoryImpl(ClassesApiService(api)))),
        ),
      ],
      child: MaterialApp.router(
        theme: ThemeData(fontFamily: realFontFamily),
        routerConfig: router,
      ),
    ));
    if (waitForData) await settle(tester);
  }

  Future<void> tapText(WidgetTester tester, String text) async {
    await tester.ensureVisible(find.text(text));
    await tester.pumpAndSettle();
    await tester.tap(find.text(text));
    await tester.pumpAndSettle();
  }

  Finder pageSave() => find.widgetWithText(ElevatedButton, 'Simpan');

  bool canSave(WidgetTester tester) =>
      tester.widget<ElevatedButton>(pageSave()).onPressed != null;

  Finder inDialog(String text) => find.descendant(
      of: find.byType(AlertDialog), matching: find.text(text));

  Finder radioOf(String classId) => find.byWidgetPredicate(
      (widget) => widget is Radio<String?> && widget.value == classId);

  Future<void> openConfirmation(WidgetTester tester) async {
    await tester.ensureVisible(pageSave());
    await tester.pumpAndSettle();
    await tester.tap(pageSave());
    await tester.pumpAndSettle();
    expect(find.text(confirmTitle), findsOneWidget);
  }

  void refreshOptions(WidgetTester tester) => tester
      .element(find.byType(PilihKelasPage))
      .read<UserClassOptionByPaidSubjectBloc>()
      .add(RefreshUserClassOptionByPaidSubject());

  testWidgets(
      'konfirmasi menampilkan kelas yang dipilih dan peringatan tidak bisa diganti sendiri',
      (tester) async {
    await openPage(tester);
    await tapText(tester, bdA);
    await tapText(tester, jkA);
    await openConfirmation(tester);

    expect(inDialog('Basis Data'), findsOneWidget);
    expect(inDialog('Kelas A · $bdA'), findsOneWidget);
    expect(inDialog('Jaringan Komputer'), findsOneWidget);
    expect(inDialog('Kelas A · $jkA'), findsOneWidget);
    expect(inDialog('Kelas B · $bdB'), findsNothing);
    expect(inDialog(warning), findsOneWidget);
  });

  testWidgets(
      'Simpan ditekan berkali-kali: satu kiriman, "Menyimpan...", dialog tidak bisa ditutup',
      (tester) async {
    await openPage(tester);
    await tapText(tester, bdA);
    await openConfirmation(tester);

    holdPost = Completer<void>();
    await tester.tap(inDialog('Simpan'));
    await tester.pump();

    expect(inDialog('Menyimpan...'), findsOneWidget);
    for (final label in ['Menyimpan...', 'Kembali']) {
      await tester.tap(inDialog(label), warnIfMissed: false);
      await tester.pump();
    }
    await tester.tapAt(const Offset(10, 10));
    await tester.pump();
    await tester.binding.handlePopRoute();
    await tester.pump();
    expect(find.text(confirmTitle), findsOneWidget);

    holdPost!.complete();
    await settle(tester);

    expect(tester.takeException(), isNull);
    expect(posts, hasLength(1));
    expect(jsonDecode(posts.single.body), {
      'classIds': ['bd-a']
    });
    expect(find.text(succeeded), findsOneWidget);
  });

  testWidgets(
      'dialog Berhasil: ketuk di luar tidak menutup, tombol kembali sama dengan OK',
      (tester) async {
    await openPage(tester);
    await tapText(tester, bdA);
    await openConfirmation(tester);
    await tester.tap(inDialog('Simpan'));
    await settle(tester);
    expect(find.text(succeeded), findsOneWidget);

    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();
    expect(find.text(succeeded), findsOneWidget);
    expect(find.byType(PilihKelasPage), findsOneWidget);

    await tester.binding.handlePopRoute();
    await settle(tester);

    expect(tester.takeException(), isNull);
    expect(find.text(succeeded), findsNothing);
    expect(find.byType(PilihKelasPage), findsNothing);
    expect(find.text('Halaman Beranda'), findsOneWidget);
  });

  testWidgets(
      'server menolak: dialog tertutup, pesan merah terlihat, daftar kelas dimuat ulang',
      (tester) async {
    await openPage(tester);
    await tapText(tester, bdA);
    await openConfirmation(tester);

    rejection = http.Response(
        jsonEncode(
            {'status': false, 'message': 'Kelas A Basis Data sudah penuh!'}),
        409);
    onPost = () => options[0]['registered_students'] = 30;
    await tester.tap(inDialog('Simpan'));
    await settle(tester);

    expect(tester.takeException(), isNull);
    expect(find.text(confirmTitle), findsNothing);
    expect(find.text('Kelas A Basis Data sudah penuh!'), findsOneWidget);
    expect(find.text('30/30'), findsOneWidget);
    expect(tester.widget<Radio<String?>>(radioOf('bd-a')).onChanged, isNull);
    expect(canSave(tester), isFalse);
  });

  testWidgets(
      'kelas yang dipilih dihapus atau penuh saat halaman terbuka: pilihannya dilepas',
      (tester) async {
    await openPage(tester);
    await tapText(tester, bdA);
    await tapText(tester, jkA);
    expect(canSave(tester), isTrue);

    options.removeAt(0);
    options.last['registered_students'] = 30;
    refreshOptions(tester);
    await settle(tester);

    expect(find.text(bdA), findsNothing);
    expect(tester.widget<Radio<String?>>(radioOf('jk-a')).groupValue, isNull);
    expect(canSave(tester), isFalse);

    await tapText(tester, bdB);
    await openConfirmation(tester);
    expect(inDialog('Kelas B · $bdB'), findsOneWidget);
    expect(inDialog('Jaringan Komputer'), findsNothing);
  });

  testWidgets(
      'ketuk lagi kelas yang sudah dipilih: pilihan batal, lewat lingkaran maupun baris',
      (tester) async {
    await openPage(tester);

    await tapText(tester, bdA);
    expect(tester.widget<Radio<String?>>(radioOf('bd-a')).groupValue, 'bd-a');

    await tester.tap(radioOf('bd-a'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(tester.widget<Radio<String?>>(radioOf('bd-a')).groupValue, isNull);
    expect(canSave(tester), isFalse);

    await tapText(tester, bdA);
    expect(canSave(tester), isTrue);
    await tapText(tester, bdA);
    expect(tester.widget<Radio<String?>>(radioOf('bd-a')).groupValue, isNull);
    expect(canSave(tester), isFalse);
  });

  testWidgets('sedang memuat: lingkaran berputar, bukan halaman kosong',
      (tester) async {
    holdGet = Completer<void>();
    await openPage(tester, waitForData: false);
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(pageSave(), findsNothing);

    holdGet!.complete();
    await settle(tester);

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text(bdA), findsOneWidget);
  });

  testWidgets('server mati: "Gagal memuat kelas." dan Coba lagi memuat ulang',
      (tester) async {
    optionsDown = true;
    await openPage(tester);

    expect(find.text('Gagal memuat kelas.'), findsOneWidget);
    expect(pageSave(), findsNothing);

    optionsDown = false;
    await tester.tap(find.text('Coba lagi'));
    await settle(tester);

    expect(find.text('Gagal memuat kelas.'), findsNothing);
    expect(find.text(bdA), findsOneWidget);
  });

  testWidgets('tidak ada kelas: keterangan tampil tanpa tombol Simpan',
      (tester) async {
    options = [];
    await openPage(tester);

    expect(find.text('Tidak ada kelas yang bisa dipilih.'), findsOneWidget);
    expect(pageSave(), findsNothing);
  });
}
