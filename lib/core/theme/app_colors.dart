import 'package:flutter/material.dart';

/// Design tokens de MediLight — paleta tomada del concept board.
///
/// Única fuente de verdad para los colores de la app. Replica 1:1 las
/// variables CSS de `styles.css` del prototipo.
abstract final class AppColors {
  AppColors._();

  // ---------------------------------------------------------------------------
  // Marca — púrpura
  // ---------------------------------------------------------------------------
  static const Color purple700 = Color(0xFF6A45C9);
  static const Color purple600 = Color(0xFF7C5CE0); // primario / botones
  static const Color purple500 = Color(0xFF8E72E6);
  static const Color purple400 = Color(0xFFA992ED);
  static const Color purple300 = Color(0xFFB9A4EE);
  static const Color purple200 = Color(0xFFD6C8F5);
  static const Color purple100 = Color(0xFFECE4FB);
  static const Color purple050 = Color(0xFFF5F1FD);

  // ---------------------------------------------------------------------------
  // Acentos del board (mismo registro de croma)
  // ---------------------------------------------------------------------------
  static const Color teal = Color(0xFF35B9A3);
  static const Color tealSoft = Color(0xFFE1F5F0);
  static const Color coral = Color(0xFFF47B6E);
  static const Color coralSoft = Color(0xFFFCE7E4);
  static const Color amber = Color(0xFFF4C64B);
  static const Color amberSoft = Color(0xFFFCF3DA);
  static const Color lilac = Color(0xFFCBB9F2);
  static const Color blue = Color(0xFF5B8DEF);
  static const Color blueSoft = Color(0xFFE6EEFC);

  // ---------------------------------------------------------------------------
  // Estado
  // ---------------------------------------------------------------------------
  static const Color ok = Color(0xFF35B9A3);
  static const Color warn = Color(0xFFF4C64B);
  static const Color danger = Color(0xFFF0584B);

  // ---------------------------------------------------------------------------
  // Neutros (tibios, con micro-tinte lavanda)
  // ---------------------------------------------------------------------------
  static const Color ink900 = Color(0xFF211B33);
  static const Color ink700 = Color(0xFF4A4358);
  static const Color ink500 = Color(0xFF786F89);
  static const Color ink300 = Color(0xFFACA4BC);
  static const Color line = Color(0xFFECE8F2);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color bg = Color(0xFFF6F3FB);

  // Wordmark "Medi" / "Light"
  static const Color wordmarkMedi = Color(0xFF5B43B0);
  static const Color wordmarkLight = Color(0xFF9277E6);

  // ---------------------------------------------------------------------------
  // Aliases semánticos (para el ThemeData)
  // ---------------------------------------------------------------------------
  static const Color primary = purple600;
  static const Color primaryDark = purple700;
  static const Color secondary = teal;
  static const Color error = danger;
  static const Color background = bg;
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color textPrimary = ink900;
  static const Color textSecondary = ink500;
  static const Color textHint = ink300;
  static const Color border = line;

  // ---------------------------------------------------------------------------
  // Gradientes
  // ---------------------------------------------------------------------------

  /// Header / botón primario (CSS: 135deg #8E72E6 0%, #7C5CE0 60%, #6A45C9 100%).
  static const LinearGradient gradPurple = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [purple500, purple600, purple700],
    stops: [0.0, 0.6, 1.0],
  );

  /// Header del home (CSS: 135deg #5FCDBA 0%, #35B9A3 100%).
  static const LinearGradient gradMint = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF5FCDBA), teal],
  );

  /// Fondo de la pantalla de bienvenida (CSS: 180deg #F7F3FD 0%, #EFEAFB 100%).
  static const LinearGradient welcomeBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFF7F3FD), Color(0xFFEFEAFB)],
  );

  // ---------------------------------------------------------------------------
  // Sombras
  // ---------------------------------------------------------------------------
  static const List<BoxShadow> shadowCard = [
    BoxShadow(
      color: Color(0x47463282), // rgba(70,50,130,.28)
      offset: Offset(0, 6),
      blurRadius: 22,
      spreadRadius: -10,
    ),
  ];

  static const List<BoxShadow> shadowSoft = [
    BoxShadow(
      color: Color(0x2E463282), // rgba(70,50,130,.18)
      offset: Offset(0, 2),
      blurRadius: 10,
      spreadRadius: -4,
    ),
  ];
}
