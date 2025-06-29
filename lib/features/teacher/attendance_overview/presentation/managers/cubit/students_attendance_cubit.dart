import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:safe_bus/features/teacher/attendance_overview/data/models/student_model/student_model.dart';
import 'package:safe_bus/features/teacher/attendance_overview/data/repo/student_attendance_repo.dart';

part 'students_attendance_state.dart';

class StudentsAttendanceCubit extends Cubit<StudentsAttendanceState> {
  StudentsAttendanceCubit() : super(StudentsAttendanceInitial());
  int totalStudents = 0;
  int totalPresent = 0;
  int totalAbsent = 0;
  int notMarked = 0;
  int markedIndividually = 0;
  List<StudentModel> allstudents = [];

  Future<void> getStudentsAttendance({required int busRouteId}) async {
    emit(StudentsAttendanceLoading());
    try {
      List<StudentModel> students = await StudentAttendanceRepo.instance
          .getStudents(busRouteId: busRouteId);
      totalStudents = students.length;
      totalPresent = totalAbsent = notMarked = markedIndividually = 0;
      for (var student in students) {
        if (student.isPresent()) {
          totalPresent++;
        } else if (student.isPending()) {
          notMarked++;
        } else {
          totalAbsent++;
        }
      }
      allstudents = students;
      emit(StudentsAttendanceSuccess(students: students));
    } catch (e) {
      emit(StudentsAttendanceFailure(errMessage: e.toString()));
    }
  }

  Future<void> updateStudentStatus({
    required int ridId,
    required int status,
  }) async {
    emit(StudentsAttendanceLoading());
    try {
      await StudentAttendanceRepo.instance.updateStudentStatus(
        ridId: ridId,
        status: status,
      );
      emit(StudentUpdateStatusSuccess());
    } catch (e) {
      emit(StudentsAttendanceFailure(errMessage: e.toString()));
    }
  }
}
