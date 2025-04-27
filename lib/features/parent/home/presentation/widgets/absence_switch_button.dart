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
      padding: EdgeInsets.fromLTRB(KSizes.sm, 0, KSizes.sm, KSizes.xs),
      decoration: BoxDecoration(
        border: Border.all(color: KColors.lighterGrey),
        borderRadius: BorderRadius.all(Radius.circular(KSizes.buttonRadius)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text("Report Absence",
                style: TextStyle(
                  color: KColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: KSizes.fontSizeMd,
                ),
              ),
              Spacer(),
              Switch(
                value: isAbsent,
                activeColor: KColors.white,
                activeTrackColor: KColors.blueAccent,
                inactiveThumbColor: KColors.white,
                inactiveTrackColor: KColors.lighterGrey,
                trackOutlineColor: WidgetStatePropertyAll(KColors.lighterGrey),
                onChanged: (value) {
                  setState(() {
                    isAbsent = value;
                  });
                  widget.onChanged(value);
                },
              )
            ],
          ),
          Text("Toggle if Adam will not be attending school today.",
            style: TextStyle(
              color: KColors.lighterGrey,
              fontSize: KSizes.fonstSizeSm,
            ),
          )
        ],
      ),
    );
  }
}