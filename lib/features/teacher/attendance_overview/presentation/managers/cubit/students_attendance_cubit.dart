import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:safe_bus/features/teacher/attendance_overview/data/models/student_model/student_model.dart';

part 'students_attendance_state.dart';

class StudentsAttendanceCubit extends Cubit<StudentsAttendanceState> {
  StudentsAttendanceCubit() : super(StudentsAttendanceInitial());
}
