import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/config/api_config.dart';
import 'core/network/http_client.dart';
import 'core/routing/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/data/repositories/auth_repository_http/auth_repository_http.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/use_cases/sign_in_use_case.dart';
import 'features/auth/domain/use_cases/sign_up_use_case.dart';
import 'features/auth/presentation/controllers/auth_controller.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/signup_page.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/landing/presentation/pages/landing_page.dart';

void main() {
  // -------------------------------------------------------------------------
  // Inyección de dependencias manual (sin frameworks de DI).
  // Se construye el grafo de afuera hacia adentro: config → infra → data →
  // domain → presentation.
  // -------------------------------------------------------------------------
  final apiConfig = ApiConfig.fromEnvironment();
  final httpClient = HttpClient(config: apiConfig);

  final AuthRepository authRepository = AuthRepositoryHttp(httpClient);

  final signInUseCase = SignInUseCase(authRepository);
  final signUpUseCase = SignUpUseCase(authRepository);

  runApp(
    MediLightApp(
      signInUseCase: signInUseCase,
      signUpUseCase: signUpUseCase,
    ),
  );
}

class MediLightApp extends StatelessWidget {
  const MediLightApp({
    super.key,
    required this.signInUseCase,
    required this.signUpUseCase,
  });

  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthController(
            signIn: signInUseCase,
            signUp: signUpUseCase,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'MediLight',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        initialRoute: AppRoutes.landing,
        routes: {
          AppRoutes.landing: (_) => const LandingPage(),
          AppRoutes.login: (_) => const LoginPage(),
          AppRoutes.signup: (_) => const SignupPage(),
          AppRoutes.home: (_) => const HomePage(),
        },
      ),
    );
  }
}
