import '../../../../../core/network/http_client.dart';
import '../../../domain/models/auth_session.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../dtos/auth_response_dto.dart';

/// Implementación HTTP de [AuthRepository].
///
/// Habla con el backend a través de [HttpClient] y mapea las respuestas a
/// modelos de dominio mediante los DTOs. Las excepciones de red/servidor las
/// propaga el [HttpClient]; los casos de uso las traducen a `Failure`.
class AuthRepositoryHttp implements AuthRepository {
  const AuthRepositoryHttp(this._client);

  final HttpClient _client;

  @override
  Future<AuthSession> signIn({
    required String email,
    required String password,
  }) async {
    final json = await _client.post(
      '/auth/login',
      body: {'email': email, 'password': password},
    );
    return AuthResponseDto.fromJson(json).toDomain();
  }

  @override
  Future<AuthSession> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final json = await _client.post(
      '/auth/register',
      body: {
        'full_name': fullName,
        'email': email,
        'password': password,
      },
    );
    return AuthResponseDto.fromJson(json).toDomain();
  }
}
