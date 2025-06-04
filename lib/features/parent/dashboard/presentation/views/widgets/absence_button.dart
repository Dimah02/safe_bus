import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/styles/sizes.dart';
import 'package:safe_bus/features/parent/dashboard/presentation/manager/parent_home_cubit.dart';

class AbsenceButton extends StatelessWidget {
  const AbsenceButton({super.key});

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
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
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
                onPressed: () async {
                  await BlocProvider.of<ParentHomeCubit>(
                    context,
                  ).updateStudentStatus(status: 2);
                },
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            "Click this if ${BlocProvider.of<ParentHomeCubit>(context).student?.studentName ?? ''} will not be attending school today.",
            style: TextStyle(color: KColors.grey, fontSize: KSizes.fonstSizeSm),
          ),
        ],
      ),
    );
  }
}
