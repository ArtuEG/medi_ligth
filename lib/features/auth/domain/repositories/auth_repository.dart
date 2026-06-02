import '../models/auth_session.dart';

/// Puerto (interfaz) de autenticación. La capa de dominio define el contrato;
/// la capa `data` provee la implementación concreta (HTTP, mock, etc.).
///
/// Las implementaciones lanzan `AppException` ante fallos; los casos de uso
/// las traducen a `Failure` de dominio.
abstract interface class AuthRepository {
  /// Inicia sesión con correo y contraseña.
  Future<AuthSession> signIn({
    required String email,
    required String password,
  });

  /// Registra un nuevo usuario y devuelve la sesión ya autenticada.
  Future<AuthSession> signUp({
    required String fullName,
    required String email,
    required String password,
  });
}
