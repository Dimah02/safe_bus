import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:safe_bus/features/teacher/attendance_overview/data/models/student_model/student_model.dart';
import 'package:safe_bus/features/teacher/attendance_overview/data/repo/student_attendance_repo.dart';

part 'students_attendance_state.dart';

class StudentsAttendanceCubit extends Cubit<StudentsAttendanceState> {
  StudentsAttendanceCubit() : super(StudentsAttendanceInitial());

  Future<void> getStudentsAttendance({required int busRouteId}) async {
    emit(StudentsAttendanceLoading());
    try {
      List<StudentModel> students = await StudentAttendanceRepo.instance
          .getStudents(busRouteId: busRouteId);
      emit(StudentsAttendanceSuccess(students: students));
    } catch (e) {
      emit(StudentsAttendanceFailure(errMessage: e.toString()));
    }
  }
}
