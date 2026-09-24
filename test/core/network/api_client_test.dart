import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silab/app_config.dart';
import 'package:silab/core/exceptions/exceptions.dart';
import 'package:silab/core/network/api_client.dart';

void main() {
  late SharedPreferences prefs;

  setUp(() async {
    AppConfig.create(baseUrl: 'http://silab.test');
    SharedPreferences.setMockInitialValues({'accessToken': 'token-mahasiswa'});
    prefs = await SharedPreferences.getInstance();
  });

  ApiClient apiReturning(
          Future<http.Response> Function(http.Request) handler) =>
      ApiClient(MockClient(handler), prefs);

  Matcher throwsRequestError(String message) => throwsA(
        isA<RequestErrorException>()
            .having((e) => e.message, 'message', message),
      );

  test('mengirim token login dan body JSON ke alamat server', () async {
    late http.Request sent;
    final api = apiReturning((request) async {
      sent = request;
      return http.Response(jsonEncode({'status': true, 'message': 'ok'}), 201);
    });

    final json = await api.post('/activation', body: {
      'subjectIds': ['s1'],
    });

    expect(json['status'], true);
    expect(sent.url.toString(), 'http://silab.test/activation');
    expect(sent.headers['Authorization'], 'Bearer token-mahasiswa');
    expect(sent.headers['Content-Type'], startsWith('application/json'));
    expect(jsonDecode(sent.body), {
      'subjectIds': ['s1'],
    });
  });

  test('token bisa diberikan langsung, dipakai saat login untuk /auth/me',
      () async {
    late http.Request sent;
    final api = apiReturning((request) async {
      sent = request;
      return http.Response(jsonEncode({'status': true}), 200);
    });

    await api.get('/auth/me', accessToken: 'token-baru');

    expect(sent.headers['Authorization'], 'Bearer token-baru');
  });

  test('pesan error backend diteruskan apa adanya', () async {
    final api = apiReturning((_) async => http.Response(
        jsonEncode({'status': false, 'message': 'Sesi presensi belum dibuka!'}),
        403));

    await expectLater(
      api.post('/subject/classes/c1/meetings/m1/attendances'),
      throwsRequestError('Sesi presensi belum dibuka!'),
    );
  });

  test('halaman HTML "Cannot GET" dari Express tidak membuat aplikasi crash',
      () async {
    final api = apiReturning((_) async =>
        http.Response('<pre>Cannot GET /registrations/me</pre>', 404));

    await expectLater(
      api.get('/registrations/me'),
      throwsRequestError('Respons server tidak dikenali (HTTP 404).'),
    );
  });

  test('server tidak bisa dihubungi', () async {
    final api = apiReturning(
        (_) async => throw http.ClientException('Connection refused'));

    await expectLater(
      api.get('/class/me'),
      throwsRequestError(
          'Tidak dapat terhubung ke server. Periksa koneksi internet.'),
    );
  });

  group('access token kedaluwarsa', () {
    const attendancePath = '/subject/classes/c1/meetings/m1/attendances';

    http.Response expired() => http.Response(
        jsonEncode({'status': false, 'message': 'jwt expired'}), 400);

    http.Response refreshed(String accessToken) => http.Response(
        jsonEncode({
          'status': true,
          'message': 'Token berhasil diperbarui',
          'data': {'accessToken': accessToken},
        }),
        200);

    setUp(() async {
      SharedPreferences.setMockInitialValues({
        'accessToken': 'token-lama',
        'refreshToken': 'refresh-sah',
      });
      prefs = await SharedPreferences.getInstance();
    });

    test('diperbarui dengan refresh token, lalu permintaan diulang', () async {
      final sent = <http.Request>[];
      final api = apiReturning((request) async {
        sent.add(request);
        if (request.url.path == '/auth/refresh') return refreshed('token-baru');
        if (request.headers['Authorization'] != 'Bearer token-baru') {
          return expired();
        }
        return http.Response(
            jsonEncode(
                {'status': true, 'message': 'Presensi berhasil dicatat'}),
            201);
      });

      final json = await api.post(attendancePath, body: {'token': 'Ab12Cd'});

      expect(json['message'], 'Presensi berhasil dicatat');
      expect(sent.map((r) => r.url.path),
          [attendancePath, '/auth/refresh', attendancePath]);
      expect(jsonDecode(sent[1].body), {'refreshToken': 'refresh-sah'});
      expect(sent[1].headers['Authorization'], isNull);
      expect(jsonDecode(sent[2].body), {'token': 'Ab12Cd'});
      expect(prefs.getString('accessToken'), 'token-baru');
    });

    test('permintaan yang gagal bersamaan hanya memicu satu refresh', () async {
      var refreshCount = 0;
      final api = apiReturning((request) async {
        if (request.url.path == '/auth/refresh') {
          refreshCount++;
          await Future<void>.delayed(const Duration(milliseconds: 50));
          return refreshed('token-baru');
        }
        return request.headers['Authorization'] == 'Bearer token-baru'
            ? http.Response(jsonEncode({'status': true}), 200)
            : expired();
      });

      final results = await Future.wait([
        api.get('/class/me'),
        api.get('/announcement'),
        api.get('/auth/me'),
      ]);

      expect(results.map((json) => json['status']), [true, true, true]);
      expect(refreshCount, 1);
    });

    test(
        'refresh token ditolak server (mis. password diganti): token dihapus '
        'dan sesi diumumkan berakhir', () async {
      final api =
          apiReturning((request) async => request.url.path == '/auth/refresh'
              ? http.Response(
                  jsonEncode({
                    'status': false,
                    'message': 'Sesi berakhir, silakan login kembali!',
                  }),
                  401)
              : expired());
      var sessionEnded = 0;
      final subscription = api.sessionEnded.listen((_) => sessionEnded++);

      await Future.wait([
        expectLater(api.get('/class/me'),
            throwsRequestError('Sesi berakhir, silakan masuk kembali.')),
        expectLater(api.get('/auth/me'),
            throwsRequestError('Sesi berakhir, silakan masuk kembali.')),
      ]);
      await Future<void>.delayed(Duration.zero);

      expect(prefs.getString('accessToken'), isNull);
      expect(prefs.getString('refreshToken'), isNull);
      expect(sessionEnded, 1);
      await subscription.cancel();
    });

    test('tanpa refresh token: diminta masuk kembali', () async {
      await prefs.remove('refreshToken');
      final api = apiReturning((_) async => expired());

      await expectLater(api.get('/class/me'),
          throwsRequestError('Sesi berakhir, silakan masuk kembali.'));
    });

    test('server error saat refresh: pengguna tidak dikeluarkan', () async {
      final api = apiReturning((request) async =>
          request.url.path == '/auth/refresh'
              ? http.Response('{}', 500)
              : expired());
      var sessionEnded = 0;
      final subscription = api.sessionEnded.listen((_) => sessionEnded++);

      await expectLater(api.get('/class/me'),
          throwsRequestError('Terjadi kesalahan (HTTP 500).'));
      await Future<void>.delayed(Duration.zero);

      expect(prefs.getString('refreshToken'), 'refresh-sah');
      expect(sessionEnded, 0);
      await subscription.cancel();
    });

    test(
        'jaringan putus saat refresh: yang muncul error jaringan, '
        'pengguna tidak dikeluarkan', () async {
      final api = apiReturning((request) async {
        if (request.url.path == '/auth/refresh') {
          throw http.ClientException('Connection reset');
        }
        return expired();
      });

      await expectLater(
        api.get('/class/me'),
        throwsRequestError(
            'Tidak dapat terhubung ke server. Periksa koneksi internet.'),
      );
    });
  });

  group('stream event real-time (SSE)', () {
    const eventsPath = '/events';

    http.StreamedResponse eventStream(List<String> chunks) =>
        http.StreamedResponse(
          Stream.fromIterable(chunks.map(utf8.encode)),
          200,
          headers: {'content-type': 'text/event-stream'},
        );

    http.StreamedResponse jsonStream(Object body, int statusCode) =>
        http.StreamedResponse(
          Stream.value(utf8.encode(jsonEncode(body))),
          statusCode,
        );

    setUp(() async {
      SharedPreferences.setMockInitialValues({
        'accessToken': 'token-lama',
        'refreshToken': 'refresh-sah',
      });
      prefs = await SharedPreferences.getInstance();
    });

    test('meneruskan event perubahan, mengabaikan ping, dan mengirim token',
        () async {
      final sent = <http.BaseRequest>[];
      final api = ApiClient(
        MockClient.streaming((request, _) async {
          sent.add(request);
          return eventStream([
            'event: ready\ndata: {}\n\nevent: pi',
            'ng\ndata: {}\n\nevent: meeting\ndata: {"meeting_id":"m1"}\n',
            '\nevent: attendance\ndata: {"meeting_id":"m1"}\n\n',
          ]);
        }),
        prefs,
      );

      final events = await api.listen(eventsPath).take(3).toList();

      expect(events.map((event) => event.type),
          ['ready', 'meeting', 'attendance']);
      expect(events[1].data, {'meeting_id': 'm1'});
      expect(events[0].data, isEmpty);
      expect(sent.single.url.path, eventsPath);
      expect(sent.single.headers['Authorization'], 'Bearer token-lama');
      expect(sent.single.headers['Accept'], 'text/event-stream');
    });

    test('access token kedaluwarsa: diperbarui lalu tersambung', () async {
      final tokens = <String?>[];
      final api = ApiClient(
        MockClient.streaming((request, _) async {
          if (request.url.path == '/auth/refresh') {
            return jsonStream({
              'status': true,
              'data': {'accessToken': 'token-baru'},
            }, 200);
          }
          tokens.add(request.headers['Authorization']);
          return request.headers['Authorization'] == 'Bearer token-baru'
              ? eventStream(['event: ready\ndata: {}\n\n'])
              : jsonStream({'status': false, 'message': 'jwt expired'}, 400);
        }),
        prefs,
      );

      expect((await api.listen(eventsPath).first).type, 'ready');
      expect(tokens, ['Bearer token-lama', 'Bearer token-baru']);
      expect(prefs.getString('accessToken'), 'token-baru');
    });

    test('tersambung ulang otomatis setelah server menutup koneksi', () async {
      var connections = 0;
      final api = ApiClient(
        MockClient.streaming((request, _) async {
          connections++;
          return eventStream([
            connections == 1
                ? 'event: ready\ndata: {}\n\n'
                : 'event: meeting\ndata: {}\n\n',
          ]);
        }),
        prefs,
      );

      final events = await api.listen(eventsPath).take(2).toList();

      expect(events.map((event) => event.type), ['ready', 'meeting']);
      expect(connections, 2);
    });

    test('server tidak bisa dihubungi: dicoba lagi sampai tersambung',
        () async {
      var attempts = 0;
      final api = ApiClient(
        MockClient.streaming((request, _) async {
          attempts++;
          if (attempts == 1) throw http.ClientException('Connection refused');
          return eventStream(['event: ready\ndata: {}\n\n']);
        }),
        prefs,
      );

      expect((await api.listen(eventsPath).first).type, 'ready');
      expect(attempts, 2);
    });

    test('berhenti tersambung ulang setelah langganan dibatalkan', () async {
      var connections = 0;
      final api = ApiClient(
        MockClient.streaming((request, _) async {
          connections++;
          return eventStream(['event: ready\ndata: {}\n\n']);
        }),
        prefs,
      );

      expect((await api.listen(eventsPath).first).type, 'ready');
      await Future<void>.delayed(const Duration(milliseconds: 1500));

      expect(connections, 1);
    });
  });
}
