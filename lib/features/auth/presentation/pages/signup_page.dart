import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_buttons.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/brand_logo.dart';
import '../controllers/auth_controller.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final controller = context.read<AuthController>();
    final ok = await controller.register(
      fullName: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      confirmPassword: _confirmController.text,
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
              InkWell(
                onTap: () => Navigator.of(context).maybePop(),
                borderRadius: BorderRadius.circular(12),
                child: const SizedBox(
                  width: 40,
                  height: 40,
                  child: Icon(Icons.arrow_back, size: 22, color: AppColors.ink700),
                ),
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
                'Crear cuenta',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink900,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Únete a MediLight y conecta con tu equipo.',
                style: TextStyle(fontSize: 14, color: AppColors.ink500),
              ),
              const SizedBox(height: 26),
              AppTextField(
                label: 'Nombre completo',
                icon: Icons.person_outline,
                controller: _nameController,
                hint: 'Andrea Gómez',
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
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
                hint: 'Mínimo 8 caracteres',
                obscureText: true,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Confirmar contraseña',
                icon: Icons.lock_outline,
                controller: _confirmController,
                hint: '••••••••',
                obscureText: true,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _submit(),
              ),
              const SizedBox(height: 28),
              PrimaryButton(
                label: 'Crear cuenta',
                isLoading: isLoading,
                onPressed: _submit,
              ),
              const SizedBox(height: 20),
              Center(
                child: Text.rich(
                  TextSpan(
                    style: const TextStyle(
                      fontSize: 13.5,
                      color: AppColors.ink500,
                    ),
                    children: [
                      const TextSpan(text: '¿Ya tienes cuenta? '),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).maybePop(),
                          child: const Text(
                            'Iniciar sesión',
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
