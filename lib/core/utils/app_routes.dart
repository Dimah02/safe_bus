import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_bus/features/driver/dashboard/data/models/driver_home/trip.dart';
import 'package:safe_bus/features/driver/dashboard/presentation/views/driver_dashboard_screen.dart';
import 'package:safe_bus/features/driver/map/presentation/views/driver_map_screen.dart';

import 'package:safe_bus/features/parent/dashboard/presentation/views/parent_home_screen.dart';
import 'package:safe_bus/features/parent/dashboard/presentation/manager/parent_cubit.dart';
import 'package:safe_bus/features/parent/dashboard/data/repo/parent_repository.dart';
import 'package:safe_bus/features/parent/map/presentation/views/parent_map_screen.dart';

import 'package:safe_bus/features/shared/login/presentation/views/login_screen.dart';
import 'package:safe_bus/features/shared/login/presentation/views/splash_screen.dart';
import 'package:safe_bus/features/teacher/Home/presentation/views/teacher_dashboard_screen.dart';

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
        builder:
            (context, state) => BlocProvider(
              create:
                  (_) => ParentCubit(ParentRepository.instance)..getParent(),
              child: const ParentHomeScreen(),
            ),
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
        builder: (context, state) => DriverMapScreen(trip: state.extra as Trip),
      ),
      GoRoute(
        path: parentMap,
        builder: (context, state) => const ParentMapScreen(),
      ),
    ],
  );
}
