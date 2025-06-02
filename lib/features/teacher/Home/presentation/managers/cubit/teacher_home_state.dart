part of 'teacher_home_cubit.dart';

@immutable
sealed class TeacherHomeState {}

final class TeacherHomeInitial extends TeacherHomeState {}

final class TeacherHomeLoading extends TeacherHomeState {}

final class TeacherHomeFailure extends TeacherHomeState {
  final String errMessage;

  TeacherHomeFailure({required this.errMessage});
}

final class TeacherHomeSuccess extends TeacherHomeState {
  final TeacherHome home;

  TeacherHomeSuccess({required this.home});
}
