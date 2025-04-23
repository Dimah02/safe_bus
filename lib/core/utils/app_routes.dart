import 'package:go_router/go_router.dart';
import 'package:safe_bus/features/driver/map/presentation/driver_map_screen.dart';
import 'package:safe_bus/features/shared/login/presentation/views/login_screen.dart';
import 'package:safe_bus/features/shared/login/presentation/views/splash_screen.dart';

//GoRouter.of(context).push(AppRouter.login);

abstract class AppRouter {
  AppRouter._();

  static final String splash = "/";
  static final String login = "/login";
  static final String driverMap = "/driverMap";
  static final router = GoRouter(
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: login, builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: driverMap,
        builder: (context, state) => const DriverMapScreen(),
      ),
    ],
  );
}
