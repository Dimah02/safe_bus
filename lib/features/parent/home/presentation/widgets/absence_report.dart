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
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        border: Border.all(color: KColors.lighterGrey),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 60,
            width: 60,
            child: CircleAvatar(
              backgroundColor: KColors.pinkishRed,
              child: Icon(
                Icons.favorite_border,
                color: KColors.fadedRed,
                size: KSizes.iconXlg,
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            "Adam is reported absent today",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: KSizes.fonstSizeLg,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: KSizes.spaceBtwItems),
          Text(
            "We hope Adam is doing fine and will be back soon!",
            style: TextStyle(
              color: KColors.lighterGrey,
              fontSize: KSizes.fonstSizeSm,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: KSizes.spaceBtwSections),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(KColors.fadedRed),
                side: WidgetStatePropertyAll(
                  BorderSide(color: KColors.fadedRed),
                ),
              ),
              child: Text(
                "Cancel absence report",
                style: TextStyle(
                  color: KColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: KSizes.fonstSizeSm,
                ),
              ),
              onPressed: () {
                setState(() {
                  //ToDo:
                });
              },
            ),
          ),
          SizedBox(height: KSizes.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.access_time,
                color: KColors.lighterGrey,
                size: KSizes.iconSm,
              ),
              SizedBox(width: 4),
              Text(
                "Cancellation available for 29:51",
                style: TextStyle(
                  color: KColors.lighterGrey,
                  fontSize: KSizes.fonstSizeSm,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
