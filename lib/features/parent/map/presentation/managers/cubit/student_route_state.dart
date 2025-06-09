part of 'student_route_cubit.dart';

@immutable
sealed class StudentRouteState {}

final class StudentRouteInitial extends StudentRouteState {}

final class StudentRouteLoading extends StudentRouteState {}

final class StudentRouteFailure extends StudentRouteState {
  final String errorMessage;

  StudentRouteFailure({required this.errorMessage});
}

final class StudentRouteSuccess extends StudentRouteState {}
