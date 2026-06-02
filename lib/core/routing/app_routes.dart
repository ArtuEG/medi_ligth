/// Nombres de ruta centralizados para la navegación con rutas nombradas.
abstract final class AppRoutes {
  AppRoutes._();

  static const String landing = '/';
  static const String login = '/login';
  static const String signup = '/signup';

  // Placeholder del home post-autenticación (se construirá en otra feature).
  static const String home = '/home';
}
