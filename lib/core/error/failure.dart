/// Errores de dominio expresados como tipos (no excepciones) para que las
/// capas superiores puedan tratarlos exhaustivamente con `switch`.
sealed class Failure {
  const Failure(this.message);

  /// Mensaje apto para mostrar al usuario.
  final String message;
}

/// Sin conexión / timeout / host inalcanzable.
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Sin conexión. Revisa tu red.']);
}

/// El servidor respondió con un error (5xx u otros no controlados).
class ServerFailure extends Failure {
  const ServerFailure([
    super.message = 'Ocurrió un error en el servidor. Intenta más tarde.',
  ]);
}

/// Credenciales inválidas / no autorizado (401/403).
class CredentialsFailure extends Failure {
  const CredentialsFailure([
    super.message = 'Correo o contraseña incorrectos.',
  ]);
}

/// Conflicto, p. ej. correo ya registrado (409).
class ConflictFailure extends Failure {
  const ConflictFailure([super.message = 'El correo ya está registrado.']);
}

/// Validación local fallida antes de tocar el backend.
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// Cualquier error no clasificado.
class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Ocurrió un error inesperado.']);
}
