import 'package:go_router/go_router.dart';
import 'package:safe_bus/features/driver/map/presentation/driver_map_screen.dart';
import 'package:safe_bus/features/parent/home/presentation/parent_home_screen.dart';
import 'package:safe_bus/features/shared/login/presentation/views/login_screen.dart';
import 'package:safe_bus/features/shared/login/presentation/views/splash_screen.dart';

import '../../features/parent/parent_dashboard_screen.dart';
import '../../features/teacher/dashboard/teacher_dashboard_screen.dart';

//GoRouter.of(context).push(AppRouter.login);

abstract class AppRouter {
  AppRouter._();

  static final String splash = "/";
  static final String login = "/login";
  static final String driverMap = "/driverMap";
  static final String parentHomePage = "/parentHomePage";
  static final String parentDashboard = "/parentDashboard";
  static final String teacherDashboard = "/teacherDashboard";
  static final String driverDashboard = "/driverDashboard";
  static final String adminDashboard = "/adminDashboard";
  static final router = GoRouter(
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: login,
        builder: (context, state) {
          final extraData = state.extra as Map<String, dynamic>?;
          return LoginScreen(extraData: extraData);
        },
      ),
      GoRoute(
        path: parentHomePage,
        builder: (context, state) => const ParentHomeScreen(),
      ),
      GoRoute(
        path: driverMap,
        builder: (context, state) => const DriverMapScreen(),
      ),
      GoRoute(
        path: parentDashboard,
        builder: (context, state) => const ParentDashboardScreen(),
      ),
      GoRoute(
        path: teacherDashboard,
        builder: (context, state) => const TeacherDashboardScreen(),
      ),
      GoRoute(
        path: driverDashboard,
        builder: (context, state) => const ParentDashboardScreen(),
      ),
      GoRoute(
        path: adminDashboard,
        builder: (context, state) => const ParentDashboardScreen(),
      ),
      GoRoute(path: login, builder: (context, state) => const LoginScreen()),
      GoRoute(path: driverMap, builder: (context, state) => const DriverMapScreen(),),
      GoRoute(path: parentHomePage, builder: (context, state) => const ParentHomeScreen(),),
    ],
    initialLocation: parentHomePage,
  );
}
