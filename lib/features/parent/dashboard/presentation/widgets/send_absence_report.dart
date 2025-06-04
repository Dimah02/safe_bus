import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_bus/core/styles/sizes.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/utils/toast.dart';
import 'package:safe_bus/features/parent/data/manager/absence_cubit.dart';
import 'package:safe_bus/features/parent/data/models/absences_model.dart';
import 'package:safe_bus/features/parent/data/models/students_model.dart';

class AbsenceReport extends StatefulWidget {
  final Students student;
  final Function(bool) onAbsent;

  const AbsenceReport({super.key, required this.student, required this.onAbsent});

  @override
  State<AbsenceReport> createState() => _AbsenceReportState();
}

class _AbsenceReportState extends State<AbsenceReport> {
  Absences? absence;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sendAbsence(context);
    });
  }

  Future<void> _sendAbsence(BuildContext context) async {
    final updatedAbsence = await context.read<AbsenceCubit>().reportAbsence(widget.student.studentId);
    try{
      if (updatedAbsence != null) {
        setState(() {
          absence = updatedAbsence;
        });
      } else {
        Toast(context).showToast(message: "Absence reported.");
      }
    } catch (e) {
    Toast(context).showToast(message: "Error: $e", color: KColors.fadedRed);
  }
  }

  Future<void> _deleteAbsence(BuildContext context) async {
    await context.read<AbsenceCubit>().deleteAbsence(absence!.absenceId);
    widget.onAbsent(false);
  }

  @override
  Widget build(BuildContext context) {
    if (absence == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onAbsent(true);
      });
      return const Center(child: CircularProgressIndicator());
    }
    return BlocConsumer<AbsenceCubit, AbsenceState>(
      listener: (context, state) {
        if (state is AbsenceSent) {
          Toast(context).showToast(message: "Absence reported successfully for ${absence!.date}");
        } else if (state is AbsenceDeleted) {
          Toast(context).showToast(message: "Absence report deleted");
          
        } else if (state is AbsenceError) {
          Toast(context).showToast(message: "Error: ${state.message}", color: KColors.fadedRed);
        }
      },
      builder: (context, state) {
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
                "${widget.student.studentName} is reported absent on ${absence!.date}",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: KSizes.fonstSizeLg,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: KSizes.spaceBtwItems),
              Text(
                "We hope ${widget.student.studentName} is doing fine and will be back soon!",
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
                  onPressed: () {
                    _deleteAbsence(context);
                    widget.onAbsent(false);
                  }
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
                    "Cancellation available until 7:00",
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
      },
    );
  }
}