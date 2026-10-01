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
import 'package:silab/features/classes/domain/usecases/get_classmates_usecase.dart';
import 'package:silab/features/classes/domain/usecases/get_user_meetings_data_usecase.dart';
import 'package:silab/features/classes/domain/usecases/get_user_registered_classes_usecase.dart';
import 'package:silab/features/classes/presentation/bloc/classmates/classmates_bloc.dart';
import 'package:silab/features/classes/presentation/bloc/user_meetings/user_meetings_bloc.dart';
import 'package:silab/features/classes/presentation/bloc/user_registered_class/user_registered_class_bloc.dart';
import 'package:silab/features/classes/presentation/pages/class_detail_page.dart';
import 'package:silab/features/schedule/data/data_sources/schedule_api_service.dart';
import 'package:silab/features/schedule/data/repository/schedule_repository_impl.dart';
import 'package:silab/features/schedule/domain/usecases/get_user_schedule_usecase.dart';
import 'package:silab/features/schedule/presentation/bloc/user_schedule_bloc.dart';
import 'package:silab/features/schedule/presentation/pages/schedule_page.dart';

import '../../helpers/real_font.dart';
import '../../helpers/small_phone_shell.dart';

const days = [
  'MONDAY',
  'TUESDAY',
  'WEDNESDAY',
  'THURSDAY',
  'FRIDAY',
  'SATURDAY'
];

Map<String, dynamic> kelas(int number, String day,
        {String time = '07.00 - 08.40', String room = 'PSI'}) =>
    {
      'id': 'k$number',
      'subject_name': 'Mata Kuliah $number',
      'subject_class': 'A',
      'lecturer': 'Dosen001',
      'day': day,
      'session_time': time,
      'room': room,
    };

void main() {
  late SharedPreferences prefs;
  late List<Map<String, dynamic>> classes;
  late List<Map<String, dynamic>> assisted;
  late bool down;

  setUpAll(loadRealFont);

  setUp(() async {
    AppConfig.create(baseUrl: 'http://silab.test');
    SharedPreferences.setMockInitialValues(
        {'accessToken': 'akses', 'refreshToken': 'segar'});
    prefs = await SharedPreferences.getInstance();
    classes = [kelas(1, 'MONDAY')];
    assisted = [];
    down = false;
  });

  http.Response ok(Object? data) => http.Response(
      jsonEncode({'status': true, 'message': 'Berhasil', 'data': data}), 200);

  Future<http.Response> backend(http.Request request) async {
    if (down) throw http.ClientException('Connection refused');

    return switch (request.url.path) {
      '/class/me' => ok(classes),
      '/class' => ok(assisted),
      '/meeting/k1' => ok([]),
      '/class/k1/classmates' => ok([]),
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

  Future<GoRouter> openSchedule(WidgetTester tester) async {
    useSmallPhone(tester);

    final api = ApiClient(MockClient(backend), prefs);
    final classRepository = ClassRepositoryImpl(ClassesApiService(api));
    final controller = ScrollController();
    addTearDown(controller.dispose);

    final router = GoRouter(
      navigatorKey: GlobalKey<NavigatorState>(),
      initialLocation: '/schedule',
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) => shellWithNavbar(
            title: 'Jadwal Praktikum',
            controller: controller,
            child: navigationShell,
          ),
          branches: [
            StatefulShellBranch(routes: [
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
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                path: '/schedule',
                name: 'schedule',
                builder: (_, __) => const SchedulePage(),
              ),
            ]),
          ],
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UserScheduleBloc(GetUserScheduleUsecase(
              ScheduleRepositoryImpl(ScheduleApiService(api)))),
        ),
        BlocProvider(
          create: (_) =>
              UserMeetingsBloc(GetUserMeetingsDataUsecase(classRepository)),
        ),
        BlocProvider(
          create: (_) => ClassmatesBloc(GetClassmatesUsecase(classRepository)),
        ),
        BlocProvider(
          create: (_) => UserRegisteredClassBloc(
              GetUserRegisteredClassesUseCase(classRepository)),
        ),
      ],
      child: MaterialApp.router(
        theme: ThemeData(fontFamily: realFontFamily),
        routerConfig: router,
      ),
    ));
    await settle(tester);
    return router;
  }

  Finder cardOf(String subject) =>
      find.ancestor(of: find.text(subject), matching: find.byType(InkWell));

  for (final dayCount in [4, 5, 6]) {
    testWidgets(
        'kelas di $dayCount hari (360×640): kartu terakhir bisa digeser sampai di atas menu bawah',
        (tester) async {
      classes = [
        for (var i = 1; i <= dayCount; i++) kelas(i, days[i - 1]),
      ];
      await openSchedule(tester);

      await scrollEverythingToEnd(tester);

      expect(tester.getRect(cardOf('Mata Kuliah $dayCount')).bottom,
          lessThanOrEqualTo(navbarTop(tester)));
    });
  }

  testWidgets('server mati: "Gagal memuat jadwal." dan Coba lagi memuat ulang',
      (tester) async {
    down = true;
    await openSchedule(tester);

    expect(find.text('Terjadi suatu kesalahan, coba lagi!'), findsNothing);
    expect(find.text('Gagal memuat jadwal.'), findsOneWidget);

    down = false;
    await tester.tap(find.text('Coba lagi'));
    await settle(tester);

    expect(find.text('Gagal memuat jadwal.'), findsNothing);
    expect(find.text('Mata Kuliah 1'), findsOneWidget);
  });

  testWidgets(
      'ketuk kartu: Detail Kelas terbuka dengan kolom Ruang, tombol kembali kembali ke Jadwal',
      (tester) async {
    final router = await openSchedule(tester);

    expect(find.text('07.00 - 08.40 · PSI'), findsOneWidget);

    await tester.tap(cardOf('Mata Kuliah 1'));
    await settle(tester);

    expect(find.byType(ClassDetailPage), findsOneWidget);
    expect(find.text('Ruang'), findsOneWidget);
    expect(find.text('PSI'), findsOneWidget);

    router.pop();
    await settle(tester);

    expect(find.byType(ClassDetailPage), findsNothing);
    expect(find.byType(SchedulePage), findsOneWidget);
    expect(find.text('Halaman Beranda'), findsNothing);
  });

  testWidgets(
      'kelas asisten: tampil bertanda Asisten, urut jam bersama kelas lain, tidak bisa diketuk',
      (tester) async {
    classes = [
      kelas(1, 'MONDAY', time: '07.00 - 08.40'),
      kelas(2, 'MONDAY', time: '13.00 - 14.40'),
    ];
    assisted = [
      {
        'id': 'k9',
        'name': 'B',
        'subject_name': 'Jaringan Komputer',
        'day': 'MONDAY',
        'startAt': '10.00',
        'endAt': '11.40',
        'room': 'SBTI',
      },
    ];
    await openSchedule(tester);

    expect(find.text('Asisten'), findsOneWidget);
    expect(find.text('10.00 - 11.40 · SBTI'), findsOneWidget);
    final tops = [
      for (final subject in [
        'Mata Kuliah 1',
        'Jaringan Komputer',
        'Mata Kuliah 2'
      ])
        tester.getRect(find.text(subject)).top,
    ];
    expect(tops, orderedEquals([...tops]..sort()));

    expect(tester.widget<InkWell>(cardOf('Jaringan Komputer')).onTap, isNull);
    expect(tester.widget<InkWell>(cardOf('Mata Kuliah 1')).onTap, isNotNull);

    await tester.tap(find.text('Jaringan Komputer'));
    await settle(tester);
    expect(find.byType(SchedulePage), findsOneWidget);
    expect(find.byType(ClassDetailPage), findsNothing);
  });
}
