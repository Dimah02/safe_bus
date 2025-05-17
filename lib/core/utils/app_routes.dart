import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_bus/features/driver/dashboard/driver_dashboard_screen.dart';
import 'package:safe_bus/features/driver/map/presentation/views/driver_map_screen.dart';
import 'package:safe_bus/features/parent/dashboard/presentation/parent_home_screen.dart';
import 'package:safe_bus/features/parent/data/manager/parent_cubit.dart';
import 'package:safe_bus/features/parent/data/repo/parent_repository.dart';
import 'package:safe_bus/features/parent/map/presentation/parent_map_screen.dart';
import 'package:safe_bus/features/shared/login/presentation/views/login_screen.dart';
import 'package:safe_bus/features/shared/login/presentation/views/splash_screen.dart';
import 'package:safe_bus/features/teacher/attendance_overview/attendance_overview_screen.dart';
import 'package:safe_bus/features/teacher/dashboard/teacher_dashboard_screen.dart';

//GoRouter.of(context).push(AppRouter.login);

abstract class AppRouter {
  AppRouter._();

  static final String splash = "/";
  static final String login = "/login";
  static final String driverMap = "/driverMap";
  static final String parentMap = "/parentMap";
  static final String parentDashboard = "/parentHomePage";
  static final String teacherDashboard = "/teacherDashboard";
  static final String driverDashboard = "/driverDashboard";
  static final String adminDashboard = "/adminDashboard";
  static final String attendance = "/attendance";
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: attendance,
        builder: (context, state) => const AttendanceOverviewScreen(),
      ),
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: login,
        builder: (context, state) {
          final extraData = state.extra as Map<String, dynamic>?;
          return LoginScreen(extraData: extraData);
        },
      ),
      GoRoute(
        path: parentDashboard,
        builder: (context, state) => BlocProvider(
          create: (_) => ParentCubit(ParentRepository())..getParent(),
          child: const ParentHomeScreen(),
        )
      ),
      GoRoute(
        path: teacherDashboard,
        builder: (context, state) => const TeacherDashboardScreen(),
      ),
      GoRoute(
        path: driverDashboard,
        builder: (context, state) => const DriverDashboardScreen(),
      ),
      GoRoute(
        path: driverMap,
        builder: (context, state) => const DriverMapScreen(),
      ),
      GoRoute(
        path: parentMap,
        builder: (context, state) => const ParentMapScreen(),
      ),
    ],
  );
}
