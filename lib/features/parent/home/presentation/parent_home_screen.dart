import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_bus/core/styles/sizes.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/utils/app_routes.dart';
import 'package:safe_bus/features/parent/home/presentation/widgets/absence_report.dart';
import 'package:safe_bus/features/parent/home/presentation/widgets/absence_switch_button.dart';
import 'package:safe_bus/features/parent/home/presentation/widgets/bus_schedule.dart';
import 'package:safe_bus/features/parent/home/presentation/widgets/children_list_view.dart';

class ParentHomeScreen extends StatefulWidget {
  const ParentHomeScreen({super.key});

  @override
  State<ParentHomeScreen> createState() => _ParentHomeScreenState();
}

class _ParentHomeScreenState extends State<ParentHomeScreen> {
  bool isAbsent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(KSizes.md, KSizes.sm, KSizes.md, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildHeader(),
                AbsenceSwitch(
                  onChanged: (value) {
                    setState(() {
                      isAbsent = value;
                    });
                  },
                ),
                SizedBox(height: KSizes.defaultSpace,),
                if(isAbsent)
                  AbsenceReport()
                else
                  Column(
                    children: [
                      Text("Morning Period Bus",
                        style: TextStyle(
                          color: KColors.black,
                          fontSize: KSizes.fonstSizexLg,
                        ),
                      textAlign: TextAlign.end,
                      ),
                      BusSchedule(),
                      Text("Afternoon Period Bus",
                        style: TextStyle(
                          color: KColors.black,
                          fontSize: KSizes.fonstSizexLg,
                        ),
                      textAlign: TextAlign.end,
                      ),
                      BusSchedule(),
                    ],
                  )
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget _buildHeader(){
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Good morning,",
                    style: TextStyle(
                      color: KColors.darkGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: KSizes.fonstSizexLg,
                      height: 0
                    )
                  ),
                  Text("Ahmad",
                    style: TextStyle(
                      color: KColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: KSizes.fonstSizexLg,
                      height: 0
                    )
                  ),
                ],
              ),
              Spacer(),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: KColors.white,
                  borderRadius: BorderRadius.all(Radius.circular(KSizes.buttonRadius)),
                  boxShadow: [
                    BoxShadow(
                      color: KColors.lighterGrey,
                      blurRadius: 10,
                      spreadRadius: 0.5,
                      offset: Offset(0, 8)
                    )
                  ]
                ),
                child: IconButton(
                  icon: Icon(Icons.notifications),
                  iconSize: KSizes.iconMd,
                  onPressed: () { //ToDo:
                    GoRouter.of(context).push(AppRouter.splash);
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text("Children",
                style: TextStyle(
                  color: KColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: KSizes.fonstSizeLg,
                ),
              ),
            Expanded(child: ChildrenList())
            ],
          ),
        ]
      )
    );
  }
}
 