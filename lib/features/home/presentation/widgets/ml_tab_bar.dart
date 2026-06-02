import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class MlTab {
  const MlTab(this.label, this.icon);
  final String label;
  final IconData icon;
}

/// Barra de navegación inferior (CSS: `.tabbar`) con indicador de home.
class MlTabBar extends StatelessWidget {
  const MlTabBar({super.key, required this.activeIndex, required this.onChanged});

  final int activeIndex;
  final ValueChanged<int> onChanged;

  static const List<MlTab> _tabs = [
    MlTab('Inicio', Icons.home_outlined),
    MlTab('Favoritos', Icons.star_border),
    MlTab('Historial', Icons.access_time),
    MlTab('Perfil', Icons.person_outline),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xEBFFFFFF), // rgba(255,255,255,.92)
        border: Border(top: BorderSide(color: AppColors.line)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 4),
              child: Row(
                children: [
                  for (var i = 0; i < _tabs.length; i++)
                    Expanded(child: _TabButton(
                      tab: _tabs[i],
                      active: i == activeIndex,
                      onTap: () => onChanged(i),
                    )),
                ],
              ),
            ),
            Container(
              height: 5,
              width: 134,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1C1530).withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.tab,
    required this.active,
    required this.onTap,
  });

  final MlTab tab;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.purple600 : AppColors.ink300;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(tab.icon, size: 23, color: color),
            const SizedBox(height: 4),
            Text(
              tab.label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
