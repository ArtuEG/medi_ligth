/// Configuración del backend.
///
/// **Único punto** donde se define la URL del API. Cuando tengas el backend
/// real solo cambias [baseUrl] aquí (o lo inyectas por `--dart-define`).
///
/// Ejecutar con override:
///   flutter run --dart-define=API_BASE_URL=https://api.medilight.com
class ApiConfig {
  const ApiConfig({required this.baseUrl});

  final String baseUrl;

  /// Construye la config leyendo `API_BASE_URL` del entorno de compilación,
  /// con un valor por defecto para desarrollo.
  factory ApiConfig.fromEnvironment() {
    const url = String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'https://api.medilight.dev',
    );
    return const ApiConfig(baseUrl: url);
  }

  Uri endpoint(String path) => Uri.parse('$baseUrl$path');
}
