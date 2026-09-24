import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silab/app_config.dart';
import 'package:silab/core/exceptions/exceptions.dart';
import 'package:silab/core/network/server_event.dart';

class ApiClient {
  final http.Client _client;
  final SharedPreferences _sharedPreferences;

  static const Duration _timeout = Duration(seconds: 20);
  static const Duration _eventStreamIdleTimeout = Duration(seconds: 60);
  static const int _maxEventStreamRetrySeconds = 30;
  static const String _expiredTokenMessage = 'jwt expired';

  Future<String?>? _pendingRefresh;

  ApiClient(this._client, this._sharedPreferences);

  Future<Map<String, dynamic>> get(String path, {String? accessToken}) =>
      _send('GET', path, accessToken: accessToken);

  Future<Map<String, dynamic>> post(String path, {Object? body}) =>
      _send('POST', path, body: body);

  Stream<ServerEvent> listen(String path) {
    final abort = Completer<void>();
    late final StreamController<ServerEvent> controller;
    StreamSubscription<ServerEvent>? subscription;
    Timer? retryTimer;
    var failures = 0;
    late final Future<void> Function() connect;

    void reconnect({bool failed = false}) {
      subscription = null;
      if (abort.isCompleted) return;
      if (failed) failures++;

      retryTimer = Timer(
        Duration(
          seconds: min(1 << min(failures, 5), _maxEventStreamRetrySeconds),
        ),
        connect,
      );
    }

    connect = () async {
      try {
        final response = await _openEventStream(path, abort.future);

        if (abort.isCompleted) {
          await response.stream.listen(null).cancel();
          return;
        }

        subscription = response.stream
            .transform(utf8.decoder)
            .transform(const LineSplitter())
            .timeout(_eventStreamIdleTimeout)
            .transform(_serverEvents())
            .listen(
          (event) {
            failures = 0;
            if (event.type != 'ping') controller.add(event);
          },
          onError: (_) => reconnect(failed: true),
          onDone: reconnect,
          cancelOnError: true,
        );
      } on Exception {
        reconnect(failed: true);
      }
    };

    controller = StreamController<ServerEvent>(
      onListen: connect,
      onCancel: () {
        if (!abort.isCompleted) abort.complete();
        retryTimer?.cancel();
        return subscription?.cancel();
      },
    );

    return controller.stream;
  }

  Future<http.StreamedResponse> _openEventStream(
    String path,
    Future<void> abortTrigger,
  ) async {
    Future<http.StreamedResponse> open(String? accessToken) {
      final request = _buildRequest(
        'GET',
        path,
        accessToken: accessToken,
        abortTrigger: abortTrigger,
      )..headers['Accept'] = 'text/event-stream';

      return _client.send(request).timeout(_timeout);
    }

    var response = await open(_sharedPreferences.getString('accessToken'));
    if (response.statusCode == 200) return response;

    var json = _decode(await http.Response.fromStream(response));

    if (json['message'] == _expiredTokenMessage) {
      final newAccessToken = await _refreshAccessToken();

      if (newAccessToken != null) {
        response = await open(newAccessToken);
        if (response.statusCode == 200) return response;

        json = _decode(await http.Response.fromStream(response));
      }
    }

    throw RequestErrorException(
      json['message'] as String? ??
          'Terjadi kesalahan (HTTP ${response.statusCode}).',
    );
  }

  StreamTransformer<String, ServerEvent> _serverEvents() {
    String? type;
    var data = '';

    return StreamTransformer.fromHandlers(
      handleData: (line, sink) {
        if (line.startsWith('event:')) {
          type = line.substring(6).trim();
        } else if (line.startsWith('data:')) {
          data += line.substring(5).trim();
        } else if (line.isEmpty && type != null) {
          final decoded = _tryJsonDecode(data);
          sink.add(ServerEvent(
            type!,
            decoded is Map<String, dynamic> ? decoded : const {},
          ));
          type = null;
          data = '';
        }
      },
    );
  }

  Future<Map<String, dynamic>> _send(
    String method,
    String path, {
    Object? body,
    String? accessToken,
  }) async {
    var response = await _request(
      method,
      path,
      body: body,
      accessToken: accessToken ?? _sharedPreferences.getString('accessToken'),
    );
    var json = _decode(response);

    if (json['message'] == _expiredTokenMessage) {
      final newAccessToken = await _refreshAccessToken();

      if (newAccessToken != null) {
        response = await _request(
          method,
          path,
          body: body,
          accessToken: newAccessToken,
        );
        json = _decode(response);
      }
    }

    if (response.statusCode >= 200 && response.statusCode < 300) return json;

    throw RequestErrorException(
      json['message'] as String? ??
          'Terjadi kesalahan (HTTP ${response.statusCode}).',
      data: json['data'],
    );
  }

  Future<String?> _refreshAccessToken() {
    return _pendingRefresh ??=
        _requestNewAccessToken().whenComplete(() => _pendingRefresh = null);
  }

  Future<String?> _requestNewAccessToken() async {
    final refreshToken = _sharedPreferences.getString('refreshToken');
    if (refreshToken == null) return null;

    final response = await _request(
      'POST',
      '/auth/refresh',
      body: {'refreshToken': refreshToken},
    );
    if (response.statusCode != 200) return null;

    final data = _decode(response)['data'];
    final accessToken = data is Map ? data['accessToken'] : null;
    if (accessToken is! String) return null;

    await _sharedPreferences.setString('accessToken', accessToken);
    return accessToken;
  }

  http.Request _buildRequest(
    String method,
    String path, {
    Object? body,
    String? accessToken,
    Future<void>? abortTrigger,
  }) {
    final request = http.AbortableRequest(
      method,
      Uri.parse('${AppConfig.shared.baseUrl}$path'),
      abortTrigger: abortTrigger,
    );

    if (accessToken != null) {
      request.headers['Authorization'] = 'Bearer $accessToken';
    }

    if (body != null) {
      request.headers['Content-Type'] = 'application/json';
      request.body = jsonEncode(body);
    }

    return request;
  }

  Future<http.Response> _request(
    String method,
    String path, {
    Object? body,
    String? accessToken,
  }) async {
    final request =
        _buildRequest(method, path, body: body, accessToken: accessToken);

    try {
      return await http.Response.fromStream(
        await _client.send(request).timeout(_timeout),
      );
    } on TimeoutException {
      throw RequestErrorException(
          'Server tidak merespons. Periksa koneksi dan alamat server.');
    } on http.ClientException {
      throw RequestErrorException(
          'Tidak dapat terhubung ke server. Periksa koneksi internet.');
    }
  }

  Map<String, dynamic> _decode(http.Response response) {
    final decoded = _tryJsonDecode(response.body);
    if (decoded is Map<String, dynamic>) return decoded;

    throw RequestErrorException(
        'Respons server tidak dikenali (HTTP ${response.statusCode}).');
  }

  Object? _tryJsonDecode(String body) {
    try {
      return jsonDecode(body);
    } on FormatException {
      return null;
    }
  }
}
