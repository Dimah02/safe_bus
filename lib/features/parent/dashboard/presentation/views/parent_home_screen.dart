import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/utils/app_routes.dart';
import 'package:safe_bus/features/parent/dashboard/presentation/views/widgets/parent_home_body.dart';
import 'package:safe_bus/features/parent/dashboard/presentation/manager/parent_home_cubit.dart';
import 'package:safe_bus/features/shared/login/presentation/manager/cubit/auth_cubit.dart';
import 'package:safe_bus/features/shared/login/presentation/views/widgets/bottom_nav_bar.dart';

class ParentHomeScreen extends StatelessWidget {
  ParentHomeScreen({super.key});

  int? _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child: BlocBuilder<ParentHomeCubit, ParentHomeState>(
              builder: (context, state) {
                if (state is ParentHomeLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: KColors.greenPrimary,
                    ),
                  );
                } else if (state is ParentHomeError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else {
                  return ParentHomeBody();
                }
              },
            ),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(
              child: BottomNavBar(
                currentIndex: _currentIndex!,
                userType: context.read<AuthCubit>().user.userType ?? 0,
                onTap: (index) {
                  _currentIndex = index;
                  if (index == 1) {
                    context.go(AppRouter.profile);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
