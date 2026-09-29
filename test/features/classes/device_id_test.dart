import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silab/app_config.dart';
import 'package:silab/core/device/device_id.dart';
import 'package:silab/core/failures/failures.dart';
import 'package:silab/core/network/api_client.dart';
import 'package:silab/features/authentication/data/data_sources/remote/authentication_api_service.dart';
import 'package:silab/features/authentication/data/models/login_model.dart';
import 'package:silab/features/classes/data/data_sources/classes_api_service.dart';
import 'package:silab/features/classes/data/repository/class_repository_impl.dart';

import '../../helpers/fixed_device_id.dart';

final phoneA = 'a' * 64;
const deviceUsed = 'HP ini sudah dipakai presensi akun lain di pertemuan ini.';

void main() {
  late SharedPreferences prefs;
  late List<Map<String, dynamic>> bodies;
  late http.Response Function() respond;

  setUp(() async {
    AppConfig.create(baseUrl: 'http://silab.test');
    SharedPreferences.setMockInitialValues({'accessToken': 'token'});
    prefs = await SharedPreferences.getInstance();
    bodies = [];
    respond = () => http.Response(
          jsonEncode({
            'status': true,
            'message': 'Berhasil',
            'data': {'accessToken': 'a', 'refreshToken': 'r'},
          }),
          200,
        );
  });

  ApiClient api() => ApiClient(
        MockClient((request) async {
          bodies.add(jsonDecode(request.body) as Map<String, dynamic>);
          return respond();
        }),
        prefs,
      );

  group('login', () {
    test('kode HP ikut dikirim', () async {
      await AuthenticationApiService(api(), FixedDeviceIdSource(phoneA))
          .userLogin(const LoginModel(nim: '2000016099', password: 'rahasia'));

      expect(bodies.single, {
        'nim': '2000016099',
        'password': 'rahasia',
        'device_id': phoneA,
      });
    });

    test('kode HP tidak terbaca: login tetap dikirim tanpa kode', () async {
      await AuthenticationApiService(api(), const FixedDeviceIdSource(null))
          .userLogin(const LoginModel(nim: '2000016099', password: 'rahasia'));

      expect(bodies.single.containsKey('device_id'), isFalse);
    });
  });

  group('scan QR', () {
    test('token QR dan kode HP dikirim bersama', () async {
      respond = () => http.Response(
            jsonEncode({
              'status': true,
              'message': 'Presensi berhasil dicatat',
              'data': {'meeting_id': 'm1'},
            }),
            201,
          );

      await ClassesApiService(api(), FixedDeviceIdSource(phoneA))
          .addUserAttendance(
              classId: 'c1', meetingId: 'm1', meetingToken: 'QR123');

      expect(bodies.single, {'token': 'QR123', 'device_id': phoneA});
    });

    test('HP sudah dipakai akun lain: pesan server diteruskan', () async {
      respond = () => http.Response(
            jsonEncode({'status': false, 'message': deviceUsed}),
            409,
          );

      final result = await ClassRepositoryImpl(
        ClassesApiService(api(), FixedDeviceIdSource(phoneA)),
      ).addUserAttendances(
          classId: 'c1', meetingId: 'm1', meetingToken: 'QR123');

      expect(result.isLeft, isTrue);
      expect(result.left, isA<RequestFailures>());
      expect(result.left.message, deviceUsed);
    });
  });

  test('plugin kode HP tidak tersedia: dibalas kosong, bukan error', () async {
    TestWidgetsFlutterBinding.ensureInitialized();

    expect(await const UdidDeviceIdSource().read(), isNull);
  });
}
