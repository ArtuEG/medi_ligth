import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/brand_logo.dart';

/// Pantalla placeholder de marca para secciones aún no construidas
/// (CSS: `Stub`). Header púrpura con título + cuerpo centrado.
class StubPage extends StatelessWidget {
  const StubPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: AppColors.gradPurple,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 4, 20, 18),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).maybePop(),
                      borderRadius: BorderRadius.circular(12),
                      child: const SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(Icons.arrow_back, size: 22, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Opacity(opacity: 0.5, child: BrandLogo(size: 56)),
                  const SizedBox(height: 16),
                  Text(
                    'Pantalla «$title» — próximo paso del flujo.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, color: AppColors.ink500),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
