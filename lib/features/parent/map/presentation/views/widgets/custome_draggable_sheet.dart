import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/styles/sizes.dart';
import 'package:safe_bus/features/parent/dashboard/data/models/studentandbusroute.dart';
import 'package:safe_bus/features/parent/map/presentation/managers/cubit/student_route_cubit.dart';
import 'package:safe_bus/features/parent/map/presentation/views/widgets/busroute_listview_header.dart';

class CustomeDraggableSheet extends StatelessWidget {
  const CustomeDraggableSheet({super.key, required this.studentAndBusRoute});

  final Studentandbusroute studentAndBusRoute;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.25,
      minChildSize: 0.25,
      maxChildSize: 0.7,
      builder: (context, controller) {
        return Container(
          decoration: BoxDecoration(color: KColors.white),
          child: ListView.builder(
            padding: EdgeInsets.all(KSizes.md),
            physics: ClampingScrollPhysics(),
            controller: controller,
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BusRouteListViewHeader(
                    zoneName:
                        "Bus ${studentAndBusRoute.studnetroute.bus?.busNumber ?? ''} Zoned Route",
                    cityName: studentAndBusRoute.studnetroute.zoneName ?? '',
                    time: "",
                    distance: "",
                  ),
                  SizedBox(height: 16),
                  Text(
                    studentAndBusRoute.isMorning
                        ? "Pick Up Bus Route"
                        : "Drop Off Bus Route",
                    style: TextStyle(
                      fontSize: KSizes.fonstSizeLg,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 16),
                  _from(context),
                  SizedBox(height: 24),
                  _to(context),
                  SizedBox(height: 24),
                  _reportIssueButton(),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Container _reportIssueButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromARGB(40, 118, 118, 128),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.info, color: KColors.fontBlue),
          SizedBox(width: 16),
          Text("Report An Issue", style: TextStyle(color: KColors.grey)),
        ],
      ),
    );
  }

  Container _to(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: KColors.orangeAccent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("To", style: TextStyle(color: KColors.white)),
              Text(
                studentAndBusRoute.isMorning
                    ? studentAndBusRoute.studnetroute.schoolName ?? ''
                    : BlocProvider.of<StudentRouteCubit>(
                          context,
                        ).ride?.dropoffLocation?.description ??
                        '',
                style: TextStyle(color: KColors.white),
              ),
            ],
          ),
          Text(
            studentAndBusRoute.studnetroute.getFormattedEndTime(),
            style: TextStyle(color: KColors.white),
          ),
        ],
      ),
    );
  }

  Container _from(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromARGB(40, 118, 118, 128),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("From", style: TextStyle(color: KColors.grey)),
              Text(
                studentAndBusRoute.isMorning
                    ? BlocProvider.of<StudentRouteCubit>(
                          context,
                        ).ride?.pickupLocation?.description ??
                        ''
                    : studentAndBusRoute.studnetroute.schoolName ?? '',
                style: TextStyle(color: KColors.grey),
              ),
            ],
          ),
          Text(
            studentAndBusRoute.studnetroute.getFormattedStartTime(),
            style: TextStyle(color: KColors.grey),
          ),
        ],
      ),
    );
  }
}
