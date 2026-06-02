import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Placeholder para una imagen aún no provista (equivalente al `<image-slot>`
/// del prototipo). Muestra un marco punteado con ícono y etiqueta.
class ImageSlot extends StatelessWidget {
  const ImageSlot({
    super.key,
    required this.size,
    this.circle = true,
    this.label,
    this.icon = Icons.image_outlined,
    this.boxShadow,
    this.ringColor,
  });

  final double size;
  final bool circle;
  final String? label;
  final IconData icon;
  final List<BoxShadow>? boxShadow;
  final Color? ringColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.purple050,
        shape: circle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: circle ? null : BorderRadius.circular(20),
        border: Border.all(color: AppColors.purple200, width: 1.5),
        boxShadow: boxShadow,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: size * 0.22, color: AppColors.purple400),
          if (label != null) ...[
            SizedBox(height: size * 0.04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                label!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.ink500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
