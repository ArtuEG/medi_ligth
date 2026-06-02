import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_colors.dart';

/// Logo de marca: corazón con gradiente + línea de pulso (ECG) + cruz.
///
/// Replica el SVG del prototipo (`ml-icons.jsx`) para mantener la marca
/// pixel-perfect. viewBox 0 0 48 48.
class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key, this.size = 64});

  final double size;

  static const String _svg = '''
<svg width="48" height="48" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="ml" x1="6" y1="6" x2="42" y2="44" gradientUnits="userSpaceOnUse">
      <stop stop-color="#9277E6"/>
      <stop offset="1" stop-color="#6A45C9"/>
    </linearGradient>
  </defs>
  <path d="M24 42.7l-2.9-2.64C10.8 30.72 4 24.56 4 17 4 10.84 8.84 6 15 6c3.48 0 6.82 1.62 9 4.18C26.18 7.62 29.52 6 33 6c6.16 0 11 4.84 11 11 0 7.56-6.8 13.72-17.1 23.08L24 42.7z" fill="url(#ml)"/>
  <path d="M9 24.5h5.4l2.2-5.4 3.4 10 2.6-7 1.8 3.4H30" stroke="#fff" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
  <g stroke="#fff" stroke-width="2.4" stroke-linecap="round">
    <path d="M35 14v6M32 17h6"/>
  </g>
</svg>''';

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(_svg, width: size, height: size);
  }
}

/// Wordmark "MediLight" bicolor.
class Wordmark extends StatelessWidget {
  const Wordmark({super.key, this.size = 34});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: size,
          letterSpacing: -size * 0.01,
          height: 1,
        ),
        children: const [
          TextSpan(text: 'Medi', style: TextStyle(color: AppColors.wordmarkMedi)),
          TextSpan(
            text: 'Light',
            style: TextStyle(color: AppColors.wordmarkLight),
          ),
        ],
      ),
    );
  }
}
