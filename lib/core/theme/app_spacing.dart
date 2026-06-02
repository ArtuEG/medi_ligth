/// Escala de espaciado y radios reutilizable (radios tomados de `styles.css`).
abstract final class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  // Radios de borde (CSS: --r-sm..--r-xl)
  static const double radiusSm = 12;
  static const double radiusMd = 16;
  static const double radiusLg = 22;
  static const double radiusXl = 28;

  /// Radio "pill" para botones (CSS: 999px).
  static const double radiusPill = 999;

  /// Radio de los inputs del prototipo (Field: 14px).
  static const double radiusField = 14;
}
