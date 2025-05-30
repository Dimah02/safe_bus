import 'package:flutter/material.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/styles/sizes.dart';

class AbsenceSwitch extends StatefulWidget {
  final ValueChanged<bool> onChanged;

  const AbsenceSwitch({super.key, required this.onChanged});

  @override
  State<AbsenceSwitch> createState() => _AbsenceSwitch();
}

class _AbsenceSwitch extends State<AbsenceSwitch> {
  bool isAbsent = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: KColors.lighterGrey),
        borderRadius: BorderRadius.all(Radius.circular(KSizes.buttonRadius)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Report Absence",
                style: TextStyle(
                  fontWeight: FontWeight.w700,

                  fontSize: KSizes.fontSizeMd,
                ),
              ),
              SizedBox(
                height: 24,
                child: Switch(
                  padding: EdgeInsets.all(0),
                  value: isAbsent,
                  activeColor: KColors.white,
                  activeTrackColor: KColors.blueAccent,
                  inactiveTrackColor: KColors.lighterGrey,
                  overlayColor: WidgetStatePropertyAll(KColors.lighterGrey),
                  trackOutlineColor: WidgetStatePropertyAll(
                    KColors.lighterGrey,
                  ),
                  onChanged: (value) {
                    setState(() {
                      isAbsent = value;
                    });
                    widget.onChanged(value);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            "Toggle if Adam will not be attending school today.",
            style: TextStyle(color: KColors.grey, fontSize: KSizes.fonstSizeSm),
          ),
        ],
      ),
    );
  }
}
