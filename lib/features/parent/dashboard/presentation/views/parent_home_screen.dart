import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/features/parent/dashboard/presentation/views/widgets/parent_home_body.dart';
import 'package:safe_bus/features/parent/dashboard/presentation/manager/parent_home_cubit.dart';

class ParentHomeScreen extends StatelessWidget {
  const ParentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ParentHomeCubit, ParentHomeState>(
        builder: (context, state) {
          if (state is ParentHomeLoading) {
            return Center(
              child: CircularProgressIndicator(color: KColors.greenPrimary),
            );
          } else if (state is ParentHomeError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return ParentHomeBody();
          }
        },
      ),
    );
  }
}
