import 'package:flutter/material.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/styles/sizes.dart';

class BusSchedule extends StatefulWidget {
  const BusSchedule({super.key});

  @override
  State<BusSchedule> createState() => _BusScheduleState();
}

class _BusScheduleState extends State<BusSchedule> {
  @override
  Widget build(BuildContext context) {
    return Container(
          alignment: Alignment(0, 0),
          margin: EdgeInsets.fromLTRB(0, KSizes.sm, 0, KSizes.md),
          padding: EdgeInsets.fromLTRB(KSizes.sm, KSizes.md, KSizes.sm, KSizes.md),
          decoration: BoxDecoration(
            border: Border.all(color: KColors.lighterGrey),
            borderRadius: BorderRadius.all(Radius.circular(KSizes.buttonRadius)),
          ),
          child: Column(
            children: [
              Text("Mon, 19 February 2025",
                style: TextStyle(
                  color: KColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: KSizes.fontSizeMd,
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                  backgroundColor: KColors.fontBlue,
                  child: Icon(Icons.person, color: KColors.white, size: KSizes.iconMd,),
                  ),
                  SizedBox(width: KSizes.xs,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Assma Awad",
                        style: TextStyle(
                          color: KColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: KSizes.fonstSizexSm,
                        ),
                      ),
                      Text("Assistant Teacher",
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
                    child: IconButton(
                      icon: Icon(Icons.messenger),
                      color: KColors.white,
                      iconSize: KSizes.iconMd,
                      onPressed: () {
                        //ToDo:
                      },
                    ),
                  ),
                  SizedBox(width: KSizes.sm,),
                  CircleAvatar(
                    backgroundColor: KColors.greenSecondary,
                    child: IconButton(
                      icon: Icon(Icons.phone),
                      color: KColors.white,
                      iconSize: KSizes.iconMd,
                      onPressed: () {
                        //ToDo:
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: KSizes.spaceBtwItems,),
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: KColors.fontBlue,
                      borderRadius: BorderRadius.circular(KSizes.borderRadiusSm)
                    ),
                    child: Icon(Icons.location_on, color: KColors.white, size: KSizes.iconSm,),
                  ),
                  SizedBox(width: KSizes.xs,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Pick-up Point",
                        style: TextStyle(
                          color: KColors.black,
                          fontSize: KSizes.fonstSizexSm,
                        ),
                      ),
                      Text("XYZ Home",
                        style: TextStyle(
                          color: KColors.black,
                          fontSize: KSizes.fonstSizeSm,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Text("--"),
                  Container(
                    width: 90,
                    decoration: BoxDecoration(
                      border: Border.all(color: KColors.lighterGrey),
                      borderRadius: BorderRadius.circular(KSizes.borderRadiusLg)
                    ),
                    child: Text("Est. 30 min",
                      style: TextStyle(
                        color: KColors.black,
                        fontSize: KSizes.fonstSizexSm,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text("--"),
                  Spacer(),
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: KColors.greenSecondary,
                      borderRadius: BorderRadius.circular(KSizes.borderRadiusxLg)
                    ),
                    child: Icon(Icons.circle, color: KColors.white, size: KSizes.sm,),
                  ),
                  SizedBox(width: KSizes.xs,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Drop-off Point",
                        style: TextStyle(
                          color: KColors.black,
                          fontSize: KSizes.fonstSizexSm,
                        ),
                      ),
                      Text("XYZ School",
                        style: TextStyle(
                          color: KColors.black,
                          fontSize: KSizes.fonstSizeSm,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: KSizes.spaceBtwItems,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Icon(Icons.bus_alert, size: KSizes.iconMd,),
                  Text("Bus 01",
                    style: TextStyle(
                      color: KColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: KSizes.fonstSizeSm,
                    ),
                  ),
                  Spacer(),
                  Text("Arrival at",
                    style: TextStyle(
                      color: KColors.black,
                      fontSize: KSizes.fonstSizeSm,
                    ),
                  ),
                  Text(" 7:30 ",
                    style: TextStyle(
                      color: KColors.greenSecondary,
                      fontSize: KSizes.fonstSizeSm,
                    ),
                  ),
                  Text("to XYZ School",
                    style: TextStyle(
                      color: KColors.black,
                      fontSize: KSizes.fonstSizeSm,
                    ),
                  ),
                  Spacer()
                ],
              ),
              SizedBox(height: KSizes.spaceBtwItems,),
              ElevatedButton(child: Text("Track The Bus",
                  style: TextStyle(
                    color: KColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: KSizes.fonstSizeSm
                  ),
                ),
                onPressed: () {
                  setState(() {
                    //ToDo:
                  });
                },
              ),
            ],
          ),
        );
  }
}