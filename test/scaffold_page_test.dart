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
import 'package:silab/core/common/widgets/custom_bottom_navbar.dart';
import 'package:silab/core/network/api_client.dart';
import 'package:silab/features/authentication/data/data_sources/local/authentication_local_datasource.dart';
import 'package:silab/features/authentication/data/data_sources/remote/authentication_api_service.dart';
import 'package:silab/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:silab/features/authentication/domain/usecases/get_session_expiry.dart';
import 'package:silab/features/authentication/domain/usecases/get_user_access_token_usecase.dart';
import 'package:silab/features/authentication/domain/usecases/user_login_usecase.dart';
import 'package:silab/features/authentication/domain/usecases/user_logout_usecase.dart';
import 'package:silab/features/authentication/domain/usecases/watch_session_ended_usecase.dart';
import 'package:silab/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:silab/features/realtime/domain/entities/realtime_event_entity.dart';
import 'package:silab/features/realtime/domain/repository/realtime_repository.dart';
import 'package:silab/features/realtime/domain/usecases/watch_realtime_events_usecase.dart';
import 'package:silab/features/realtime/presentation/bloc/realtime_bloc.dart';
import 'package:silab/features/user_details/data/data_sources/user_api_service.dart';
import 'package:silab/features/user_details/data/repositories/user_repository_impl.dart';
import 'package:silab/features/user_details/domain/usecases/get_user_details_usecase.dart';
import 'package:silab/features/user_details/presentation/bloc/user_details_bloc.dart';
import 'package:silab/features/user_details/presentation/widgets/user_welcome_widget.dart';
import 'package:silab/scaffold_page.dart';

import 'helpers/real_font.dart';
import 'helpers/small_phone_shell.dart';

class SilentRealtimeRepository implements RealtimeRepository {
  @override
  Stream<RealtimeEventEntity> watchEvents() =>
      StreamController<RealtimeEventEntity>().stream;
}

String refreshTokenExpiringAt(DateTime exp) {
  String encode(Map<String, Object> json) =>
      base64Url.encode(utf8.encode(jsonEncode(json))).replaceAll('=', '');

  return '${encode({'alg': 'HS256', 'typ': 'JWT'})}'
      '.${encode({'id': 'u1', 'exp': exp.millisecondsSinceEpoch ~/ 1000})}'
      '.tanda-tangan';
}

void main() {
  setUpAll(loadRealFont);

  Future<void> openApp(WidgetTester tester) async {
    useSmallPhone(tester);
    AppConfig.create(baseUrl: 'http://silab.test');
    SharedPreferences.setMockInitialValues({
      'accessToken': 'akses',
      'refreshToken':
          refreshTokenExpiringAt(DateTime.now().add(const Duration(days: 1))),
    });
    final prefs = await SharedPreferences.getInstance();
    final api = ApiClient(
      MockClient((_) async => http.Response(
          jsonEncode({
            'status': true,
            'message': 'Berhasil',
            'data': {'nim': '2200018123', 'name': 'Budi Santoso'},
          }),
          200)),
      prefs,
    );
    final authentication = AuthenticationRepositoryImpl(
      AuthenticationApiService(api),
      AuthenticationLocalDataSource(prefs),
    );

    final router = GoRouter(
      navigatorKey: GlobalKey<NavigatorState>(),
      initialLocation: '/home',
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) =>
              ScaffoldPage(navigationShell: navigationShell),
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
                    builder: (context, _) => TextButton(
                      onPressed: () => context.goNamed('home'),
                      child: const Text('Kembali ke Beranda'),
                    ),
                  ),
                ],
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                path: '/schedule',
                name: 'schedule',
                builder: (context, _) => TextButton(
                  onPressed: () =>
                      context.pushNamed('class', pathParameters: {'id': 'k1'}),
                  child: const Text('Buka kelas'),
                ),
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                path: '/profile',
                name: 'profile',
                builder: (_, __) => const Text('Halaman Profil'),
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
          create: (_) => AuthenticationBloc(
            UserLoginUsecase(authentication),
            GetUserAccessTokenUsecase(authentication),
            GetSessionExpiry(authentication),
            UserLogoutUsecase(authentication),
            WatchSessionEndedUsecase(authentication),
          ),
        ),
        BlocProvider(
          create: (_) => RealtimeBloc(
              WatchRealtimeEventsUsecase(SilentRealtimeRepository())),
        ),
        BlocProvider(
          create: (_) => UserDetailsBloc(
              GetUserDetailsUseCase(UserRepositoryImpl(UserApiService(api)))),
        ),
      ],
      child: MaterialApp.router(
        theme: ThemeData(fontFamily: realFontFamily),
        routerConfig: router,
      ),
    ));
    await tester.pumpAndSettle();
  }

  int activeMenu(WidgetTester tester) => tester
      .widget<CustomBottomNavbar>(find.byType(CustomBottomNavbar))
      .currentIndex;

  testWidgets(
      'Detail Kelas dibuka dari Jadwal lalu "Kembali ke Beranda": menu Beranda yang menyala dan judulnya sapaan Beranda',
      (tester) async {
    await openApp(tester);

    await tester.tap(find.text('Jadwal'));
    await tester.pumpAndSettle();
    expect(activeMenu(tester), 1);
    expect(find.text('Jadwal Praktikum'), findsOneWidget);

    await tester.tap(find.text('Buka kelas'));
    await tester.pumpAndSettle();
    expect(find.text('Detail Kelas'), findsOneWidget);

    await tester.tap(find.text('Kembali ke Beranda'));
    await tester.pumpAndSettle();

    expect(find.text('Halaman Beranda'), findsOneWidget);
    expect(activeMenu(tester), 0);
    expect(find.text('Jadwal Praktikum'), findsNothing);
    expect(find.byType(UserWelcomeWidget), findsOneWidget);
  });
}
