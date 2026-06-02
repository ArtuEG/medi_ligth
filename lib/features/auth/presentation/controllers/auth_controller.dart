import 'package:flutter/foundation.dart';

import '../../../../core/utils/result.dart';
import '../../domain/models/auth_session.dart';
import '../../domain/use_cases/sign_in_use_case.dart';
import '../../domain/use_cases/sign_up_use_case.dart';

enum AuthStatus { idle, loading, authenticated, error }

/// Controlador de presentación para el flujo de autenticación.
///
/// Orquesta los casos de uso y expone estado observable a la UI vía
/// [ChangeNotifier] + `provider`. No conoce HTTP ni repositorios concretos.
class AuthController extends ChangeNotifier {
  AuthController({
    required SignInUseCase signIn,
    required SignUpUseCase signUp,
  })  : _signIn = signIn,
        _signUp = signUp;

  final SignInUseCase _signIn;
  final SignUpUseCase _signUp;

  AuthStatus _status = AuthStatus.idle;
  AuthStatus get status => _status;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  AuthSession? _session;
  AuthSession? get session => _session;

  bool get isLoading => _status == AuthStatus.loading;

  Future<bool> login({required String email, required String password}) {
    return _run(() => _signIn(email: email, password: password));
  }

  Future<bool> register({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    return _run(
      () => _signUp(
        fullName: fullName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      ),
    );
  }

  /// Ejecuta un caso de uso gestionando el ciclo de estado loading→ok/error.
  /// Devuelve `true` si la autenticación fue exitosa.
  Future<bool> _run(Future<Result<AuthSession>> Function() action) async {
    _setStatus(AuthStatus.loading);

    final result = await action();
    switch (result) {
      case Ok(:final value):
        _session = value;
        _errorMessage = null;
        _setStatus(AuthStatus.authenticated);
        return true;
      case Err(:final failure):
        _errorMessage = failure.message;
        _setStatus(AuthStatus.error);
        return false;
    }
  }

  void clearError() {
    if (_errorMessage == null) return;
    _errorMessage = null;
    _status = AuthStatus.idle;
    notifyListeners();
  }

  void _setStatus(AuthStatus status) {
    _status = status;
    notifyListeners();
  }
}
