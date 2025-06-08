import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/styles/sizes.dart';
import 'package:safe_bus/features/parent/dashboard/presentation/manager/parent_home_cubit.dart';
import 'package:safe_bus/features/parent/dashboard/presentation/views/widgets/absence_button.dart';
import 'package:safe_bus/features/parent/dashboard/presentation/views/widgets/bus_schedule.dart';
import 'package:safe_bus/features/parent/dashboard/presentation/views/widgets/children_list_view.dart';
import 'package:safe_bus/features/parent/dashboard/presentation/views/widgets/parent_home_header.dart';
import 'package:safe_bus/features/parent/dashboard/presentation/views/widgets/send_absence_report.dart';

class ParentHomeBody extends StatelessWidget {
  const ParentHomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            children: [
              ParentHomeHeader(),
              SizedBox(height: KSizes.spaceBtwItems),
              ChildrenList(),
              SizedBox(height: KSizes.defaultSpace),
              BlocProvider.of<ParentHomeCubit>(context).isAbsent == true
                  ? AbsenceReport()
                  : Column(
                    children: [
                      if (BlocProvider.of<ParentHomeCubit>(
                        context,
                      ).student!.isPending())
                        AbsenceButton(),
                      SizedBox(height: KSizes.defaultSpace),
                      Column(
                        children: [
                          if (BlocProvider.of<ParentHomeCubit>(
                                context,
                              ).student?.morningRoute() !=
                              null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Morning Period Bus",
                                  style: TextStyle(
                                    color: KColors.black,
                                    fontSize: KSizes.fonstSizexLg,
                                  ),
                                ),
                                SizedBox(height: KSizes.sm),
                                BusSchedule(
                                  studentRoute:
                                      BlocProvider.of<ParentHomeCubit>(
                                        context,
                                      ).student!.morningRoute()!,
                                ),
                                SizedBox(height: KSizes.spaceBtwItems),
                              ],
                            ),
                          if (BlocProvider.of<ParentHomeCubit>(
                                context,
                              ).student?.afternoonRoute() !=
                              null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Afternoon Period Bus",
                                  style: TextStyle(
                                    color: KColors.black,
                                    fontSize: KSizes.fonstSizexLg,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                                SizedBox(height: KSizes.sm),
                                BusSchedule(
                                  studentRoute:
                                      BlocProvider.of<ParentHomeCubit>(
                                        context,
                                      ).student!.afternoonRoute()!,
                                ),
                                SizedBox(height: KSizes.spaceBtwItems),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
