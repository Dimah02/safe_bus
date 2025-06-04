import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_bus/core/styles/sizes.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/features/parent/dashboard/presentation/manager/parent_home_cubit.dart';

class AbsenceReport extends StatelessWidget {
  const AbsenceReport({super.key});

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
            "${BlocProvider.of<ParentHomeCubit>(context).student?.studentName ?? ''} is reported absent on ${BlocProvider.of<ParentHomeCubit>(context).student?.rides?.first.studentRoute?.getFormattedDate() ?? ''}",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: KSizes.fonstSizeLg,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: KSizes.spaceBtwItems),
          Text(
            "We hope  is doing fine and will be back soon!",
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
              style: ElevatedButton.styleFrom(
                backgroundColor: KColors.fadedRed,
                foregroundColor: KColors.white,
                side: const BorderSide(color: KColors.fadedRed),
              ),
              child: const Text(
                "Cancel absence report",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: KSizes.fonstSizeSm,
                ),
              ),
              onPressed: () async {
                await BlocProvider.of<ParentHomeCubit>(
                  context,
                ).updateStudentStatus(status: 0);
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
                "Cancellation available before ${BlocProvider.of<ParentHomeCubit>(context).student?.rides?.first.studentRoute?.getFormattedStartTime()}",
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
