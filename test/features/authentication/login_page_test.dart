import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
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

const statusBar = 24.0;
const keyboard = 280.0;

void main() {
  late SharedPreferences prefs;
  late List<http.Request> logins;
  Completer<void>? holdLogin;

  setUp(() async {
    AppConfig.create(baseUrl: 'http://silab.test');
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    logins = [];
    holdLogin = null;
  });

  Future<void> openLogin(WidgetTester tester,
      {double keyboardHeight = 0}) async {
    tester.view.physicalSize = const Size(411, 640) * 3;
    tester.view.devicePixelRatio = 3;
    tester.view.padding = const FakeViewPadding(top: statusBar * 3);
    tester.view.viewInsets = FakeViewPadding(bottom: keyboardHeight * 3);
    addTearDown(tester.view.reset);

    final api = ApiClient(
      MockClient((request) async {
        logins.add(request);
        await holdLogin?.future;
        return http.Response(
          jsonEncode(
              {'status': false, 'message': 'NIM/NIY atau password salah!'}),
          401,
        );
      }),
      prefs,
    );
    final auth = AuthenticationRepositoryImpl(
      AuthenticationApiService(api, FixedDeviceIdSource('a' * 64)),
      AuthenticationLocalDataSource(prefs),
    );

    await tester.pumpWidget(MaterialApp(
      home: BlocProvider(
        create: (_) => AuthenticationBloc(
          UserLoginUsecase(auth),
          GetUserAccessTokenUsecase(auth),
          GetSessionExpiry(auth),
          UserLogoutUsecase(auth),
          WatchSessionEndedUsecase(auth),
        ),
        child: const AuthenticationPage(),
      ),
    ));
    await tester.pumpAndSettle();
  }

  Finder field(int index) => find.byType(TextFormField).at(index);

  Future<void> fillIn(WidgetTester tester) async {
    await tester.enterText(field(0), '2211102001');
    await tester.enterText(field(1), 'rahasia123');
  }

  testWidgets(
      'HP kecil dengan keyboard terbuka: halaman bisa digeser sampai Masuk dan Daftar',
      (tester) async {
    await openLogin(tester, keyboardHeight: keyboard);

    expect(tester.takeException(), isNull);

    const visibleBottom = 640 - keyboard;
    await tester.ensureVisible(find.text('Daftar'));
    await tester.pumpAndSettle();
    expect(tester.getRect(find.text('Masuk')).bottom,
        lessThanOrEqualTo(visibleBottom));
    expect(tester.getRect(find.text('Daftar')).bottom,
        lessThanOrEqualTo(visibleBottom));

    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();
    expect(find.text('NIM Anda Belum Diisi!'), findsOneWidget);
    expect(logins, isEmpty);
  });

  testWidgets('tanpa keyboard, isi halaman tetap di tengah layar',
      (tester) async {
    await openLogin(tester);

    final top = tester.getRect(find.byType(Image).first).top;
    final bottom = tester.getRect(find.text('Daftar')).bottom;
    expect((top - (640 - bottom)).abs(), lessThan(20));
  });

  testWidgets('Enter di kolom password langsung login', (tester) async {
    await openLogin(tester, keyboardHeight: keyboard);
    await fillIn(tester);

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    expect(logins, hasLength(1));
    expect(logins.single.url.path, '/auth/login');
    expect(jsonDecode(logins.single.body)['nim'], '2211102001');
    expect(find.text('NIM/NIY atau password salah!'), findsOneWidget);
  });

  testWidgets('Enter dengan kolom kosong hanya menampilkan pesan',
      (tester) async {
    await openLogin(tester);
    await tester.enterText(field(0), '2211102001');
    await tester.enterText(field(1), '');

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    expect(find.text('Password Anda Belum Diisi!'), findsOneWidget);
    expect(logins, isEmpty);
  });

  testWidgets('Enter berkali-kali saat menunggu server hanya mengirim sekali',
      (tester) async {
    holdLogin = Completer<void>();
    await openLogin(tester);
    await fillIn(tester);

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    expect(logins, hasLength(1));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    holdLogin!.complete();
    await tester.pumpAndSettle();
    expect(find.text('Masuk'), findsOneWidget);
  });
}
