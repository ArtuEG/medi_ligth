import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_buttons.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/brand_logo.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController =
      TextEditingController(text: 'andrea.gomez@medilight.mx');
  final _passwordController = TextEditingController();
  bool _remember = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final controller = context.read<AuthController>();
    final ok = await controller.login(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (!mounted) return;
    if (ok) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
    } else {
      _showError(controller.errorMessage);
    }
  }

  void _showError(String? message) {
    if (message == null) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), backgroundColor: AppColors.danger),
      );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<AuthController, bool>((c) => c.isLoading);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(28, 6, 28, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _IconButton(
                icon: Icons.arrow_back,
                onTap: () => Navigator.of(context).maybePop(),
              ),
              const SizedBox(height: 18),
              Row(
                children: const [
                  BrandLogo(size: 48),
                  SizedBox(width: 12),
                  Wordmark(size: 28),
                ],
              ),
              const SizedBox(height: 26),
              const Text(
                'Iniciar sesión',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink900,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Bienvenida de nuevo. Accede a tu turno.',
                style: TextStyle(fontSize: 14, color: AppColors.ink500),
              ),
              const SizedBox(height: 26),
              AppTextField(
                label: 'Correo electrónico',
                icon: Icons.mail_outline,
                controller: _emailController,
                hint: 'tu@correo.com',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Contraseña',
                icon: Icons.lock_outline,
                controller: _passwordController,
                hint: '••••••••',
                obscureText: true,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _submit(),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _RememberMe(
                    value: _remember,
                    onChanged: (v) => setState(() => _remember = v),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      '¿Olvidaste tu contraseña?',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.purple600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: 'Iniciar sesión',
                isLoading: isLoading,
                onPressed: _submit,
              ),
              const SizedBox(height: 22),
              const _OrDivider(),
              const SizedBox(height: 22),
              Row(
                children: const [
                  Expanded(child: _SocialButton(label: 'Google')),
                  SizedBox(width: 12),
                  Expanded(child: _SocialButton(label: 'Huella', mint: true)),
                ],
              ),
              const SizedBox(height: 26),
              Center(
                child: Text.rich(
                  TextSpan(
                    style: const TextStyle(
                      fontSize: 13.5,
                      color: AppColors.ink500,
                    ),
                    children: [
                      const TextSpan(text: '¿No tienes cuenta? '),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: GestureDetector(
                          onTap: () =>
                              Navigator.of(context).pushNamed(AppRoutes.signup),
                          child: const Text(
                            'Crear cuenta',
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.purple600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 40,
        height: 40,
        child: Icon(icon, size: 22, color: AppColors.ink700),
      ),
    );
  }
}

class _RememberMe extends StatelessWidget {
  const _RememberMe({required this.value, required this.onChanged});
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: value ? AppColors.purple600 : Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: value ? AppColors.purple600 : AppColors.ink300,
                width: 1.5,
              ),
            ),
            child: value
                ? const Icon(Icons.check, size: 13, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 8),
          const Text(
            'Recordarme',
            style: TextStyle(fontSize: 13, color: AppColors.ink700),
          ),
        ],
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: Divider(color: AppColors.line, height: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'o continúa con',
            style: TextStyle(fontSize: 12, color: AppColors.ink300),
          ),
        ),
        Expanded(child: Divider(color: AppColors.line, height: 1)),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.label, this.mint = false});
  final String label;
  final bool mint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.line, width: 1.5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (mint)
                const Icon(Icons.shield_outlined, size: 18, color: AppColors.teal)
              else
                const _GoogleGlyph(),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.ink700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Disco multicolor que aproxima el logo de Google (CSS: conic-gradient).
class _GoogleGlyph extends StatelessWidget {
  const _GoogleGlyph();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: SweepGradient(
          colors: [
            Color(0xFFEA4335),
            Color(0xFFEA4335),
            Color(0xFFFBBC05),
            Color(0xFFFBBC05),
            Color(0xFF34A853),
            Color(0xFF34A853),
            Color(0xFF4285F4),
            Color(0xFF4285F4),
          ],
          stops: [0, .25, .25, .5, .5, .75, .75, 1],
        ),
      ),
    );
  }
}
