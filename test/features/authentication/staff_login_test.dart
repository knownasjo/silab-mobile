import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silab/app_config.dart';
import 'package:silab/core/failures/failures.dart';
import 'package:silab/core/helpers/login_number.dart';
import 'package:silab/core/network/api_client.dart';
import 'package:silab/features/authentication/data/data_sources/local/authentication_local_datasource.dart';
import 'package:silab/features/authentication/data/data_sources/remote/authentication_api_service.dart';
import 'package:silab/features/authentication/data/models/login_model.dart';
import 'package:silab/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:silab/features/authentication/domain/usecases/get_session_expiry.dart';
import 'package:silab/features/authentication/domain/usecases/get_user_access_token_usecase.dart';
import 'package:silab/features/authentication/domain/usecases/user_login_usecase.dart';
import 'package:silab/features/authentication/domain/usecases/user_logout_usecase.dart';
import 'package:silab/features/authentication/domain/usecases/watch_session_ended_usecase.dart';
import 'package:silab/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:silab/features/authentication/presentation/pages/authentication_page.dart';

void main() {
  late SharedPreferences prefs;
  late List<String> requests;
  late String role;

  setUp(() async {
    AppConfig.create(baseUrl: 'http://silab.test');
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    requests = [];
    role = 'DOSEN';
  });

  ApiClient api() => ApiClient(
        MockClient((request) async {
          requests.add('${request.method} ${request.url.path}');

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
              'data': {'role': role},
            }),
            200,
          );
        }),
        prefs,
      );

  AuthenticationRepositoryImpl repository() => AuthenticationRepositoryImpl(
        AuthenticationApiService(api()),
        AuthenticationLocalDataSource(prefs),
      );

  group('validasi nomor di halaman masuk', () {
    test('NIY 8 angka diarahkan ke SILAB versi web', () {
      expect(validateLoginNumber('60020001'), staffUseWebMessage);
      expect(staffUseWebMessage,
          'Akun dosen dan laboran memakai SILAB versi web.');
    });

    test('aturan NIM mahasiswa tetap sama', () {
      expect(validateLoginNumber(''), 'NIM Anda Belum Diisi!');
      expect(validateLoginNumber(null), 'NIM Anda Belum Diisi!');
      expect(validateLoginNumber('1234567'), 'Masukkan NIM yang Valid!');
      expect(validateLoginNumber('123456789'), 'Masukkan NIM yang Valid!');
      expect(validateLoginNumber('2000016099'), isNull);
    });
  });

  group('login akun staf lewat server', () {
    for (final staffRole in ['DOSEN', 'LABORAN']) {
      test('$staffRole ditolak dan token tidak disimpan', () async {
        role = staffRole;
        final result = await repository().userLogin(
          loginData: const LoginModel(nim: '6002000100', password: 'x'),
        );

        expect(result.isLeft, isTrue);
        expect(result.left, isA<RequestFailures>());
        expect(result.left.message, staffUseWebMessage);
        expect(prefs.getString('accessToken'), isNull);
        expect(prefs.getString('refreshToken'), isNull);
      });
    }

    test('MAHASISWA tetap bisa masuk', () async {
      role = 'MAHASISWA';
      final result = await repository().userLogin(
        loginData: const LoginModel(nim: '2000016099', password: 'x'),
      );

      expect(result.isRight, isTrue);
      expect(prefs.getString('accessToken'), 'akses');
    });
  });

  group('halaman masuk', () {
    Future<void> pumpLogin(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) {
              final auth = repository();

              return AuthenticationBloc(
                UserLoginUsecase(auth),
                GetUserAccessTokenUsecase(auth),
                GetSessionExpiry(auth),
                UserLogoutUsecase(auth),
                WatchSessionEndedUsecase(auth),
              );
            },
            child: const AuthenticationPage(),
          ),
        ),
      );
    }

    Future<void> signIn(WidgetTester tester, String number) async {
      await tester.enterText(find.byType(TextFormField).at(0), number);
      await tester.enterText(find.byType(TextFormField).at(1), 'rahasia123');
      await tester.tap(find.text('Sign In'));
      await tester.pumpAndSettle();
    }

    testWidgets('NIY 8 angka: pesan tampil tanpa menghubungi server',
        (tester) async {
      await pumpLogin(tester);
      await signIn(tester, '60020001');

      expect(find.text(staffUseWebMessage), findsOneWidget);
      expect(requests, isEmpty);
    });

    testWidgets('server menyebut role staf: pesan tampil di snackbar',
        (tester) async {
      await pumpLogin(tester);
      await signIn(tester, '6002000100');

      expect(requests, ['POST /auth/login', 'GET /auth/me']);
      expect(
        find.descendant(
          of: find.byType(SnackBar),
          matching: find.text(staffUseWebMessage),
        ),
        findsOneWidget,
      );
      expect(prefs.getString('accessToken'), isNull);
    });
  });
}
