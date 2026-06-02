/// Excepciones de infraestructura lanzadas por la capa `data` (cliente HTTP).
///
/// Los repositorios las traducen a [Failure] de dominio; nunca deberían
/// propagarse hacia la capa de presentación.
sealed class AppException implements Exception {
  const AppException(this.message);
  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

class NetworkException extends AppException {
  const NetworkException([super.message = 'Network error']);
}

class ServerException extends AppException {
  const ServerException(this.statusCode, [super.message = 'Server error']);
  final int statusCode;
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([super.message = 'Unauthorized']);
}

class ConflictException extends AppException {
  const ConflictException([super.message = 'Conflict']);
}
