import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/result.dart';
import '../models/auth_session.dart';
import '../repositories/auth_repository.dart';

/// Caso de uso: registrar una cuenta nueva.
class SignUpUseCase {
  const SignUpUseCase(this._repository);

  final AuthRepository _repository;

  static const int _minPasswordLength = 8;

  Future<Result<AuthSession>> call({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final trimmedName = fullName.trim();
    final trimmedEmail = email.trim();

    if (trimmedName.isEmpty || trimmedEmail.isEmpty || password.isEmpty) {
      return const Err(ValidationFailure('Completa todos los campos.'));
    }
    if (!_isValidEmail(trimmedEmail)) {
      return const Err(ValidationFailure('Ingresa un correo válido.'));
    }
    if (password.length < _minPasswordLength) {
      return const Err(
        ValidationFailure('La contraseña debe tener al menos 8 caracteres.'),
      );
    }
    if (password != confirmPassword) {
      return const Err(ValidationFailure('Las contraseñas no coinciden.'));
    }

    try {
      final session = await _repository.signUp(
        fullName: trimmedName,
        email: trimmedEmail,
        password: password,
      );
      return Ok(session);
    } on ConflictException {
      return const Err(ConflictFailure());
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
