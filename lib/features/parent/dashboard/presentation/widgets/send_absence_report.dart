import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_bus/core/styles/sizes.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/utils/toast.dart';
import 'package:safe_bus/features/parent/data/manager/absence_cubit.dart';
import 'package:safe_bus/features/parent/data/models/absences_model.dart';
import 'package:safe_bus/features/parent/data/models/students_model.dart';
import 'package:safe_bus/features/parent/dashboard/presentation/parent_home_screen.dart';

class AbsenceReport extends StatefulWidget {
  final Students student;
  final Function(bool) onAbsenceCancelled;

  const AbsenceReport({super.key, required this.student, required this.onAbsenceCancelled});

  @override
  State<AbsenceReport> createState() => _AbsenceReportState();
}

class _AbsenceReportState extends State<AbsenceReport> {
  late final Absences absence;

  @override
  void initState() {
    super.initState();
    absence = _createAbsence();
    _sendAbsence(context);
  }

  Absences _createAbsence() {
    return Absences(
      absenceId: 0,
      studentId: widget.student.studentId,
      date: _calculateAbsenceDate(),
      pickupStatus: false,
      dropoffStatus: false,
      student: widget.student,
    );
  }

  static DateTime _calculateAbsenceDate() {
    final now = DateTime.now();
    return now.isAfter(DateTime(now.year, now.month, now.day, 7, 30))
        ? now.add(const Duration(days: 1))
        : now;
  }

  Future<void> _sendAbsence(BuildContext context) async {
    final updatedAbsence = await context.read<AbsenceCubit>().reportAbsence(absence);
    if (updatedAbsence != null) {
      setState(() {
        absence = updatedAbsence;
      });
    }
  }

  Future<void> _deleteAbsence(BuildContext context) async {
    await context.read<AbsenceCubit>().deleteAbsence(absence.absenceId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AbsenceCubit, AbsenceState>(
      listener: (context, state) {
        if (state is AbsenceSent) {
          Toast(context).showToast(message: "Absence reported successfully");
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
                "${widget.student.studentName} is reported absent today",
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
                  child: Text(
                    "Cancel absence report",
                    style: TextStyle(
                      color: KColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: KSizes.fonstSizeSm,
                    ),
                  ),
                  onPressed: () {
                    _deleteAbsence(context);
                    widget.onAbsenceCancelled(false);
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
                    "Cancellation available until 7:30",
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