import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silab/app_config.dart';
import 'package:silab/core/common/entities/bottom_navbar/bottom_navbar_entity.dart';
import 'package:silab/core/common/entities/class/class_entity.dart';
import 'package:silab/core/common/widgets/custom_bottom_navbar.dart';
import 'package:silab/core/network/api_client.dart';
import 'package:silab/features/announcement/data/data_sources/announcement_api_service.dart';
import 'package:silab/features/announcement/data/repository/announcement_repository_impl.dart';
import 'package:silab/features/announcement/domain/usecases/get_all_announcements_usecase.dart';
import 'package:silab/features/announcement/presentation/blocs/get_all_announcements/get_all_announcements_bloc.dart';
import 'package:silab/features/classes/data/data_sources/classes_api_service.dart';
import 'package:silab/features/classes/data/repository/class_repository_impl.dart';
import 'package:silab/features/classes/domain/usecases/get_user_registered_classes_usecase.dart';
import 'package:silab/features/classes/presentation/bloc/user_registered_class/user_registered_class_bloc.dart';
import 'package:silab/features/classes/presentation/widgets/registered_class_card.dart';
import 'package:silab/features/home/presentation/home_page.dart';
import 'package:silab/features/select_subjects/data/data_sources/selected_subject_api_service.dart';
import 'package:silab/features/select_subjects/data/repository/selected_subject_repository_impl.dart';
import 'package:silab/features/select_subjects/domain/usecases/get_user_class_option_by_paid_subject_usecase.dart';
import 'package:silab/features/select_subjects/presentation/bloc/user_class_option_by_paid_subject/user_class_option_by_paid_subject_bloc.dart';
import 'package:silab/features/user_details/data/data_sources/user_api_service.dart';
import 'package:silab/features/user_details/data/repositories/user_repository_impl.dart';
import 'package:silab/features/user_details/domain/usecases/get_user_details_usecase.dart';
import 'package:silab/features/user_details/presentation/bloc/user_details_bloc.dart';
import 'package:silab/features/user_details/presentation/widgets/user_welcome_widget.dart';

import '../../helpers/real_font.dart';

const offline = 'Tidak dapat terhubung ke server. Periksa koneksi internet.';
const longLecturer = 'Dr. Ir. Budi Santoso Wibowo, S.T., M.Kom., IPM.';
const emptyClasses =
    'Belum ada kelas. Kelas muncul di sini setelah pembayaran dikonfirmasi dan kelas dipilih.';

Map<String, dynamic> kelas(String id, String subject, String lecturer) => {
      'id': id,
      'subject_name': subject,
      'subject_class': 'A',
      'lecturer': lecturer,
      'day': 'MONDAY',
      'session_time': '07.00 - 08.40',
    };

Map<String, dynamic> pengumuman(String id, String type) => {
      'id': id,
      'title': 'Pengumuman $id',
      'type': type,
      'body': 'Isi pengumuman $id.',
      'created_at': '2026-09-30T02:00:00.000Z',
      'author': 'Laboran Uji',
    };

void main() {
  late SharedPreferences prefs;
  late Set<String> down;
  late List<Map<String, dynamic>> announcements;
  late List<Map<String, dynamic>> classes;

  setUpAll(loadRealFont);

  setUp(() async {
    AppConfig.create(baseUrl: 'http://silab.test');
    SharedPreferences.setMockInitialValues(
        {'accessToken': 'akses', 'refreshToken': 'segar'});
    prefs = await SharedPreferences.getInstance();
    down = {};
    announcements = [
      pengumuman('p1', 'BASIC'),
      pengumuman('p2', 'PRACTICUM'),
      pengumuman('p3', 'ASSISTANT'),
    ];
    classes = [kelas('k1', 'Basis Data', 'Dosen001')];
  });

  Future<http.Response> backend(http.Request request) async {
    final path = request.url.path;
    if (down.contains(path) || down.contains('*')) {
      throw http.ClientException('Connection refused');
    }
    http.Response ok(Object data) => http.Response(
        jsonEncode({'status': true, 'message': 'Berhasil', 'data': data}), 200);
    return switch (path) {
      '/auth/me' => ok({'nim': '2200018123', 'name': 'Budi Santoso'}),
      '/announcement' => ok(announcements),
      '/class/me' => ok(classes),
      '/class/registration' => ok([]),
      _ => http.Response('{"status":false,"message":"Not Found"}', 404),
    };
  }

  Future<void> settle(WidgetTester tester) async {
    for (var i = 0; i < 5; i++) {
      await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 20)));
      await tester.pump(const Duration(milliseconds: 100));
    }
    await tester.pumpAndSettle();
  }

  Future<void> openBeranda(WidgetTester tester) async {
    tester.view.physicalSize = const Size(360, 640) * 3;
    tester.view.devicePixelRatio = 3;
    tester.view.padding = const FakeViewPadding(top: 24 * 3, bottom: 16 * 3);
    addTearDown(tester.view.reset);

    final api = ApiClient(MockClient(backend), prefs);
    final controller = ScrollController();
    addTearDown(controller.dispose);

    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => GetAllAnnouncementsBloc(GetAllAnnouncementsUseCase(
                AnnouncementRepositoryImpl(AnnouncementApiService(api))))),
        BlocProvider(
            create: (_) => UserRegisteredClassBloc(
                GetUserRegisteredClassesUseCase(
                    ClassRepositoryImpl(ClassesApiService(api))))),
        BlocProvider(
            create: (_) => UserClassOptionByPaidSubjectBloc(
                GetUserClassOptionByPaidSubjectUsecase(
                    SelectedSubjectRepositoryImpl(
                        SelectedSubjectApiService(api))))),
        BlocProvider(
            create: (_) => UserDetailsBloc(GetUserDetailsUseCase(
                UserRepositoryImpl(UserApiService(api))))),
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: realFontFamily),
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const UserWelcomeWidget(),
            forceMaterialTransparency: true,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              controller: controller,
              child: const HomePage(),
            ),
          ),
          extendBody: true,
          floatingActionButton: CustomBottomNavbar(
            isVisible: true,
            currentIndex: 0,
            items: [
              for (final (icon, label) in [
                ('home', 'Beranda'),
                ('schedule', 'Jadwal'),
                ('profile', 'Profil'),
              ])
                BottomNavbarEntity(
                  icon: SvgPicture.asset('assets/image/$icon.svg'),
                  iconActive:
                      SvgPicture.asset('assets/image/${icon}_active.svg'),
                  label: label,
                ),
            ],
            scrollController: controller,
            onTap: (_) {},
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    ));
    await settle(tester);
  }

  double navbarTop(WidgetTester tester) =>
      tester.getRect(find.byType(CustomBottomNavbar)).top;

  List<double> dotSizes(WidgetTester tester) => find
      .byType(AnimatedContainer)
      .evaluate()
      .map((e) => (e.widget as AnimatedContainer).constraints!.maxWidth)
      .toList();

  testWidgets('nama dosen panjang dipotong "…", kartu kelas tidak meluap',
      (tester) async {
    tester.view.physicalSize = const Size(360, 640) * 3;
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(fontFamily: realFontFamily),
      home: const Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: RegisteredClassCard(
            classEntity: ClassEntity(
              id: 'k1',
              subject_name: 'Interaksi Manusia dan Komputer Lanjutan',
              subject_class: 'A',
              lecturer: longLecturer,
              day: 'MONDAY',
              session_time: '07.00 - 08.40',
            ),
          ),
        ),
      ),
    ));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);

    final lecturer = tester.widget<Text>(find.text(longLecturer));
    expect(lecturer.maxLines, 1);
    expect(lecturer.overflow, TextOverflow.ellipsis);

    final card = tester.getRect(find.byType(RegisteredClassCard));
    final arrow = tester.getRect(find.byType(Image).last);
    expect(tester.getRect(find.text(longLecturer)).right,
        lessThanOrEqualTo(arrow.left));
    expect(arrow.right, lessThanOrEqualTo(card.right));
  });

  testWidgets('huruf HP 1,3×: kartu kelas memanjang, tidak terpotong',
      (tester) async {
    tester.view.physicalSize = const Size(360, 640) * 3;
    tester.view.devicePixelRatio = 3;
    tester.platformDispatcher.textScaleFactorTestValue = 1.3;
    addTearDown(tester.view.reset);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(fontFamily: realFontFamily),
      home: const Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: RegisteredClassCard(
            classEntity: ClassEntity(
              id: 'k1',
              subject_name: 'Basis Data',
              subject_class: 'A',
              lecturer: 'Dosen001',
              day: 'MONDAY',
              session_time: '07.00 - 08.40',
            ),
          ),
        ),
      ),
    ));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(tester.getRect(find.byType(RegisteredClassCard)).height,
        greaterThan(120));
  });

  testWidgets(
      'server mati: pesan asli tanpa bahasa Inggris, tiap bagian punya "Coba lagi" yang terlihat',
      (tester) async {
    down.add('*');
    await openBeranda(tester);

    expect(tester.takeException(), isNull);
    expect(find.text('An Error Occurred!'), findsNothing);
    expect(find.text('Retry'), findsNothing);
    expect(find.text(offline), findsOneWidget);

    expect(find.text('Gagal memuat pengumuman.'), findsOneWidget);
    expect(find.text('Gagal memuat kelas.'), findsOneWidget);
    expect(find.text('Coba lagi'), findsNWidgets(2));
    for (final button in find.text('Coba lagi').evaluate()) {
      expect(tester.getRect(find.byWidget(button.widget)).bottom,
          lessThan(navbarTop(tester)));
    }

    down.clear();
    ScaffoldMessenger.of(tester.element(find.byType(HomePage)))
        .removeCurrentSnackBar();
    await tester.tap(find.text('Coba lagi').last);
    await settle(tester);

    expect(find.text('Gagal memuat kelas.'), findsNothing);
    expect(find.text('Basis Data'), findsOneWidget);
  });

  testWidgets('data akun gagal dimuat: pesan asli dan tombol "Ulangi"',
      (tester) async {
    down.add('/auth/me');
    await openBeranda(tester);

    expect(find.text(offline), findsOneWidget);
    expect(find.text('Ulangi'), findsOneWidget);

    down.clear();
    await tester.tap(find.text('Ulangi'));
    await settle(tester);

    expect(find.text('Budi Santoso'), findsOneWidget);
  });

  testWidgets(
      'belum punya kelas: pesan terbaca utuh di atas menu bawah pada layar 360×640',
      (tester) async {
    classes = [];
    await openBeranda(tester);

    expect(tester.takeException(), isNull);
    expect(find.textContaining('Oops'), findsNothing);
    expect(tester.getRect(find.text(emptyClasses)).bottom,
        lessThanOrEqualTo(navbarTop(tester)));
  });

  testWidgets(
      'pengumuman yang sedang dilihat dihapus: titik penanda pindah ke halaman yang tampil',
      (tester) async {
    await openBeranda(tester);

    await tester.drag(find.byType(PageView), const Offset(-500, 0));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(PageView), const Offset(-500, 0));
    await tester.pumpAndSettle();
    expect(dotSizes(tester), [4, 4, 6]);

    announcements.removeLast();
    tester
        .element(find.byType(HomePage))
        .read<GetAllAnnouncementsBloc>()
        .add(RefreshAllAnnouncements());
    await settle(tester);

    expect(find.text('Pengumuman p2'), findsOneWidget);
    expect(dotSizes(tester), [4, 6]);
  });
}
