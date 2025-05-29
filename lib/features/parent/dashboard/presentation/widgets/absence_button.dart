import 'package:flutter/material.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/styles/sizes.dart';
import 'package:safe_bus/features/parent/data/models/students_model.dart';

class AbsenceButton extends StatelessWidget {
  final Students student;
  final Function(bool) onAbsent;

  const AbsenceButton({super.key, required this.student, required this.onAbsent});

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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  backgroundColor: KColors.blueAccent,
                  side: const BorderSide(color: KColors.blueAccent),
                ),
                child: Text(
                  "Set absent",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: KSizes.fonstSizeSm,
                  ),
                ),
                onPressed: () {
                  onAbsent(true);
                },
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            "Click this if ${student.studentName} will not be attending school today.",
            style: TextStyle(color: KColors.grey, fontSize: KSizes.fonstSizeSm),
          ),
        ],
      ),
    );
  }
}