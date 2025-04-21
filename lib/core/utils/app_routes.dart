import 'package:go_router/go_router.dart';
import 'package:safe_bus/features/shared/login/presentation/views/login_screen.dart';
import 'package:safe_bus/features/shared/login/presentation/views/splash_screen.dart';

abstract class AppRouter {
  AppRouter._();

  static final String splash = "/";
  static final String login = "/login";
  static final router = GoRouter(
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: login, builder: (context, state) => const LoginScreen()),
    ],
  );
}
