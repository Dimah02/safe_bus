import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/styles/image_strings.dart';
import 'package:safe_bus/core/utils/toast.dart';
import 'package:safe_bus/features/teacher/Home/data/models/teacher_home/trip.dart';
import 'package:safe_bus/features/teacher/attendance_overview/data/models/student_model/student_model.dart';
import 'package:safe_bus/features/teacher/attendance_overview/presentation/managers/cubit/students_attendance_cubit.dart';
import 'package:safe_bus/features/teacher/attendance_overview/presentation/views/widgets/student_attendance_dialog.dart';

class AttendanceOverviewScreen extends StatefulWidget {
  final Trip trip;
  const AttendanceOverviewScreen({super.key, required this.trip});

  @override
  State<AttendanceOverviewScreen> createState() =>
      _AttendanceOverviewScreenState();
}

class _AttendanceOverviewScreenState extends State<AttendanceOverviewScreen> {
  late List<StudentModel> students;

  @override
  void initState() {
    super.initState();
  }

  void _updateStudentStatus(int index, bool isPresent) {
    setState(() {
      if (isPresent) {
        students[index].activeLocations!.first.rideStatus = 1;
        students[index].activeLocations!.first.statusColor = Colors.green;
      } else {
        students[index].activeLocations!.first.rideStatus = 2;
        students[index].activeLocations!.first.statusColor = Colors.red;
      }
    });
  }

  void _showStudentAttendanceDialog(BuildContext context, int index) {
    final student = students[index];
    StudentAttendanceDialog.show(
      context: context,
      studentName: student.studentName ?? '',
      timeRecorded: "",
      location: student.activeLocations?.first.description ?? ' ',
      recordedBy: "",
      remarks: "",
      onStatusChanged: (isPresent) {
        _updateStudentStatus(index, isPresent);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              StudentsAttendanceCubit()
                ..getStudentsAttendance(busRouteId: widget.trip.busRouteId!),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Attendance Overview'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: BlocConsumer<StudentsAttendanceCubit, StudentsAttendanceState>(
          listener: (context, state) {
            if (state is StudentsAttendanceSuccess) {
              students = state.students;
            }
            if (state is StudentsAttendanceFailure) {
              Toast(
                context,
              ).showToast(message: state.errMessage, color: KColors.fadedRed);
            }
          },
          builder: (context, state) {
            if (state is StudentsAttendanceLoading) {
              return Center(
                child: CircularProgressIndicator(color: KColors.greenPrimary),
              );
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    widget.trip.getFormattedDate2(),
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              'Total Students',
                              '${BlocProvider.of<StudentsAttendanceCubit>(context).totalStudents}',
                              Colors.blue.shade200,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              'Total Present',
                              '${BlocProvider.of<StudentsAttendanceCubit>(context).totalPresent}',
                              Colors.green.shade200,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              'Total Absent',
                              '${BlocProvider.of<StudentsAttendanceCubit>(context).totalAbsent}',
                              Colors.red.shade200,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              'Not Marked',
                              '${BlocProvider.of<StudentsAttendanceCubit>(context).notMarked}',
                              Colors.grey.shade200,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Mark Individually ${BlocProvider.of<StudentsAttendanceCubit>(context).markedIndividually}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16,
                    top: 8.0,
                    bottom: 16,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final student = students[index];
                      return InkWell(
                        onTap:
                            () => _showStudentAttendanceDialog(context, index),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            child:
                                student.image != null
                                    ? Image.asset(
                                      /*st.image??*/ KImage.child,
                                      width: 40,
                                      height: 40,
                                    )
                                    : Icon(
                                      Icons.person,
                                      color: Colors.grey[400],
                                    ),
                          ),
                          title: Text(student.studentName ?? ''),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildAttendanceButton(
                                'P',
                                student.activeLocations?.first.isPresent() ??
                                        false
                                    ? Colors.green
                                    : Colors.grey.shade300,
                                student.activeLocations?.first.isPresent() ??
                                        false
                                    ? Colors.white
                                    : Colors.grey,
                                () => _updateStudentStatus(index, true),
                              ),
                              const SizedBox(width: 8),
                              _buildAttendanceButton(
                                'A',
                                student.activeLocations?.first.isAbsent() ??
                                        false
                                    ? Colors.red
                                    : Colors.grey.shade300,
                                student.activeLocations?.first.isAbsent() ??
                                        false
                                    ? Colors.white
                                    : Colors.grey,
                                () => _updateStudentStatus(index, false),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            count,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceButton(
    String text,
    Color backgroundColor,
    Color textColor,
    VoidCallback onPressed,
  ) {
    return InkWell(
      onTap: onPressed,
      child: CircleAvatar(
        radius: 15,
        backgroundColor: backgroundColor,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
