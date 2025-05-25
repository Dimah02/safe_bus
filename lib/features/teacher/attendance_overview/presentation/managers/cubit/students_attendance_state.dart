part of 'students_attendance_cubit.dart';

@immutable
sealed class StudentsAttendanceState {}

final class StudentsAttendanceInitial extends StudentsAttendanceState {}

final class StudentsAttendanceLoading extends StudentsAttendanceState {}

final class StudentsAttendanceFailure extends StudentsAttendanceState {
  final String errMessage;

  StudentsAttendanceFailure({required this.errMessage});
}

final class StudentsAttendanceSuccess extends StudentsAttendanceState {
  final List<StudentModel> students;

  StudentsAttendanceSuccess({required this.students});
}
