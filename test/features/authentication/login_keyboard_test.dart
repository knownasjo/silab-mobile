import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silab/app_config.dart';
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
import 'package:silab/features/authentication/presentation/pages/authentication_page.dart';

import '../../helpers/fixed_device_id.dart';

void main() {
  late SharedPreferences prefs;

  setUp(() async {
    AppConfig.create(baseUrl: 'http://silab.test');
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
  });

  testWidgets(
    'berhasil masuk: papan ketik yang dikembalikan iOS ikut ditutup di iPhone',
    (tester) async {
      final api = ApiClient(
        MockClient((request) async {
          if (request.url.path == '/auth/login') {
            return http.Response(
              jsonEncode({
                'status': true,
                'message': 'Login berhasil',
                'data': {'accessToken': 'akses', 'refreshToken': 'segar'},
              }),
              200,
            );
          }

          return http.Response(
            jsonEncode({
              'status': true,
              'message': 'Success get user data!',
              'data': {'role': 'MAHASISWA'},
            }),
            200,
          );
        }),
        prefs,
      );
      final auth = AuthenticationRepositoryImpl(
        AuthenticationApiService(api, FixedDeviceIdSource('a' * 64)),
        AuthenticationLocalDataSource(prefs),
      );
      final router = GoRouter(
        initialLocation: '/authentication',
        routes: [
          GoRoute(
            path: '/authentication',
            builder: (context, state) => const AuthenticationPage(),
          ),
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) =>
                const Scaffold(body: Center(child: Text('Beranda'))),
          ),
        ],
      );
      addTearDown(router.dispose);

      await tester.pumpWidget(
        BlocProvider(
          create: (_) => AuthenticationBloc(
            UserLoginUsecase(auth),
            GetUserAccessTokenUsecase(auth),
            GetSessionExpiry(auth),
            UserLogoutUsecase(auth),
            WatchSessionEndedUsecase(auth),
          ),
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).at(0), '2211102001');
      await tester.enterText(find.byType(TextFormField).at(1), 'rahasia123');
      tester.testTextInput.closeConnection();
      await tester.pump();
      tester.testTextInput.log.clear();

      await tester.tap(find.text('Masuk'));
      await tester.pumpAndSettle();

      expect(find.text('Beranda'), findsOneWidget);
      expect(
        tester.testTextInput.log.where(
          (call) => call.method == 'TextInput.hide',
        ),
        defaultTargetPlatform == TargetPlatform.iOS ? isNotEmpty : isEmpty,
      );
    },
    variant: const TargetPlatformVariant({
      TargetPlatform.iOS,
      TargetPlatform.android,
    }),
  );
}
