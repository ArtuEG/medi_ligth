import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../error/exceptions.dart';

/// Wrapper delgado sobre `package:http` que centraliza:
/// - construcción de URLs vía [ApiConfig]
/// - headers por defecto (JSON)
/// - traducción de respuestas/errores de red a [AppException]
///
/// Vive en `core` porque lo comparten todos los repositorios de la capa data.
class HttpClient {
  HttpClient({required ApiConfig config, http.Client? client})
      : _config = config,
        _client = client ?? http.Client();

  final ApiConfig _config;
  final http.Client _client;

  static const Duration _timeout = Duration(seconds: 15);

  Future<Map<String, dynamic>> post(
    String path, {
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _client
          .post(
            _config.endpoint(path),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.acceptHeader: 'application/json',
              ...?headers,
            },
            body: jsonEncode(body),
          )
          .timeout(_timeout);

      return _handleResponse(response);
    } on SocketException {
      throw const NetworkException();
    } on TimeoutException {
      throw const NetworkException('La solicitud tardó demasiado.');
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    final status = response.statusCode;

    if (status >= 200 && status < 300) {
      if (response.body.isEmpty) return <String, dynamic>{};
      return jsonDecode(response.body) as Map<String, dynamic>;
    }

    switch (status) {
      case 401:
      case 403:
        throw const UnauthorizedException();
      case 409:
        throw const ConflictException();
      default:
        throw ServerException(status, 'HTTP $status');
    }
  }

  void close() => _client.close();
}
