import '../../domain/models/auth_session.dart';
import '../../domain/models/user.dart';

/// DTO de la respuesta de autenticación del backend.
///
/// Vive en la capa `data`: conoce el formato de cable (wire format) y mapea
/// hacia el modelo de dominio [AuthSession] con [toDomain]. El dominio nunca
/// ve este tipo.
///
/// Formato esperado:
/// ```json
/// {
///   "access_token": "...",
///   "user": { "id": "...", "full_name": "...", "email": "..." }
/// }
/// ```
class AuthResponseDto {
  const AuthResponseDto({
    required this.accessToken,
    required this.user,
  });

  final String accessToken;
  final UserDto user;

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) {
    return AuthResponseDto(
      accessToken: json['access_token'] as String,
      user: UserDto.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  AuthSession toDomain() => AuthSession(
        user: user.toDomain(),
        accessToken: accessToken,
      );
}

/// DTO del usuario tal como lo entrega el backend.
class UserDto {
  const UserDto({
    required this.id,
    required this.fullName,
    required this.email,
  });

  final String id;
  final String fullName;
  final String email;

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'].toString(),
      fullName: json['full_name'] as String? ?? '',
      email: json['email'] as String? ?? '',
    );
  }

  User toDomain() => User(id: id, fullName: fullName, email: email);
}
