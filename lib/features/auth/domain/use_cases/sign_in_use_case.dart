import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/result.dart';
import '../models/auth_session.dart';
import '../repositories/auth_repository.dart';

/// Caso de uso: iniciar sesión.
///
/// Valida la entrada localmente y orquesta el [AuthRepository], traduciendo
/// las excepciones de infraestructura a [Failure] de dominio.
class SignInUseCase {
  const SignInUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<AuthSession>> call({
    required String email,
    required String password,
  }) async {
    final trimmedEmail = email.trim();

    if (trimmedEmail.isEmpty || password.isEmpty) {
      return const Err(ValidationFailure('Completa todos los campos.'));
    }
    if (!_isValidEmail(trimmedEmail)) {
      return const Err(ValidationFailure('Ingresa un correo válido.'));
    }

    try {
      final session = await _repository.signIn(
        email: trimmedEmail,
        password: password,
      );
      return Ok(session);
    } on UnauthorizedException {
      return const Err(CredentialsFailure());
    } on NetworkException catch (e) {
      return Err(NetworkFailure(e.message));
    } on ServerException {
      return const Err(ServerFailure());
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }

  static bool _isValidEmail(String email) {
    final regex = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');
    return regex.hasMatch(email);
  }
}
