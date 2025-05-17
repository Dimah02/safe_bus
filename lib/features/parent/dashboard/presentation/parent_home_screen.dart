import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_bus/core/styles/sizes.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/features/parent/dashboard/presentation/widgets/absence_report.dart';
import 'package:safe_bus/features/parent/dashboard/presentation/widgets/absence_switch_button.dart';
import 'package:safe_bus/features/parent/dashboard/presentation/widgets/bus_schedule.dart';
import 'package:safe_bus/features/parent/dashboard/presentation/widgets/children_list_view.dart';
import 'package:safe_bus/features/parent/data/manager/parent_cubit.dart';
import 'package:safe_bus/features/parent/data/models/parents_model.dart';
import 'package:safe_bus/features/parent/data/models/students_model.dart';
import 'package:shimmer/shimmer.dart';

class ParentHomeScreen extends StatefulWidget {
  const ParentHomeScreen({super.key});

  @override
  State<ParentHomeScreen> createState() => _ParentHomeScreenState();
}

class _ParentHomeScreenState extends State<ParentHomeScreen> {
  late Parents parent;
  bool isAbsent = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ParentCubit>(context).getParent();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<ParentCubit, ParentState>(
      builder: (context, state) {
        if (state is ParentLoaded) {
          parent = (state).parent;
          return buildHomePage();
        } else if (state is ParentError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return skeletonLoder();
        }
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: buildBlocWidget()
      ),
    );
  }

  Widget buildHomePage(){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 16.0,
        ),
        child: Column(
          children: [
              _buildHeader(),
              SizedBox(height: KSizes.spaceBtwItems),
              ChildrenList(parent: parent),
              SizedBox(height: KSizes.defaultSpace),
              AbsenceSwitch(
                  onChanged: (value) {
                  setState(() {
                    isAbsent = value;
                  });
                },
              ),
              SizedBox(height: KSizes.defaultSpace),
              if (isAbsent)
                AbsenceReport()
              else
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
                    BusSchedule(),
                    SizedBox(height: KSizes.spaceBtwItems),
                    Text(
                      "Afternoon Period Bus",
                      style: TextStyle(
                        color: KColors.black,
                        fontSize: KSizes.fonstSizexLg,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    SizedBox(height: KSizes.sm),
                    BusSchedule(),
                    SizedBox(height: KSizes.spaceBtwItems),
                  ],
                ),
              ],
            ),
          ),
        );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning,',
              style: TextStyle(
                fontSize: 16,
                color: KColors.darkGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              parent.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: KColors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(KSizes.buttonRadius),
            ),
            boxShadow: [
              BoxShadow(
                color: KColors.lighterGrey,
                blurRadius: 10,
                spreadRadius: 0.5,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(Icons.notifications),
            iconSize: KSizes.iconMd,
            onPressed: () {
              //ToDo:
            },
          ),
        ),
      ],
    );
  }

  Widget skeletonLoder() {
    return Shimmer.fromColors(
      baseColor: KColors.lightGrey,
      highlightColor: KColors.lighterGrey,
      enabled: true,
      child: Container(
        height: 100,
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        )
      )
    );
  }
}