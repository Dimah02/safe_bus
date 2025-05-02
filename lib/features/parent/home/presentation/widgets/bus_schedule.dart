import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/styles/sizes.dart';
import 'package:safe_bus/core/utils/app_routes.dart';

class BusSchedule extends StatefulWidget {
  const BusSchedule({super.key});

  @override
  State<BusSchedule> createState() => _BusScheduleState();
}

class _BusScheduleState extends State<BusSchedule> {
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
            "Mon, 19 February 2025",
            style: TextStyle(
              color: KColors.black,
              fontWeight: FontWeight.w500,
              fontSize: KSizes.fontSizeMd,
            ),
          ),
          SizedBox(height: KSizes.defaultSpace),
          _asistantTeacherInfo(),
          SizedBox(height: KSizes.defaultSpace),
          _pickupAndDropoffInfo(),
          SizedBox(height: KSizes.defaultSpace),
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
                GoRouter.of(context).push(AppRouter.parentMap);
              },
            ),
          ),
        ],
      ),
    );
  }

  Row _busArrivalInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Icon(Icons.bus_alert, size: KSizes.iconMd),
        Text(
          "Bus 01",
          style: TextStyle(
            color: KColors.black,
            fontWeight: FontWeight.bold,
            fontSize: KSizes.fonstSizeSm,
          ),
        ),
        Spacer(),
        Text(
          "Arrival at",
          style: TextStyle(color: KColors.black, fontSize: KSizes.fonstSizeSm),
        ),
        Text(
          " 7:30 ",
          style: TextStyle(
            color: KColors.greenSecondary,
            fontSize: KSizes.fonstSizeSm,
          ),
        ),
        Text(
          "to XYZ School",
          style: TextStyle(color: KColors.black, fontSize: KSizes.fonstSizeSm),
        ),
        Spacer(),
      ],
    );
  }

  Row _pickupAndDropoffInfo() {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            color: KColors.fontBlue,
            borderRadius: BorderRadius.circular(KSizes.borderRadiusSm),
          ),
          child: Icon(
            Icons.location_on,
            color: KColors.white,
            size: KSizes.iconSm,
          ),
        ),
        SizedBox(width: KSizes.xs),
        Expanded(
          child: Column(
            children: [
              Text(
                "Pick-up Point",
                style: TextStyle(
                  color: KColors.black,
                  fontSize: KSizes.fonstSizexSm,
                ),
              ),
              Text(
                "XYZ Home",
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
            "Est. 30 min",
            style: TextStyle(
              color: KColors.black,
              fontSize: KSizes.fonstSizexSm,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Text("--"),
        SizedBox(width: 8),
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            color: KColors.greenSecondary,
            borderRadius: BorderRadius.circular(KSizes.borderRadiusxLg),
          ),
          child: Icon(Icons.circle, color: KColors.white, size: KSizes.sm),
        ),
        SizedBox(width: KSizes.xs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Drop-off Point",
                style: TextStyle(
                  color: KColors.black,
                  fontSize: KSizes.fonstSizexSm,
                ),
              ),
              Text(
                "XYZ School",
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

  Row _asistantTeacherInfo() {
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
              "Assma Awad",
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
            onPressed: () {
              //ToDo:
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
            onPressed: () {
              //ToDo:
            },
          ),
        ),
      ],
    );
  }
}
