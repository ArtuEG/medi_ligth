import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_typography.dart';

/// Ensambla paleta ([AppColors]) y tipografía ([AppTypography]) en un
/// [ThemeData] Material 3. Se inyecta una sola vez en `MaterialApp`.
abstract final class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.purple600,
      brightness: Brightness.light,
    ).copyWith(
      primary: AppColors.purple600,
      secondary: AppColors.teal,
      surface: AppColors.surface,
      error: AppColors.danger,
      onPrimary: AppColors.onPrimary,
      onSurface: AppColors.ink900,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.bg,
      textTheme: AppTypography.textTheme(AppColors.ink900),
      fontFamily: AppTypography.fontFamily,
      splashFactory: InkRipple.splashFactory,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        foregroundColor: AppColors.ink900,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
    );
  }
}
