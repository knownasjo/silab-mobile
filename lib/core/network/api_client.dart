import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silab/app_config.dart';
import 'package:silab/core/exceptions/exceptions.dart';

/// Satu-satunya pintu ke backend SILAB.
///
/// Mengurus alamat server, token login, JSON, dan penerjemahan error, supaya
/// setiap data source cukup menyebut endpoint dan cara membaca hasilnya.
/// Pesan error dari backend diteruskan apa adanya lewat
/// [RequestErrorException].
///
/// Access token hanya berlaku 15 menit. Bila backend menolaknya karena
/// kedaluwarsa, token baru diminta dengan refresh token (berlaku 1 hari) dan
/// permintaan diulang sekali. Baru bila refresh token juga ditolak, error
/// "jwt expired" diteruskan dan halaman mengarahkan pengguna ke login.
class ApiClient {
  final http.Client _client;
  final SharedPreferences _sharedPreferences;

  static const Duration _timeout = Duration(seconds: 20);
  static const String _expiredTokenMessage = 'jwt expired';

  /// Beberapa permintaan yang gagal bersamaan cukup memicu satu refresh.
  Future<String?>? _pendingRefresh;

  ApiClient(this._client, this._sharedPreferences);

  Future<Map<String, dynamic>> get(String path, {String? accessToken}) =>
      _send('GET', path, accessToken: accessToken);

  Future<Map<String, dynamic>> post(String path, {Object? body}) =>
      _send('POST', path, body: body);

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
    );
  }

  Future<String?> _refreshAccessToken() {
    return _pendingRefresh ??=
        _requestNewAccessToken().whenComplete(() => _pendingRefresh = null);
  }

  /// Mengembalikan null bila sesi sudah berakhir (tidak ada refresh token
  /// atau backend menolaknya). Gangguan jaringan tetap dilempar sebagai error
  /// jaringan, supaya pengguna tidak dikeluarkan hanya karena sinyal buruk.
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

  Future<http.Response> _request(
    String method,
    String path, {
    Object? body,
    String? accessToken,
  }) async {
    final request =
        http.Request(method, Uri.parse('${AppConfig.shared.baseUrl}$path'));

    if (accessToken != null) {
      request.headers['Authorization'] = 'Bearer $accessToken';
    }

    if (body != null) {
      request.headers['Content-Type'] = 'application/json';
      request.body = jsonEncode(body);
    }

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
    try {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
    } on FormatException {
      // Misalnya halaman HTML "Cannot GET ..." dari Express.
    }

    throw RequestErrorException(
        'Respons server tidak dikenali (HTTP ${response.statusCode}).');
  }
}
