import 'package:flutter/material.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/styles/sizes.dart';

class AbsenceReport extends StatefulWidget {
  const AbsenceReport({super.key});

  @override
  State<AbsenceReport> createState() => _AbsenceReportState();
}

class _AbsenceReportState extends State<AbsenceReport> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, 0),
      padding: EdgeInsets.fromLTRB(KSizes.sm, KSizes.xs, KSizes.sm, KSizes.xs),
      decoration: BoxDecoration(
        border: Border.all(color: KColors.lighterGrey),
        borderRadius: BorderRadius.all(Radius.circular(KSizes.buttonRadius)),
      ),
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            margin: EdgeInsets.fromLTRB(0, KSizes.md, 0, KSizes.lg),
            child: CircleAvatar(
              backgroundColor: KColors.pinkishRed,
              child: Icon(Icons.favorite_border, color: KColors.fadedRed, size: KSizes.iconXlg,),
            ),
          ),
          Text("Adam is reported absent today",
            style: TextStyle(
              color: KColors.black,
              fontWeight: FontWeight.bold,
              fontSize: KSizes.fonstSizeLg,
            ),
          ),
          SizedBox(height: KSizes.spaceBtwItems),
          Text("We hope Adam is doing fine and will be back soon!",
            style: TextStyle(
              color: KColors.lighterGrey,
              fontSize: KSizes.fonstSizeSm,
            ),
          ),
          SizedBox(height: KSizes.spaceBtwSections),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(KColors.fadedRed),
              side: WidgetStatePropertyAll(BorderSide(color: KColors.fadedRed))
            ),
            child: Text("Cancel absence report",
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
          SizedBox(height: KSizes.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.access_time, color: KColors.lighterGrey, size: KSizes.iconSm),
              Text("Cancellation available for 29:51",
                style: TextStyle(
                  color: KColors.lighterGrey,
                  fontSize: KSizes.fonstSizeSm
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}