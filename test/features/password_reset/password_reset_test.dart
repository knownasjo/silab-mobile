import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silab/app_config.dart';
import 'package:silab/core/failures/failures.dart';
import 'package:silab/core/helpers/campus_email.dart';
import 'package:silab/core/network/api_client.dart';
import 'package:silab/features/password_reset/data/data_sources/password_reset_api_service.dart';
import 'package:silab/features/password_reset/data/models/reset_password_model.dart';
import 'package:silab/features/password_reset/data/repository/password_reset_repository_impl.dart';
import 'package:silab/features/password_reset/domain/entities/password_reset_entity.dart';
import 'package:silab/features/password_reset/domain/usecases/request_password_reset_code_usecase.dart';
import 'package:silab/features/password_reset/domain/usecases/reset_password_usecase.dart';
import 'package:silab/features/password_reset/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:silab/features/password_reset/presentation/bloc/reset_password/reset_password_bloc.dart';
import 'package:silab/features/password_reset/presentation/pages/forgot_password_page.dart';
import 'package:silab/features/password_reset/presentation/pages/reset_password_page.dart';

const email = 'budi2000016123@webmail.uad.ac.id';
const unverifiedEmail = 'tunda2000016124@webmail.uad.ac.id';

ResetPasswordModel resetModel(String code) => ResetPasswordModel(
      email: email,
      code: code,
      password: 'passwordbaru1',
      confirmPassword: 'passwordbaru1',
    );

http.Response jsonResponse(Object body, int status) =>
    http.Response(jsonEncode(body), status);

void main() {
  late SharedPreferences prefs;
  late List<http.Request> requests;

  setUp(() async {
    AppConfig.create(baseUrl: 'http://silab.test');
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    requests = [];
  });

  PasswordResetRepositoryImpl repositoryWith(
    Future<http.Response> Function(http.Request) handler,
  ) =>
      PasswordResetRepositoryImpl(
        PasswordResetApiService(
          ApiClient(
            MockClient((request) {
              requests.add(request);
              return handler(request);
            }),
            prefs,
          ),
        ),
      );

  Future<http.Response> backend(http.Request request) async {
    final body = jsonDecode(request.body) as Map<String, dynamic>;

    switch (request.url.path) {
      case '/auth/password/forgot':
        if (body['email'] == unverifiedEmail) {
          return jsonResponse({
            'status': false,
            'message':
                'Akun ini belum diverifikasi, silakan selesaikan pendaftaran.',
            'data': {'email': unverifiedEmail},
          }, 403);
        }
        if (body['email'] != email) {
          return jsonResponse({
            'status': false,
            'message': 'Email ini belum terdaftar di SILAB.',
          }, 404);
        }
        return jsonResponse({
          'status': true,
          'message': 'Kode reset password dikirim ke $email',
          'data': {'email': email, 'expires_in': 600, 'resend_in': 60},
        }, 200);
      case '/auth/password/reset':
        if (body['code'] != '123456') {
          return jsonResponse(
            {'status': false, 'message': 'Kode salah. Sisa 4 percobaan.'},
            400,
          );
        }
        return jsonResponse({
          'status': true,
          'message': 'Password berhasil diubah, silakan masuk.',
        }, 200);
    }

    return jsonResponse({'status': false, 'message': 'Not Found'}, 404);
  }

  test('format email dasar dikenali', () {
    expect(isEmailFormat(email), isTrue);
    expect(isEmailFormat('  Dosen@UAD.ac.id '), isTrue);
    expect(isEmailFormat('budi@'), isFalse);
    expect(isEmailFormat('budi gmail.com'), isFalse);
  });

  group('repository', () {
    test('minta kode mengirim email dan membaca jeda kirim ulang', () async {
      final result = await repositoryWith(backend).requestCode(email);

      expect(result.right, const PasswordResetEntity(email: email));
      expect(requests.single.url.path, '/auth/password/forgot');
      expect(jsonDecode(requests.single.body), {'email': email});
    });

    test('email belum terdaftar: pesan backend diteruskan', () async {
      final result = await repositoryWith(backend)
          .requestCode('lain2000016125@webmail.uad.ac.id');

      expect(result.left, isA<RequestFailures>());
      expect(result.left.message, 'Email ini belum terdaftar di SILAB.');
    });

    test('akun belum diverifikasi membawa email untuk layar kode pendaftaran',
        () async {
      final result = await repositoryWith(backend).requestCode(unverifiedEmail);

      expect(result.left, isA<UnverifiedAccountFailures>());
      expect((result.left as UnverifiedAccountFailures).email, unverifiedEmail);
    });

    test('ganti password mengirim kode, password, dan konfirmasi', () async {
      final result =
          await repositoryWith(backend).resetPassword(resetModel('123456'));

      expect(result.right, 'Password berhasil diubah, silakan masuk.');
      expect(requests.single.url.path, '/auth/password/reset');
      expect(jsonDecode(requests.single.body), resetModel('123456').toJson());
    });
  });

  group('bloc', () {
    test('lupa password: kode terkirim, belum terdaftar, belum diverifikasi',
        () async {
      final bloc = ForgotPasswordBloc(
        RequestPasswordResetCodeUsecase(repositoryWith(backend)),
      );
      final states = <ForgotPasswordState>[];
      final subscription = bloc.stream.listen(states.add);

      bloc.add(const SubmitForgotPassword(email));
      await Future<void>.delayed(const Duration(milliseconds: 50));
      bloc.add(const SubmitForgotPassword('lain2000016125@webmail.uad.ac.id'));
      await Future<void>.delayed(const Duration(milliseconds: 50));
      bloc.add(const SubmitForgotPassword(unverifiedEmail));
      await Future<void>.delayed(const Duration(milliseconds: 50));

      expect(states, [
        const ForgotPasswordSubmitting(),
        const ForgotPasswordCodeSent(PasswordResetEntity(email: email)),
        const ForgotPasswordSubmitting(),
        const ForgotPasswordFailed('Email ini belum terdaftar di SILAB.'),
        const ForgotPasswordSubmitting(),
        const ForgotPasswordUnverified(
          email: unverifiedEmail,
          message:
              'Akun ini belum diverifikasi, silakan selesaikan pendaftaran.',
        ),
      ]);
      await subscription.cancel();
      await bloc.close();
    });

    test('atur password: kode salah, kirim ulang, lalu berhasil', () async {
      final repository = repositoryWith(backend);
      final bloc = ResetPasswordBloc(
        ResetPasswordUsecase(repository),
        RequestPasswordResetCodeUsecase(repository),
      );
      final states = <ResetPasswordState>[];
      final subscription = bloc.stream.listen(states.add);

      bloc.add(SubmitNewPassword(resetModel('000000')));
      await Future<void>.delayed(const Duration(milliseconds: 50));
      bloc.add(const ResendResetCode(email));
      await Future<void>.delayed(const Duration(milliseconds: 50));
      bloc.add(SubmitNewPassword(resetModel('123456')));
      await Future<void>.delayed(const Duration(milliseconds: 50));

      expect(states, [
        const ResetPasswordSubmitting(),
        const ResetPasswordFailed('Kode salah. Sisa 4 percobaan.'),
        const ResetPasswordResending(),
        const ResetPasswordCodeResent(PasswordResetEntity(email: email)),
        const ResetPasswordSubmitting(),
        const ResetPasswordSucceeded('Password berhasil diubah, silakan masuk.'),
      ]);
      await subscription.cancel();
      await bloc.close();
    });

    test('password yang sedang disimpan tidak dikirim dua kali', () async {
      final repository = repositoryWith(backend);
      final bloc = ResetPasswordBloc(
        ResetPasswordUsecase(repository),
        RequestPasswordResetCodeUsecase(repository),
      );

      bloc
        ..add(SubmitNewPassword(resetModel('123456')))
        ..add(SubmitNewPassword(resetModel('123456')))
        ..add(const ResendResetCode(email));
      await Future<void>.delayed(const Duration(milliseconds: 50));

      expect(requests, hasLength(1));
      await bloc.close();
    });
  });

  group('layar', () {
    testWidgets('lupa password: NIM muncul dari email, format salah ditolak',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => ForgotPasswordBloc(
              RequestPasswordResetCodeUsecase(repositoryWith(backend)),
            ),
            child: const ForgotPasswordPage(),
          ),
        ),
      );

      await tester.tap(find.text('Kirim Kode'));
      await tester.pump();
      expect(find.text('Email Anda Belum Diisi!'), findsOne);

      await tester.enterText(find.byType(TextFormField), 'budi@');
      await tester.tap(find.text('Kirim Kode'));
      await tester.pump();
      expect(find.text('Format email tidak valid'), findsOne);
      expect(find.textContaining('NIM:'), findsNothing);

      await tester.enterText(find.byType(TextFormField), email);
      await tester.pump();
      expect(find.text('NIM: 2000016123'), findsOne);
      expect(requests, isEmpty);
    });

    testWidgets(
        'atur password: isian diperiksa dulu, kode salah tidak menghapus '
        'password, hitung mundur kirim ulang', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => ResetPasswordBloc(
              ResetPasswordUsecase(repositoryWith(backend)),
              RequestPasswordResetCodeUsecase(repositoryWith(backend)),
            ),
            child: const ResetPasswordPage(
              extra: ResetPasswordPageExtra(email: email, resendIn: 60),
            ),
          ),
        ),
      );

      expect(find.textContaining(email, findRichText: true), findsOne);
      expect(find.text('Kirim ulang kode dalam 60 detik'), findsOne);
      await tester.pump(const Duration(seconds: 2));
      expect(find.text('Kirim ulang kode dalam 58 detik'), findsOne);

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), '12a');
      await tester.enterText(fields.at(1), 'pendek');
      await tester.enterText(fields.at(2), 'lain');
      await tester.ensureVisible(find.text('Simpan'));
      await tester.tap(find.text('Simpan'));
      await tester.pump();

      expect(find.text('Masukkan 6 angka kode verifikasi!'), findsOne);
      expect(find.text('Password minimal 8 karakter'), findsOne);
      expect(find.text('Konfirmasi password tidak sama'), findsOne);
      expect(requests, isEmpty);

      await tester.enterText(fields.at(0), '000000');
      await tester.enterText(fields.at(1), 'passwordbaru1');
      await tester.enterText(fields.at(2), 'passwordbaru1');
      await tester.ensureVisible(find.text('Simpan'));
      await tester.pump();
      await tester.tap(find.text('Simpan'));
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 50)),
      );
      await tester.pump();

      expect(requests.single.url.path, '/auth/password/reset');
      expect(find.text('Kode salah. Sisa 4 percobaan.'), findsOne);
      expect(
        tester.widget<TextFormField>(fields.at(1)).controller?.text,
        'passwordbaru1',
      );

      await tester.pumpWidget(const SizedBox());
    });
  });
}
