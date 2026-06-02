import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_buttons.dart';
import '../../../../core/widgets/brand_logo.dart';
import '../../../../core/widgets/image_slot.dart';

/// Pantalla de inicio (welcome) que aparece al arrancar la app.
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.welcomeBackground),
        child: Stack(
          children: [
            // Sparkles decorativas (CSS: Spark).
            const Positioned(
              top: 70,
              left: 28,
              child: _Spark(hex: '#35B9A3', rotation: -15, size: 16),
            ),
            const Positioned(
              top: 50,
              right: 32,
              child: _Spark(hex: '#B9A4EE', rotation: 20, size: 13, heart: true),
            ),
            const Positioned(
              top: 250,
              left: 20,
              child: _Spark(hex: '#B9A4EE', rotation: 10, size: 12, heart: true),
            ),
            const Positioned(
              top: 200,
              right: 26,
              child: _Spark(hex: '#35B9A3', rotation: 8, size: 15),
            ),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 8, 30, 30),
                child: Column(
                  children: [
                    const SizedBox(height: 26),
                    const BrandLogo(size: 70),
                    const SizedBox(height: 14),
                    const Wordmark(size: 40),
                    const SizedBox(height: 12),
                    Text(
                      'CONECTANDO ENFERMERÍA,\nCUIDANDO VIDAS 💜',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        letterSpacing: 12 * 0.16,
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                        color: AppColors.purple500,
                      ),
                    ),
                    const SizedBox(height: 26),
                    const ImageSlot(
                      size: 244,
                      label: 'Ilustración enfermera',
                      icon: Icons.health_and_safety_outlined,
                      boxShadow: AppColors.shadowCard,
                    ),
                    const Spacer(),
                    PrimaryButton(
                      label: 'Iniciar sesión',
                      onPressed: () =>
                          Navigator.of(context).pushNamed(AppRoutes.login),
                    ),
                    const SizedBox(height: 12),
                    GhostButton(
                      label: 'Crear cuenta',
                      onPressed: () =>
                          Navigator.of(context).pushNamed(AppRoutes.signup),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Al continuar aceptas los Términos y la Política de privacidad.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11, color: AppColors.ink300),
                    ),
                  ],
                ),
              ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pequeña decoración (cruz "+" o corazón) del fondo del welcome.
class _Spark extends StatelessWidget {
  const _Spark({
    required this.hex,
    this.rotation = 0,
    this.size = 14,
    this.heart = false,
  });

  final String hex;
  final double rotation;
  final double size;
  final bool heart;

  @override
  Widget build(BuildContext context) {
    final svg = heart
        ? '<svg viewBox="0 0 24 24" fill="$hex" xmlns="http://www.w3.org/2000/svg"><path d="M12 21s-7-4.6-9.5-9C1 8.5 2.8 4.5 6.5 4.5c2.1 0 3.6 1.4 5.5 3 1.9-1.6 3.4-3 5.5-3C21.2 4.5 23 8.5 21.5 12 19 16.4 12 21 12 21z"/></svg>'
        : '<svg viewBox="0 0 24 24" fill="none" stroke="$hex" stroke-width="3" stroke-linecap="round" xmlns="http://www.w3.org/2000/svg"><path d="M12 5v14M5 12h14"/></svg>';
    return Transform.rotate(
      angle: rotation * 3.1415926535 / 180,
      child: Opacity(
        opacity: 0.7,
        child: SvgPicture.string(svg, width: size, height: size),
      ),
    );
  }
}
