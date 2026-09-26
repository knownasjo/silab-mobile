import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silab/app_config.dart';
import 'package:silab/core/network/api_client.dart';
import 'package:silab/features/account/data/data_sources/account_api_service.dart';
import 'package:silab/features/account/data/models/change_password_model.dart';
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
import 'package:silab/features/user_details/domain/usecases/get_user_details_usecase.dart';
import 'package:silab/features/user_details/presentation/bloc/user_details_bloc.dart';

ChangePasswordModel passwordModel(String oldPassword) => ChangePasswordModel(
      oldPassword: oldPassword,
      password: 'passwordbaru1',
      confirmPassword: 'passwordbaru1',
    );

http.Response jsonResponse(Object body, int status) =>
    http.Response(jsonEncode(body), status);

void main() {
  late SharedPreferences prefs;
  late List<http.Request> requests;
  late String currentName;

  setUp(() async {
    AppConfig.create(baseUrl: 'http://silab.test');
    SharedPreferences.setMockInitialValues({
      'accessToken': 'akses-lama',
      'refreshToken': 'segar-lama',
    });
    prefs = await SharedPreferences.getInstance();
    requests = [];
    currentName = 'Budi Santoso';
  });

  Future<http.Response> backend(http.Request request) async {
    final body = request.body.isEmpty
        ? const <String, dynamic>{}
        : jsonDecode(request.body) as Map<String, dynamic>;

    switch ('${request.method} ${request.url.path}') {
      case 'GET /auth/me':
        return jsonResponse({
          'status': true,
          'message': 'Success get user data!',
          'data': {
            'nim': '2000016123',
            'name': currentName,
            'email': 'budi2000016123@webmail.uad.ac.id',
          },
        }, 200);
      case 'PUT /auth/me':
        currentName = body['fullname'] as String;
        return jsonResponse({
          'status': true,
          'message': 'Nama berhasil diperbarui',
          'data': {'name': currentName},
        }, 200);
      case 'PUT /auth/me/password':
        if (body['oldPassword'] != 'passwordlama1') {
          return jsonResponse(
            {'status': false, 'message': 'Password lama salah!'},
            400,
          );
        }
        return jsonResponse({
          'status': true,
          'message': 'Password berhasil diganti',
          'data': {'accessToken': 'akses-baru', 'refreshToken': 'segar-baru'},
        }, 200);
    }

    return jsonResponse({'status': false, 'message': 'Not Found'}, 404);
  }

  ApiClient apiWith(Future<http.Response> Function(http.Request) handler) =>
      ApiClient(
        MockClient((request) {
          requests.add(request);
          return handler(request);
        }),
        prefs,
      );

  AccountRepositoryImpl repositoryWith(
    Future<http.Response> Function(http.Request) handler,
  ) =>
      AccountRepositoryImpl(
        AccountApiService(apiWith(handler)),
        AuthenticationLocalDataSource(prefs),
      );

  group('repository', () {
    test('ganti nama mengirim PUT /auth/me dengan token login', () async {
      final result =
          await repositoryWith(backend).updateProfile('Budi Santoso Baru');

      expect(result.right, 'Nama berhasil diperbarui');
      expect(requests.single.method, 'PUT');
      expect(requests.single.url.path, '/auth/me');
      expect(requests.single.headers['Authorization'], 'Bearer akses-lama');
      expect(jsonDecode(requests.single.body),
          {'fullname': 'Budi Santoso Baru'});
    });

    test('ganti password berhasil: token baru disimpan agar tetap masuk',
        () async {
      final result = await repositoryWith(backend)
          .changePassword(passwordModel('passwordlama1'));

      expect(result.right, 'Password berhasil diganti');
      expect(requests.single.url.path, '/auth/me/password');
      expect(jsonDecode(requests.single.body),
          passwordModel('passwordlama1').toJson());
      expect(prefs.getString('accessToken'), 'akses-baru');
      expect(prefs.getString('refreshToken'), 'segar-baru');
    });

    test('password lama salah: pesan diteruskan, token tidak berubah',
        () async {
      final result = await repositoryWith(backend)
          .changePassword(passwordModel('passwordsalah1'));

      expect(result.left.message, 'Password lama salah!');
      expect(prefs.getString('accessToken'), 'akses-lama');
      expect(prefs.getString('refreshToken'), 'segar-lama');
    });
  });

  group('bloc', () {
    test('ganti nama: Submitting lalu Succeeded', () async {
      final bloc =
          EditProfileBloc(UpdateProfileUsecase(repositoryWith(backend)));
      final states = <EditProfileState>[];
      final subscription = bloc.stream.listen(states.add);

      bloc.add(const SubmitProfile('Budi Santoso Baru'));
      await Future<void>.delayed(const Duration(milliseconds: 50));

      expect(states, [
        const EditProfileSubmitting(),
        const EditProfileSucceeded('Nama berhasil diperbarui'),
      ]);
      await subscription.cancel();
      await bloc.close();
    });

    test('ganti password: salah lalu benar, tidak dikirim dua kali', () async {
      final bloc =
          ChangePasswordBloc(ChangePasswordUsecase(repositoryWith(backend)));
      final states = <ChangePasswordState>[];
      final subscription = bloc.stream.listen(states.add);

      bloc.add(SubmitPasswordChange(passwordModel('passwordsalah1')));
      await Future<void>.delayed(const Duration(milliseconds: 50));
      bloc
        ..add(SubmitPasswordChange(passwordModel('passwordlama1')))
        ..add(SubmitPasswordChange(passwordModel('passwordlama1')));
      await Future<void>.delayed(const Duration(milliseconds: 50));

      expect(states, [
        const ChangePasswordSubmitting(),
        const ChangePasswordFailed('Password lama salah!'),
        const ChangePasswordSubmitting(),
        const ChangePasswordSucceeded('Password berhasil diganti'),
      ]);
      expect(requests, hasLength(2));
      await subscription.cancel();
      await bloc.close();
    });

    test('profil dimuat ulang diam-diam setelah nama diganti', () async {
      final api = apiWith(backend);
      final bloc = UserDetailsBloc(
        GetUserDetailsUseCase(UserRepositoryImpl(UserApiService(api))),
      );
      final states = <UserDetailsState>[];
      final subscription = bloc.stream.listen(states.add);

      bloc.add(RefreshUserDetails());
      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(states, isEmpty);

      bloc.add(GetUserDetails());
      await Future<void>.delayed(const Duration(milliseconds: 50));
      await AccountApiService(api).updateProfile('Budi Santoso Baru');
      states.clear();

      bloc.add(RefreshUserDetails());
      await Future<void>.delayed(const Duration(milliseconds: 50));

      expect(states, hasLength(1));
      expect(states.single, isA<UserDetailLoaded>());
      expect(states.single.userDetailEntity?.fullname, 'Budi Santoso Baru');
      await subscription.cancel();
      await bloc.close();
    });
  });

  group('layar', () {
    testWidgets('edit profil: nama lama terisi, isian diperiksa dulu',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider(
              create: (_) =>
                  EditProfileBloc(UpdateProfileUsecase(repositoryWith(backend))),
              child: const EditProfilePage(initialName: 'Budi Santoso'),
            ),
          ),
        ),
      );

      expect(find.text('Budi Santoso'), findsOne);
      expect(find.text('NIM dan email tidak bisa diubah.'), findsOne);

      await tester.enterText(find.byType(TextFormField), '  ');
      await tester.tap(find.text('Simpan'));
      await tester.pump();
      expect(find.text('Nama Lengkap Belum Diisi!'), findsOne);

      await tester.enterText(find.byType(TextFormField), 'ab');
      await tester.tap(find.text('Simpan'));
      await tester.pump();
      expect(find.text('Nama lengkap minimal 3 karakter'), findsOne);
      expect(requests, isEmpty);
    });

    testWidgets('ganti password: isian kosong, pendek, sama, dan beda ditolak',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider(
              create: (_) => ChangePasswordBloc(
                ChangePasswordUsecase(repositoryWith(backend)),
              ),
              child: const ChangePasswordPage(),
            ),
          ),
        ),
      );

      final fields = find.byType(TextFormField);
      await tester.tap(find.text('Simpan'));
      await tester.pump();
      expect(find.text('Password Lama Belum Diisi!'), findsOne);
      expect(find.text('Password Baru Belum Diisi!'), findsOne);

      await tester.enterText(fields.at(0), 'passwordlama1');
      await tester.enterText(fields.at(1), 'pendek');
      await tester.tap(find.text('Simpan'));
      await tester.pump();
      expect(find.text('Password minimal 8 karakter'), findsOne);

      await tester.enterText(fields.at(1), 'passwordlama1');
      await tester.enterText(fields.at(2), 'passwordlama1');
      await tester.tap(find.text('Simpan'));
      await tester.pump();
      expect(
        find.text('Password baru harus berbeda dari password lama'),
        findsOne,
      );

      await tester.enterText(fields.at(1), 'passwordbaru1');
      await tester.enterText(fields.at(2), 'passwordlain1');
      await tester.tap(find.text('Simpan'));
      await tester.pump();
      expect(find.text('Konfirmasi password tidak sama'), findsOne);
      expect(requests, isEmpty);
    });
  });
}
