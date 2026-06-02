import 'user.dart';

/// Resultado de una autenticación exitosa: el usuario y su token de acceso.
class AuthSession {
  const AuthSession({
    required this.user,
    required this.accessToken,
  });

  final User user;
  final String accessToken;
}
