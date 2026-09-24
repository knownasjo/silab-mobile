import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silab/app_config.dart';
import 'package:silab/core/exceptions/exceptions.dart';
import 'package:silab/core/failures/failures.dart';
import 'package:silab/core/helpers/campus_email.dart';
import 'package:silab/core/helpers/initials.dart';
import 'package:silab/core/network/api_client.dart';
import 'package:silab/features/authentication/data/data_sources/local/authentication_local_datasource.dart';
import 'package:silab/features/authentication/data/data_sources/remote/authentication_api_service.dart';
import 'package:silab/features/authentication/data/models/login_model.dart';
import 'package:silab/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:silab/features/registration/data/data_sources/registration_api_service.dart';
import 'package:silab/features/registration/data/models/register_model.dart';
import 'package:silab/features/registration/data/repository/registration_repository_impl.dart';
import 'package:silab/features/registration/domain/entities/registration_entity.dart';
import 'package:silab/features/registration/domain/usecases/register_usecase.dart';
import 'package:silab/features/registration/domain/usecases/resend_registration_code_usecase.dart';
import 'package:silab/features/registration/domain/usecases/verify_registration_usecase.dart';
import 'package:silab/features/registration/presentation/bloc/registration/registration_bloc.dart';
import 'package:silab/features/registration/presentation/bloc/registration_verification/registration_verification_bloc.dart';
import 'package:silab/features/registration/presentation/pages/registration_page.dart';
import 'package:silab/features/registration/presentation/pages/registration_verification_page.dart';

const email = 'jordan2000016123@webmail.uad.ac.id';

const registerModel = RegisterModel(
  email: email,
  fullname: 'Jordan Bramada',
  password: 'rahasia123',
  confirmPassword: 'rahasia123',
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

  RegistrationRepositoryImpl repositoryWith(
    Future<http.Response> Function(http.Request) handler,
  ) {
    final api = ApiClient(
      MockClient((request) {
        requests.add(request);
        return handler(request);
      }),
      prefs,
    );

    return RegistrationRepositoryImpl(
      RegistrationApiService(api),
      AuthenticationLocalDataSource(prefs),
    );
  }

  Future<http.Response> backend(http.Request request) async {
    final body = jsonDecode(request.body) as Map<String, dynamic>;

    switch (request.url.path) {
      case '/auth/register':
        return jsonResponse({
          'status': true,
          'message': 'Kode verifikasi dikirim ke ${body['email']}',
          'data': {
            'email': body['email'],
            'nim': '2000016123',
            'expires_in': 600,
            'resend_in': 60,
          },
        }, 201);
      case '/auth/register/resend':
        return jsonResponse({
          'status': false,
          'message': 'Tunggu 42 detik sebelum meminta kode baru.',
        }, 429);
      case '/auth/register/verify':
        if (body['code'] != '123456') {
          return jsonResponse(
            {'status': false, 'message': 'Kode salah. Sisa 4 percobaan.'},
            400,
          );
        }
        return jsonResponse({
          'status': true,
          'message': 'Akun berhasil dibuat',
          'data': {'accessToken': 'akses', 'refreshToken': 'segar'},
        }, 201);
    }

    return jsonResponse({'status': false, 'message': 'Not Found'}, 404);
  }

  group('helper', () {
    test('inisial diambil dari dua kata pertama nama lengkap', () {
      expect(nameInitials('Jordan Bramada'), 'JB');
      expect(nameInitials('  budi   santoso  wijaya '), 'BS');
      expect(nameInitials('Jordan'), 'J');
      expect(nameInitials(''), '?');
      expect(nameInitials(null), '?');
    });

    test('NIM hanya diambil dari email kampus namadepanNIM', () {
      expect(nimFromCampusEmail(email), '2000016123');
      expect(
        nimFromCampusEmail('  Jordan2000016123@WEBMAIL.uad.ac.id '),
        '2000016123',
      );
      expect(nimFromCampusEmail('jordan200001612@webmail.uad.ac.id'), isNull);
      expect(nimFromCampusEmail('jordan2000016123@gmail.com'), isNull);
      expect(nimFromCampusEmail('2000016123@webmail.uad.ac.id'), isNull);
    });
  });

  group('repository pendaftaran', () {
    test('daftar mengirim data form dan membaca NIM & jeda kirim ulang',
        () async {
      final result = await repositoryWith(backend).register(registerModel);

      expect(
        result.right,
        const RegistrationEntity(email: email, nim: '2000016123'),
      );
      expect(requests.single.url.path, '/auth/register');
      expect(jsonDecode(requests.single.body), registerModel.toJson());
    });

    test('pesan error backend diteruskan apa adanya', () async {
      final result = await repositoryWith(backend).resendCode(email);

      expect(result.left.message, 'Tunggu 42 detik sebelum meminta kode baru.');
    });

    test('kode benar: token disimpan sehingga pengguna langsung masuk',
        () async {
      final result = await repositoryWith(backend).verify(email, '123456');

      expect(result.right, 'Akun berhasil dibuat');
      expect(prefs.getString('accessToken'), 'akses');
      expect(prefs.getString('refreshToken'), 'segar');
    });

    test('kode salah: token tidak disimpan', () async {
      final result = await repositoryWith(backend).verify(email, '000000');

      expect(result.left.message, 'Kode salah. Sisa 4 percobaan.');
      expect(prefs.getString('accessToken'), isNull);
    });
  });

  test('login akun yang belum diverifikasi membawa email untuk layar kode',
      () async {
    final api = ApiClient(
      MockClient(
        (request) async => jsonResponse({
          'status': false,
          'message': 'Akun belum diverifikasi. Masukkan kode yang dikirim ke '
              '$email.',
          'data': {'email': email},
        }, 403),
      ),
      prefs,
    );
    final repository = AuthenticationRepositoryImpl(
      AuthenticationApiService(api),
      AuthenticationLocalDataSource(prefs),
    );

    final result = await repository.userLogin(
      loginData: const LoginModel(nim: '2000016123', password: 'rahasia123'),
    );

    expect(result.left, isA<UnverifiedAccountFailures>());
    expect((result.left as UnverifiedAccountFailures).email, email);
  });

  test('ApiClient meneruskan data dari respons error', () async {
    final api = ApiClient(
      MockClient(
        (request) async => jsonResponse({
          'status': false,
          'message': 'x',
          'data': {'email': email},
        }, 403),
      ),
      prefs,
    );

    await expectLater(
      api.post('/auth/login'),
      throwsA(
        isA<RequestErrorException>()
            .having((e) => e.data, 'data', {'email': email}),
      ),
    );
  });

  group('bloc', () {
    test('daftar: Submitting lalu CodeSent', () async {
      final bloc = RegistrationBloc(RegisterUsecase(repositoryWith(backend)));
      final states = <RegistrationState>[];
      final subscription = bloc.stream.listen(states.add);

      bloc.add(const SubmitRegistration(registerModel));
      await Future<void>.delayed(const Duration(milliseconds: 50));

      expect(states, [
        const RegistrationSubmitting(),
        const RegistrationCodeSent(
          RegistrationEntity(email: email, nim: '2000016123'),
        ),
      ]);
      await subscription.cancel();
      await bloc.close();
    });

    test('verifikasi: salah lalu benar; kirim ulang terlalu cepat ditolak',
        () async {
      final repository = repositoryWith(backend);
      final bloc = RegistrationVerificationBloc(
        VerifyRegistrationUsecase(repository),
        ResendRegistrationCodeUsecase(repository),
      );
      final states = <RegistrationVerificationState>[];
      final subscription = bloc.stream.listen(states.add);

      bloc.add(const SubmitVerificationCode(email: email, code: '000000'));
      await Future<void>.delayed(const Duration(milliseconds: 50));
      bloc.add(const ResendVerificationCode(email));
      await Future<void>.delayed(const Duration(milliseconds: 50));
      bloc.add(const SubmitVerificationCode(email: email, code: '123456'));
      await Future<void>.delayed(const Duration(milliseconds: 50));

      expect(states, [
        const VerificationSubmitting(),
        const VerificationFailed('Kode salah. Sisa 4 percobaan.'),
        const VerificationResending(),
        const VerificationFailed('Tunggu 42 detik sebelum meminta kode baru.'),
        const VerificationSubmitting(),
        const VerificationSucceeded('Akun berhasil dibuat'),
      ]);
      await subscription.cancel();
      await bloc.close();
    });

    test('verifikasi yang sedang berjalan tidak dikirim dua kali', () async {
      final bloc = RegistrationVerificationBloc(
        VerifyRegistrationUsecase(repositoryWith(backend)),
        ResendRegistrationCodeUsecase(repositoryWith(backend)),
      );

      bloc
        ..add(const SubmitVerificationCode(email: email, code: '123456'))
        ..add(const SubmitVerificationCode(email: email, code: '123456'))
        ..add(const ResendVerificationCode(email));
      await Future<void>.delayed(const Duration(milliseconds: 50));

      expect(requests, hasLength(1));
      await bloc.close();
    });
  });

  group('layar', () {
    testWidgets('form daftar: NIM muncul dari email, isian kosong ditolak',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) =>
                RegistrationBloc(RegisterUsecase(repositoryWith(backend))),
            child: const RegistrationPage(),
          ),
        ),
      );

      expect(find.text('NIM diambil otomatis dari email kampus'), findsOne);

      await tester.enterText(find.byType(TextFormField).first, email);
      await tester.pump();
      expect(find.text('NIM: 2000016123'), findsOne);

      await tester.tap(find.text('Daftar'));
      await tester.pump();

      expect(find.text('Nama Lengkap Belum Diisi!'), findsOne);
      expect(find.text('Password Anda Belum Diisi!'), findsOne);
      expect(requests, isEmpty);
    });

    testWidgets(
        'layar kode: hitung mundur kirim ulang, 6 angka langsung dikirim',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => RegistrationVerificationBloc(
              VerifyRegistrationUsecase(repositoryWith(backend)),
              ResendRegistrationCodeUsecase(repositoryWith(backend)),
            ),
            child: const RegistrationVerificationPage(
              extra: RegistrationVerificationPageExtra(
                email: email,
                resendIn: 60,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Kirim ulang kode dalam 60 detik'), findsOne);
      await tester.pump(const Duration(seconds: 3));
      expect(find.text('Kirim ulang kode dalam 57 detik'), findsOne);

      await tester.enterText(find.byType(TextField), '0000a0');
      expect(requests, isEmpty);

      await tester.enterText(find.byType(TextField), '000000');
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 50)),
      );
      await tester.pump();

      expect(requests.single.url.path, '/auth/register/verify');
      expect(find.text('Kode salah. Sisa 4 percobaan.'), findsOne);

      await tester.pumpWidget(const SizedBox());
    });
  });
}
