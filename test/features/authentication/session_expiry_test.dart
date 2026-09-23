import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silab/core/network/api_client.dart';
import 'package:silab/features/authentication/data/data_sources/local/authentication_local_datasource.dart';
import 'package:silab/features/authentication/data/data_sources/remote/authentication_api_service.dart';
import 'package:silab/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:silab/features/authentication/domain/usecases/get_session_expiry.dart';
import 'package:silab/features/authentication/domain/usecases/get_user_access_token_usecase.dart';
import 'package:silab/features/authentication/domain/usecases/user_login_usecase.dart';
import 'package:silab/features/authentication/domain/usecases/user_logout_usecase.dart';
import 'package:silab/features/authentication/presentation/bloc/authentication_bloc.dart';

String jwtExpiringAt(DateTime exp) {
  String encode(Map<String, Object> json) =>
      base64Url.encode(utf8.encode(jsonEncode(json))).replaceAll('=', '');

  return '${encode({'alg': 'HS256', 'typ': 'JWT'})}'
      '.${encode({'id': 'u1', 'exp': exp.millisecondsSinceEpoch ~/ 1000})}'
      '.tanda-tangan';
}

Future<AuthenticationState> checkSession(Map<String, Object> stored) async {
  SharedPreferences.setMockInitialValues(stored);
  final prefs = await SharedPreferences.getInstance();
  final repository = AuthenticationRepositoryImpl(
    AuthenticationApiService(
      ApiClient(MockClient((_) async => http.Response('{}', 500)), prefs),
    ),
    AuthenticationLocalDataSource(prefs),
  );
  final bloc = AuthenticationBloc(
    UserLoginUsecase(repository),
    GetUserAccessTokenUsecase(repository),
    GetSessionExpiry(repository),
    UserLogoutUsecase(repository),
  );

  bloc.add(CheckSessionExpiry());
  final state = await bloc.stream.first;
  await bloc.close();
  return state;
}

void main() {
  final now = DateTime.now();

  test(
      'access token sudah habis tetapi refresh token masih berlaku: tetap masuk',
      () async {
    final state = await checkSession({
      'accessToken': jwtExpiringAt(now.subtract(const Duration(hours: 1))),
      'refreshToken': jwtExpiringAt(now.add(const Duration(hours: 12))),
    });

    expect(state, isA<AuthenticationSuccess>());
  });

  test('refresh token sudah habis (lewat 1 hari): diarahkan ke login',
      () async {
    final state = await checkSession({
      'accessToken': jwtExpiringAt(now.subtract(const Duration(days: 1))),
      'refreshToken': jwtExpiringAt(now.subtract(const Duration(minutes: 1))),
    });

    expect(state, isA<SessionExpired>());
  });
}
