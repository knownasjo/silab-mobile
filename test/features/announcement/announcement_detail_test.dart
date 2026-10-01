import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silab/app_config.dart';
import 'package:silab/core/network/api_client.dart';
import 'package:silab/features/announcement/data/data_sources/announcement_api_service.dart';
import 'package:silab/features/announcement/data/repository/announcement_repository_impl.dart';
import 'package:silab/features/announcement/domain/usecases/get_announcement_usecase.dart';
import 'package:silab/features/announcement/presentation/blocs/get_announcement/get_announcement_bloc.dart';
import 'package:silab/features/announcement/presentation/pages/pengumumman_page.dart';

import '../../helpers/real_font.dart';
import '../../helpers/small_phone_shell.dart';

final longBody = [
  for (var i = 1; i <= 4; i++) 'Paragraf $i ${'kata ' * 50}',
  'Bagian akhir pengumuman.',
].join('\n\n');

void main() {
  late SharedPreferences prefs;
  late Set<String> down;
  late Map<String, Completer<void>> hold;
  late Map<String, String> types;
  late GoRouter router;

  setUpAll(loadRealFont);

  setUp(() async {
    AppConfig.create(baseUrl: 'http://silab.test');
    SharedPreferences.setMockInitialValues(
        {'accessToken': 'akses', 'refreshToken': 'segar'});
    prefs = await SharedPreferences.getInstance();
    down = {};
    hold = {};
    types = {};
  });

  Future<http.Response> backend(http.Request request) async {
    final id = request.url.pathSegments.last;
    await hold[id]?.future;
    if (down.contains(id)) throw http.ClientException('Connection refused');

    return http.Response(
      jsonEncode({
        'status': true,
        'message': 'Berhasil',
        'data': {
          'id': id,
          'title': 'Judul $id',
          'type': types[id] ?? 'BASIC',
          'body': id == 'panjang' ? longBody : 'Isi pengumuman $id.',
          'created_at': '2026-09-30T02:00:00.000Z',
          'author': 'Laboran Uji',
        },
      }),
      200,
    );
  }

  Future<void> settle(WidgetTester tester) async {
    for (var i = 0; i < 5; i++) {
      await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 20)));
      await tester.pump(const Duration(milliseconds: 100));
    }
    await tester.pumpAndSettle();
  }

  Future<void> openApp(WidgetTester tester) async {
    useSmallPhone(tester);
    final api = ApiClient(MockClient(backend), prefs);
    final controller = ScrollController();
    addTearDown(controller.dispose);

    router = GoRouter(initialLocation: '/home', routes: [
      ShellRoute(
        builder: (context, state, child) => shellWithNavbar(
          title: 'Pengumuman',
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
                path: 'pengumuman/:id',
                name: 'pengumuman',
                builder: (_, state) =>
                    PengumumanPage(id: state.pathParameters['id']),
              ),
            ],
          ),
        ],
      ),
    ]);
    addTearDown(router.dispose);

    await tester.pumpWidget(BlocProvider(
      create: (_) => GetAnnouncementBloc(GetAnnouncementUseCase(
          AnnouncementRepositoryImpl(AnnouncementApiService(api)))),
      child: MaterialApp.router(
        theme: ThemeData(fontFamily: realFontFamily),
        routerConfig: router,
      ),
    ));
    await settle(tester);
  }

  Future<void> open(WidgetTester tester, String id, {bool wait = true}) async {
    router.goNamed('pengumuman', pathParameters: {'id': id});
    if (wait) {
      await settle(tester);
    } else {
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
    }
  }

  Future<void> back(WidgetTester tester) async {
    router.pop();
    await settle(tester);
  }

  Finder spinner() => find.byType(CircularProgressIndicator);

  testWidgets(
      'membuka pengumuman kedua: selama memuat tidak menampilkan isi pengumuman sebelumnya',
      (tester) async {
    await openApp(tester);
    await open(tester, 'p1');
    expect(find.text('Judul p1'), findsOneWidget);
    await back(tester);

    hold['p2'] = Completer<void>();
    await open(tester, 'p2', wait: false);

    expect(find.text('Judul p1'), findsNothing);
    expect(find.text('Isi pengumuman p1.'), findsNothing);
    expect(spinner(), findsOneWidget);

    hold['p2']!.complete();
    await settle(tester);
    expect(find.text('Judul p2'), findsOneWidget);
  });

  testWidgets(
      'jawaban pengumuman lama yang datang terlambat tidak menimpa pengumuman yang sedang dibuka',
      (tester) async {
    await openApp(tester);
    hold['p1'] = Completer<void>();
    await open(tester, 'p1', wait: false);
    router.pop();
    await tester.pump(const Duration(milliseconds: 400));

    await open(tester, 'p2');
    expect(find.text('Judul p2'), findsOneWidget);

    hold['p1']!.complete();
    await settle(tester);

    expect(find.text('Judul p2'), findsOneWidget);
    expect(find.text('Judul p1'), findsNothing);
  });

  testWidgets(
      'memuat: lingkaran berputar; gagal: "Gagal memuat pengumuman." dan Coba lagi memuat ulang',
      (tester) async {
    await openApp(tester);
    hold['p1'] = Completer<void>();
    down.add('p1');
    await open(tester, 'p1', wait: false);
    expect(spinner(), findsOneWidget);

    hold['p1']!.complete();
    await settle(tester);
    expect(spinner(), findsNothing);
    expect(find.text('Gagal memuat pengumuman.'), findsOneWidget);

    down.clear();
    await tester.tap(find.text('Coba lagi'));
    await settle(tester);

    expect(find.text('Gagal memuat pengumuman.'), findsNothing);
    expect(find.text('Judul p1'), findsOneWidget);
  });

  testWidgets(
      'pengumuman panjang di HP 360×640: satu geseran, baris terakhir bisa sampai di atas menu bawah',
      (tester) async {
    await openApp(tester);
    await open(tester, 'panjang');

    final scrollingAreas = [
      for (final element in find.byType(Scrollable).evaluate())
        if (((element as StatefulElement).state as ScrollableState)
                    .position
                    .axis ==
                Axis.vertical &&
            (element.state as ScrollableState).position.maxScrollExtent > 0)
          element,
    ];
    expect(scrollingAreas, hasLength(1));

    await scrollEverythingToEnd(tester);
    expect(tester.getRect(find.byType(SelectableText)).bottom,
        lessThanOrEqualTo(navbarTop(tester)));
  });

  testWidgets(
      'isi bisa dipilih untuk disalin sebagian, dan "Salin isi" menyalin seluruh isi',
      (tester) async {
    String? copied;
    tester.binding.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, (call) async {
      if (call.method == 'Clipboard.setData') {
        copied = (call.arguments as Map)['text'] as String?;
      }
      return null;
    });
    addTearDown(() => tester.binding.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, null));

    await openApp(tester);
    await open(tester, 'p1');

    expect(tester.widget<SelectableText>(find.byType(SelectableText)).data,
        'Isi pengumuman p1.');

    await tester.tap(find.text('Salin isi'));
    await tester.pump();

    expect(copied, 'Isi pengumuman p1.');
    expect(find.text('Isi pengumuman disalin.'), findsOneWidget);
  });

  testWidgets('label jenis pengumuman tampil di atas judul', (tester) async {
    types['p1'] = 'INHALL';
    await openApp(tester);
    await open(tester, 'p1');

    expect(find.text('Pendaftaran Inhal'), findsOneWidget);
    expect(tester.getRect(find.text('Pendaftaran Inhal')).bottom,
        lessThanOrEqualTo(tester.getRect(find.text('Judul p1')).top));
  });
}
