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
import 'package:silab/features/select_subjects/data/data_sources/selected_subject_api_service.dart';
import 'package:silab/features/select_subjects/data/repository/selected_subject_repository_impl.dart';
import 'package:silab/features/select_subjects/domain/usecases/add_user_selected_subject_usecase.dart';
import 'package:silab/features/select_subjects/domain/usecases/get_user_selected_subject_usecase.dart';
import 'package:silab/features/select_subjects/presentation/bloc/add_selected_subject/add_selected_subject_bloc.dart';
import 'package:silab/features/select_subjects/presentation/bloc/selected_subject_by_nim/selected_subject_by_nim_bloc.dart';
import 'package:silab/features/select_subjects/presentation/pages/daftar_praktikum_page.dart';
import 'package:silab/features/select_subjects/presentation/pages/ringkasan_daftar_page.dart';
import 'package:silab/features/subjects/data/data_sources/subject_api_service.dart';
import 'package:silab/features/subjects/data/repository/subject_repository_impl.dart';
import 'package:silab/features/subjects/domain/usecases/get_subject_list_usecase.dart';
import 'package:silab/features/subjects/presentation/bloc/subject_list/subject_list_bloc.dart';

import '../../helpers/real_font.dart';

const offered = 'Tidak ada praktikum yang ditawarkan';

Map<String, dynamic> subject(int i) => {
      'id': 's$i',
      'subject_name': 'Praktikum Mata Kuliah Nomor $i',
      'subject_code': '55331000$i',
      'semester': '1',
    };

void main() {
  late SharedPreferences prefs;
  late List<http.Request> posts;
  late int subjectCount;
  late bool subjectsDown;
  late Set<String> registered;
  Completer<void>? holdPost;

  setUpAll(loadRealFont);

  setUp(() async {
    AppConfig.create(baseUrl: 'http://silab.test');
    SharedPreferences.setMockInitialValues(
        {'accessToken': 'akses', 'refreshToken': 'segar'});
    prefs = await SharedPreferences.getInstance();
    posts = [];
    subjectCount = 3;
    subjectsDown = false;
    registered = {};
    holdPost = null;
  });

  http.Response ok(Object? data, [String message = 'Berhasil']) =>
      http.Response(
          jsonEncode({'status': true, 'message': message, 'data': data}), 200);

  Future<http.Response> backend(http.Request request) async {
    final path = request.url.path;

    if (path == '/subject') {
      if (subjectsDown) throw http.ClientException('Connection refused');
      return ok([for (var i = 1; i <= subjectCount; i++) subject(i)]);
    }

    if (path == '/activation' && request.method == 'GET') {
      return ok([
        for (final id in registered)
          {
            'id': 'a-$id',
            'status': false,
            'created_at': '2026-09-30T02:00:00.000Z',
            'subject_id': id,
            'subjects': [
              {'subject_name': 'Terdaftar $id', 'semester': '1'}
            ],
            'registered_class': null,
            'available_classes': [],
          }
      ]);
    }

    if (path == '/activation' && request.method == 'POST') {
      posts.add(request);
      await holdPost?.future;
      final ids =
          (jsonDecode(request.body)['subjectIds'] as List).cast<String>();
      if (ids.any(registered.contains)) {
        return http.Response(
            jsonEncode({
              'status': false,
              'message': 'Mata kuliah berikut sudah pernah didaftarkan: X'
            }),
            409);
      }
      registered.addAll(ids);
      return ok(null, 'Pendaftaran mata kuliah berhasil');
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

  Future<void> openPage(WidgetTester tester) async {
    tester.view.physicalSize = const Size(360, 640) * 3;
    tester.view.devicePixelRatio = 3;
    tester.view.padding = const FakeViewPadding(top: 24 * 3);
    addTearDown(tester.view.reset);

    final api = ApiClient(MockClient(backend), prefs);
    final selected =
        SelectedSubjectRepositoryImpl(SelectedSubjectApiService(api));
    final router = GoRouter(initialLocation: '/home/daftar', routes: [
      ShellRoute(
        builder: (context, state, child) => Scaffold(
          appBar: AppBar(title: const Text('Pendaftaran Praktikum')),
          body: SafeArea(child: SingleChildScrollView(child: child)),
        ),
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (_, __) => const Text('Beranda'),
            routes: [
              GoRoute(
                path: 'daftar',
                name: 'daftar-praktikum',
                builder: (_, __) => const DaftarPraktikumPage(),
              ),
              GoRoute(
                path: 'ringkasan',
                name: 'ringkasan-praktikum',
                builder: (_, state) => RingkasanDaftarPage(
                  ringkasanDaftarPageExtra:
                      state.extra as RingkasanDaftarPageExtra,
                ),
              ),
              GoRoute(
                path: 'payment-status',
                name: 'payment-status',
                builder: (_, __) => const Text('Halaman Pembayaran'),
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
          create: (_) => SubjectListBloc(GetSubjectListUseCase(
              SubjectRepositoryImpl(SubjectApiService(api)))),
        ),
        BlocProvider(
          create: (_) => SelectedSubjectByNimBloc(
              GetSelectedSubjectByNimUsecase(selected)),
        ),
        BlocProvider(
          create: (_) =>
              AddSelectedSubjectBloc(AddSelectedSubjectUseCase(selected)),
        ),
      ],
      child: MaterialApp.router(
        theme: ThemeData(fontFamily: realFontFamily),
        routerConfig: router,
      ),
    ));
    await settle(tester);
  }

  Finder tile(int i) => find.ancestor(
        of: find.text('Praktikum Mata Kuliah Nomor $i'),
        matching: find.byType(CheckboxListTile),
      );

  Future<void> goToSummaryWith(WidgetTester tester, int i) async {
    await tester.tap(tile(i));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Selanjutnya'));
    await tester.pumpAndSettle();
    expect(find.text('Rp5.000'), findsOneWidget);
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();
    expect(find.text('Simpan Pendaftaran'), findsOneWidget);
  }

  testWidgets(
      'banyak mata kuliah di HP kecil: halaman bisa digeser jari sampai Selanjutnya',
      (tester) async {
    subjectCount = 9;
    await openPage(tester);

    expect(tester.takeException(), isNull);
    await tester.tap(tile(1));
    await tester.pumpAndSettle();
    expect(tester.getRect(find.text('Selanjutnya')).top, greaterThan(640));

    await tester.drag(tile(3), const Offset(0, -600));
    await tester.pumpAndSettle();

    final button = tester.getRect(find.text('Selanjutnya'));
    expect(button.bottom, lessThanOrEqualTo(640));
    await tester.tap(find.text('Selanjutnya'));
    await tester.pumpAndSettle();
    expect(find.byType(RingkasanDaftarPage), findsOneWidget);
  });

  testWidgets(
      'server mati: "Gagal memuat mata kuliah." dengan Coba lagi, bukan "tidak ditawarkan"',
      (tester) async {
    subjectsDown = true;
    await openPage(tester);

    expect(find.text(offered), findsNothing);
    expect(find.text('Gagal memuat mata kuliah.'), findsOneWidget);

    subjectsDown = false;
    await tester.tap(find.text('Coba lagi'));
    await settle(tester);

    expect(find.text('Gagal memuat mata kuliah.'), findsNothing);
    expect(find.text('Praktikum Mata Kuliah Nomor 1'), findsOneWidget);
  });

  testWidgets(
      'mata kuliah yang sudah didaftarkan tercentang, tidak bisa diubah, dan bertanda',
      (tester) async {
    registered = {'s1'};
    await openPage(tester);

    final done = tester.widget<CheckboxListTile>(tile(1));
    expect(done.value, isTrue);
    expect(done.onChanged, isNull);
    expect(find.text('553310001 · Sudah didaftarkan'), findsOneWidget);

    final open = tester.widget<CheckboxListTile>(tile(2));
    expect(open.value, isFalse);
    expect(open.onChanged, isNotNull);
    expect(find.text('553310002'), findsOneWidget);

    await tester.tap(tile(1));
    await tester.pumpAndSettle();
    expect(tester.widget<CheckboxListTile>(tile(1)).value, isTrue);
    final next = find.ancestor(
        of: find.text('Selanjutnya'), matching: find.byType(ElevatedButton));
    expect(tester.widget<ElevatedButton>(next.first).onPressed, isNull);
  });

  testWidgets(
      'Simpan ditekan berkali-kali: satu permintaan, tombol terkunci, lalu ke Pembayaran tanpa pesan merah',
      (tester) async {
    await openPage(tester);
    await goToSummaryWith(tester, 2);

    holdPost = Completer<void>();
    await tester.tap(find.text('Simpan').last);
    await tester.pump();

    expect(find.text('Menyimpan...'), findsOneWidget);
    for (final label in ['Menyimpan...', 'Kembali']) {
      await tester.tap(find.text(label), warnIfMissed: false);
      await tester.pump();
    }
    await tester.tapAt(const Offset(10, 10));
    await tester.pump();
    expect(find.text('Simpan Pendaftaran'), findsOneWidget);

    holdPost!.complete();
    await settle(tester);

    expect(tester.takeException(), isNull);
    expect(posts, hasLength(1));
    expect(jsonDecode(posts.single.body), {
      'subjectIds': ['s2']
    });
    expect(find.text('Halaman Pembayaran'), findsOneWidget);
    expect(find.text('Silakan Lanjutkan Proses Pembayaran'), findsOneWidget);
    expect(find.textContaining('sudah pernah didaftarkan'), findsNothing);
  });

  testWidgets(
      'penolakan server: dialog tertutup, pesan merah, tetap di Ringkasan',
      (tester) async {
    await openPage(tester);
    await goToSummaryWith(tester, 3);
    registered.add('s3');

    await tester.tap(find.text('Simpan').last);
    await settle(tester);

    expect(tester.takeException(), isNull);
    expect(find.text('Simpan Pendaftaran'), findsNothing);
    expect(find.text('Mata kuliah berikut sudah pernah didaftarkan: X'),
        findsOneWidget);
    expect(find.byType(RingkasanDaftarPage), findsOneWidget);
  });
}
