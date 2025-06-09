import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/styles/sizes.dart';
import 'package:safe_bus/core/utils/app_routes.dart';
import 'package:safe_bus/core/utils/helper_functions.dart';
import 'package:safe_bus/core/utils/toast.dart';
import 'package:safe_bus/features/parent/dashboard/data/models/studentandbusroute.dart';

class BusSchedule extends StatelessWidget {
  const BusSchedule({super.key, required this.studentAndBusRoute});
  final Studentandbusroute studentAndBusRoute;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: KColors.lighterGrey),
        borderRadius: BorderRadius.all(Radius.circular(KSizes.buttonRadius)),
      ),
      child: Column(
        children: [
          Text(
            studentAndBusRoute.studnetroute.getFormattedDate(),
            style: TextStyle(
              color: KColors.black,
              fontWeight: FontWeight.w500,
              fontSize: KSizes.fontSizeMd,
            ),
          ),
          SizedBox(height: KSizes.spaceBtwItems),
          _asistantTeacherInfo(context: context),
          SizedBox(height: KSizes.spaceBtwItems),
          _pickupAndDropoffInfo(),
          SizedBox(height: KSizes.spaceBtwItems),
          _busArrivalInfo(),
          SizedBox(height: KSizes.defaultSpace),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: Text(
                "Track The Bus",
                style: TextStyle(
                  color: KColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: KSizes.fonstSizeSm,
                ),
              ),
              onPressed: () {
                GoRouter.of(
                  context,
                ).push(AppRouter.parentMap, extra: studentAndBusRoute);
              },
            ),
          ),
        ],
      ),
    );
  }

  Row _busArrivalInfo() {
    return Row(
      children: [
        Icon(Icons.bus_alert, size: KSizes.iconMd),
        SizedBox(width: 8),
        Text(
          studentAndBusRoute.studnetroute.bus?.busNumber ?? '',
          style: TextStyle(
            color: KColors.black,
            fontWeight: FontWeight.bold,
            fontSize: KSizes.fonstSizeSm,
          ),
        ),
        SizedBox(width: 8),
        Text(
          "Arrival at ",
          style: TextStyle(color: KColors.black, fontSize: KSizes.fonstSizeSm),
        ),
        Text(
          studentAndBusRoute.studnetroute.getFormattedEndTime(),
          style: TextStyle(
            color: KColors.greenSecondary,
            fontSize: KSizes.fonstSizeSm,
          ),
        ),
        Text(
          " to the school. ",
          style: TextStyle(color: KColors.black, fontSize: KSizes.fonstSizeSm),
        ),
      ],
    );
  }

  Row _pickupAndDropoffInfo() {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: KColors.fontBlue,
                      borderRadius: BorderRadius.circular(
                        KSizes.borderRadiusSm,
                      ),
                    ),
                    child: Icon(
                      Icons.location_on,
                      color: KColors.white,
                      size: KSizes.iconSm,
                    ),
                  ),
                  SizedBox(width: KSizes.sm),
                  Expanded(
                    child: Text(
                      "Pick-up Point",
                      style: TextStyle(
                        color: KColors.black,
                        fontSize: KSizes.fonstSizexSm,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                studentAndBusRoute.isMorning
                    ? "${studentAndBusRoute.studnetroute.zoneName} Home"
                    : "${studentAndBusRoute.studnetroute.schoolName}",
                style: TextStyle(
                  color: KColors.black,
                  fontSize: KSizes.fonstSizeSm,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8),
        Text("--"),
        Container(
          width: 90,
          decoration: BoxDecoration(
            border: Border.all(color: KColors.lighterGrey),
            borderRadius: BorderRadius.circular(KSizes.borderRadiusLg),
          ),
          child: Text(
            studentAndBusRoute.studnetroute.getTimeLeftString(),
            style: TextStyle(
              color: KColors.black,
              fontSize: KSizes.fonstSizexSm,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Text("--"),
        SizedBox(width: 8),

        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: KColors.greenSecondary,
                      borderRadius: BorderRadius.circular(
                        KSizes.borderRadiusxLg,
                      ),
                    ),
                    child: Icon(
                      Icons.circle,
                      color: KColors.white,
                      size: KSizes.sm,
                    ),
                  ),
                  SizedBox(width: KSizes.sm),
                  Expanded(
                    child: Text(
                      "Drop-off Point",
                      style: TextStyle(
                        color: KColors.black,
                        fontSize: KSizes.fonstSizexSm,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                studentAndBusRoute.isMorning
                    ? "${studentAndBusRoute.studnetroute.schoolName}"
                    : "${studentAndBusRoute.studnetroute.zoneName} Home",
                style: TextStyle(
                  color: KColors.black,
                  fontSize: KSizes.fonstSizeSm,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row _asistantTeacherInfo({required BuildContext context}) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: KColors.fontBlue,
          radius: 16,
          child: Icon(Icons.person, color: KColors.white),
        ),
        SizedBox(width: KSizes.xs),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              studentAndBusRoute.studnetroute.assistantTeacher?.name ?? '',
              style: TextStyle(
                color: KColors.black,
                fontWeight: FontWeight.bold,
                fontSize: KSizes.fonstSizexSm,
              ),
            ),
            Text(
              "Assistant Teacher",
              style: TextStyle(
                color: KColors.darkGrey,
                fontSize: KSizes.fonstSizexSm,
              ),
            ),
          ],
        ),
        Spacer(),
        CircleAvatar(
          backgroundColor: KColors.greenSecondary,
          radius: 16,
          child: IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(Icons.messenger),
            color: KColors.white,
            onPressed: () async {
              try {
                await KHlper.launchSMS(
                  phoneNumber:
                      studentAndBusRoute
                          .studnetroute
                          .assistantTeacher
                          ?.phoneNo ??
                      '',
                );
              } catch (e) {
                Toast(
                  context,
                ).showToast(message: e.toString(), color: KColors.fadedRed);
              }
            },
          ),
        ),
        SizedBox(width: KSizes.md),
        CircleAvatar(
          backgroundColor: KColors.greenSecondary,
          radius: 16,
          child: IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(Icons.phone),
            color: KColors.white,
            onPressed: () async {
              try {
                await KHlper.launchPhoneCall(
                  phoneNumber:
                      studentAndBusRoute
                          .studnetroute
                          .assistantTeacher
                          ?.phoneNo ??
                      '',
                );
              } catch (e) {
                Toast(
                  context,
                ).showToast(message: e.toString(), color: KColors.fadedRed);
              }
            },
          ),
        ),
      ],
    );
  }
}
