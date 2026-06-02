import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/image_slot.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../widgets/ml_tab_bar.dart';
import 'stub_page.dart';

/// Modelo de una tarjeta del menú principal.
class _MenuItem {
  const _MenuItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.tint,
    required this.tintSoft,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color tint;
  final Color tintSoft;
}

/// Home / menú principal (CSS: `HomeScreen`) — header mint + tarjetas + tabs.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tab = 0;

  static const List<_MenuItem> _items = [
    _MenuItem(
      title: 'Alertas',
      description: 'Envía o recibe alertas de ayuda rápida',
      icon: Icons.notifications_none,
      tint: AppColors.coral,
      tintSoft: AppColors.coralSoft,
    ),
    _MenuItem(
      title: 'Protocolos',
      description: 'Guías clínicas y procedimientos',
      icon: Icons.menu_book_outlined,
      tint: AppColors.teal,
      tintSoft: AppColors.tealSoft,
    ),
    _MenuItem(
      title: 'Comunicación',
      description: 'Chat y mensajes con tu equipo',
      icon: Icons.chat_bubble_outline,
      tint: AppColors.purple600,
      tintSoft: AppColors.purple100,
    ),
    _MenuItem(
      title: 'Ubicación',
      description: 'Ubicación del personal y áreas del hospital',
      icon: Icons.location_on_outlined,
      tint: AppColors.blue,
      tintSoft: AppColors.blueSoft,
    ),
  ];

  void _openStub(String title) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => StubPage(title: title)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final session = context.read<AuthController>().session;
    final fullName = session?.user.fullName ?? 'Andrea';
    final firstName = fullName.split(' ').first;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: _tab == 0 ? _menu(firstName) : _tabPlaceholder(),
      bottomNavigationBar: MlTabBar(
        activeIndex: _tab,
        onChanged: (i) => setState(() => _tab = i),
      ),
    );
  }

  Widget _menu(String firstName) {
    return Column(
      children: [
        // Header mint
        Container(
          decoration: const BoxDecoration(
            gradient: AppColors.gradMint,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 6, 24, 26),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '¡Hola, $firstName! 👋',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '¿Qué necesitas hoy?',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.92),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.5),
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: const ImageSlot(
                      size: 48,
                      label: null,
                      icon: Icons.person_outline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Tarjetas
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            itemCount: _items.length,
            separatorBuilder: (_, _) => const SizedBox(height: 14),
            itemBuilder: (_, i) => _MenuCard(
              item: _items[i],
              onTap: () => _openStub(_items[i].title),
            ),
          ),
        ),
      ],
    );
  }

  Widget _tabPlaceholder() {
    return const Center(
      child: Text(
        'Próximamente',
        style: TextStyle(fontSize: 15, color: AppColors.ink500),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  const _MenuCard({required this.item, required this.onTap});

  final _MenuItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.line),
            boxShadow: AppColors.shadowSoft,
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: item.tintSoft,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(item.icon, size: 26, color: item.tint),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.ink900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.description,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.35,
                        color: AppColors.ink500,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, size: 20, color: AppColors.ink300),
            ],
          ),
        ),
      ),
    );
  }
}
