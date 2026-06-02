import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

const double _kButtonHeight = 54;

/// Botón primario "pill" con gradiente púrpura (CSS: `.btn-primary`).
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null && !isLoading;
    return Opacity(
      opacity: enabled ? 1 : 0.7,
      child: Container(
        height: _kButtonHeight,
        decoration: BoxDecoration(
          gradient: AppColors.gradPurple,
          borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
          boxShadow: const [
            BoxShadow(
              color: Color(0xE66A45C9), // rgba(106,69,201,.9)
              offset: Offset(0, 12),
              blurRadius: 26,
              spreadRadius: -12,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
            onTap: enabled ? onPressed : null,
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                  : Text(
                      label,
                      style: AppTypography.button.copyWith(color: Colors.white),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Botón secundario "ghost" (CSS: `.btn-ghost`): blanco, texto púrpura.
class GhostButton extends StatelessWidget {
  const GhostButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _kButtonHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
        border: Border.all(color: AppColors.purple200, width: 1.5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
          onTap: onPressed,
          child: Center(
            child: Text(
              label,
              style: AppTypography.button.copyWith(color: AppColors.purple600),
            ),
          ),
        ),
      ),
    );
  }
}
