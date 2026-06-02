import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Tipografía central de MediLight basada en **Poppins** (Google Fonts).
///
/// Pesos del board: Regular 400 · Medium 500 · SemiBold 600 · Bold 700.
abstract final class AppTypography {
  AppTypography._();

  static const String fontFamily = 'Poppins';

  /// TextTheme Material 3 con Poppins y colores de texto de marca.
  static TextTheme textTheme(Color color) {
    return GoogleFonts.poppinsTextTheme().apply(
      bodyColor: color,
      displayColor: color,
    );
  }

  // Estilos semánticos reutilizables.
  static TextStyle get h1 => GoogleFonts.poppins(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: AppColors.ink900,
      );

  static TextStyle get title => GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.ink900,
      );

  static TextStyle get body => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.ink700,
        height: 1.4,
      );

  static TextStyle get caption => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.ink500,
      );

  static TextStyle get button => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      );
}
