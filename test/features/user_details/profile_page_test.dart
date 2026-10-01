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
import 'package:silab/features/account/data/data_sources/account_api_service.dart';
import 'package:silab/features/account/data/repository/account_repository_impl.dart';
import 'package:silab/features/account/domain/usecases/change_password_usecase.dart';
import 'package:silab/features/account/domain/usecases/update_profile_usecase.dart';
import 'package:silab/features/account/presentation/bloc/change_password/change_password_bloc.dart';
import 'package:silab/features/account/presentation/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:silab/features/account/presentation/pages/change_password_page.dart';
import 'package:silab/features/account/presentation/pages/edit_profile_page.dart';
import 'package:silab/features/authentication/data/data_sources/local/authentication_local_datasource.dart';
import 'package:silab/features/user_details/data/data_sources/user_api_service.dart';
import 'package:silab/features/user_details/data/repositories/user_repository_impl.dart';
import 'package:silab/features/user_details/domain/usecases/get_assisted_classes_usecase.dart';
import 'package:silab/features/user_details/domain/usecases/get_user_details_usecase.dart';
import 'package:silab/features/user_details/presentation/bloc/assisted_classes/assisted_classes_bloc.dart';
import 'package:silab/features/user_details/presentation/bloc/user_details_bloc.dart';
import 'package:silab/features/user_details/presentation/pages/profile_page.dart';

import '../../helpers/real_font.dart';
import '../../helpers/small_phone_shell.dart';

const keyboardHeight = 280.0;

void main() {
  late SharedPreferences prefs;
  late bool accountDown;
  late int assistedCount;
  late List<http.Request> saves;

  setUpAll(loadRealFont);

  setUp(() async {
    AppConfig.create(baseUrl: 'http://silab.test');
    SharedPreferences.setMockInitialValues(
        {'accessToken': 'akses', 'refreshToken': 'segar'});
    prefs = await SharedPreferences.getInstance();
    accountDown = false;
    assistedCount = 0;
    saves = [];
  });

  http.Response ok(Object? data, [String message = 'Berhasil']) =>
      http.Response(
          jsonEncode({'status': true, 'message': message, 'data': data}), 200);

  Future<http.Response> backend(http.Request request) async {
    final path = request.url.path;

    if (request.method == 'PUT') {
      saves.add(request);
      return path == '/auth/me/password'
          ? ok({'accessToken': 'akses-baru', 'refreshToken': 'segar-baru'},
              'Password berhasil diganti')
          : ok(null, 'Profil berhasil diperbarui');
    }

    if (path == '/auth/me') {
      if (accountDown) throw http.ClientException('Connection refused');
      return ok({
        'nim': '2200018123',
        'name': 'Budi Santoso',
        'email': 'budi2200018123@webmail.uad.ac.id',
      });
    }

    if (path == '/class') {
      return ok([
        for (var i = 1; i <= assistedCount; i++)
          {
            'id': 'k$i',
            'name': 'B',
            'subject_name': 'Jaringan Komputer $i',
            'day': 'MONDAY',
            'startAt': '10.00',
            'endAt': '11.40',
            'room': 'SBTI',
          },
      ]);
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

  Future<GoRouter> openApp(WidgetTester tester, String location,
      {Size size = const Size(360, 640)}) async {
    useSmallPhone(tester);
    tester.view.physicalSize = size * 3;

    final api = ApiClient(MockClient(backend), prefs);
    final users = UserRepositoryImpl(UserApiService(api));
    final accounts = AccountRepositoryImpl(
        AccountApiService(api), AuthenticationLocalDataSource(prefs));
    final controller = ScrollController();
    addTearDown(controller.dispose);

    final router = GoRouter(initialLocation: location, routes: [
      ShellRoute(
        builder: (context, state, child) => shellWithNavbar(
          title: 'SILAB',
          controller: controller,
          withAppBar: state.uri.path != '/profile',
          child: child,
        ),
        routes: [
          GoRoute(
            path: '/home',
            builder: (_, __) => const Text('Halaman Beranda'),
            routes: [
              GoRoute(
                path: 'edit-profil',
                builder: (_, __) => BlocProvider(
                  create: (_) =>
                      EditProfileBloc(UpdateProfileUsecase(accounts)),
                  child: const EditProfilePage(initialName: 'Budi Santoso'),
                ),
              ),
              GoRoute(
                path: 'ganti-password',
                builder: (_, __) => BlocProvider(
                  create: (_) =>
                      ChangePasswordBloc(ChangePasswordUsecase(accounts)),
                  child: const ChangePasswordPage(),
                ),
              ),
            ],
          ),
          GoRoute(path: '/profile', builder: (_, __) => const ProfilePage()),
        ],
      ),
    ]);
    addTearDown(router.dispose);

    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UserDetailsBloc(GetUserDetailsUseCase(users)),
        ),
        BlocProvider(
          create: (_) => AssistedClassesBloc(GetAssistedClassesUsecase(users)),
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

  Future<void> openProfile(WidgetTester tester,
      {Size size = const Size(360, 640)}) async {
    final router = await openApp(tester, '/home', size: size);
    router.go('/profile');
    await settle(tester);
  }

  Future<void> openKeyboard(WidgetTester tester, Finder field) async {
    await tester.tap(field);
    await tester.pump();
    tester.view.viewInsets = const FakeViewPadding(bottom: keyboardHeight * 3);
    await tester.pumpAndSettle();
  }

  double keyboardTop(WidgetTester tester) =>
      tester.view.physicalSize.height / tester.view.devicePixelRatio -
      keyboardHeight;

  testWidgets(
      'keyboard terbuka di Ganti Password: menu bawah turun dan kolom konfirmasi tidak tertutup, lalu kembali saat keyboard ditutup',
      (tester) async {
    await openApp(tester, '/home/ganti-password');
    final shownTop = navbarTop(tester);
    final confirm = find.byType(TextFormField).last;

    await openKeyboard(tester, confirm);

    expect(navbarTop(tester), greaterThanOrEqualTo(keyboardTop(tester)));
    expect(
        tester.getRect(confirm).bottom, lessThanOrEqualTo(keyboardTop(tester)));

    tester.view.resetViewInsets();
    await tester.pumpAndSettle();
    expect(navbarTop(tester), shownTop);
  });

  testWidgets(
      'keyboard terbuka di Edit Profil: Simpan bisa ditekan tanpa menutup keyboard',
      (tester) async {
    await openApp(tester, '/home/edit-profil');
    final field = find.byType(TextFormField);
    await openKeyboard(tester, field);
    await tester.enterText(field, 'Budi Santoso Wibowo');

    await tester.tap(find.text('Simpan'));
    await settle(tester);

    expect(saves, hasLength(1));
    expect(jsonDecode(saves.single.body), {'fullname': 'Budi Santoso Wibowo'});
  });

  testWidgets(
      'server mati: Profil tidak menampilkan data palsu, Coba lagi memuat data akun',
      (tester) async {
    accountDown = true;
    await openProfile(tester);

    for (final placeholder in ['XX', 'Nama Lengkap', 'email', 'NIM']) {
      expect(find.text(placeholder), findsNothing, reason: placeholder);
    }
    expect(find.text('Gagal memuat data akun.'), findsOneWidget);
    expect(find.text('Edit Profil'), findsOneWidget);

    accountDown = false;
    await tester.tap(find.text('Coba lagi'));
    await settle(tester);

    expect(find.text('Gagal memuat data akun.'), findsNothing);
    expect(find.text('Budi Santoso'), findsOneWidget);
    expect(find.text('2200018123'), findsOneWidget);
  });

  testWidgets('Enter di Edit Profil langsung menyimpan', (tester) async {
    await openApp(tester, '/home/edit-profil');
    await tester.enterText(find.byType(TextFormField), 'Budi Santoso Wibowo');

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await settle(tester);

    expect(saves, hasLength(1));
    expect(saves.single.url.path, '/auth/me');
  });

  testWidgets('Enter di kolom konfirmasi Ganti Password langsung menyimpan',
      (tester) async {
    await openApp(tester, '/home/ganti-password');
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'passwordlama');
    await tester.enterText(fields.at(1), 'passwordbaru1');
    await tester.enterText(fields.at(2), 'passwordbaru1');

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await settle(tester);

    expect(saves, hasLength(1));
    expect(saves.single.url.path, '/auth/me/password');
  });

  testWidgets(
      'HP kecil 360×640 dengan 2 kelas asisten: tombol Keluar bisa digeser sampai di atas menu bawah',
      (tester) async {
    assistedCount = 2;
    await openProfile(tester);

    await scrollEverythingToEnd(tester);

    final logout = find
        .ancestor(of: find.text('Keluar'), matching: find.byType(InkWell))
        .first;
    expect(tester.getRect(logout).bottom, lessThanOrEqualTo(navbarTop(tester)));
  });

  testWidgets(
      'HP besar 411×891 tanpa kelas asisten: ruang bawah tidak membuat halaman bisa digeser',
      (tester) async {
    await openProfile(tester, size: const Size(411, 891));

    for (final element in find.byType(Scrollable).evaluate()) {
      final position =
          ((element as StatefulElement).state as ScrollableState).position;
      if (position.axis == Axis.vertical) {
        expect(position.maxScrollExtent, 0);
      }
    }
    expect(tester.getRect(find.text('Keluar')).bottom,
        lessThanOrEqualTo(navbarTop(tester)));
  });
}
