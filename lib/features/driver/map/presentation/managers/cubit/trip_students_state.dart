part of 'trip_students_cubit.dart';

@immutable
sealed class TripStudentsState {}

final class TripStudentsInitial extends TripStudentsState {}

final class TripStudentsLoading extends TripStudentsState {}

final class TripStudentsFailure extends TripStudentsState {
  final String errMessage;

  TripStudentsFailure({required this.errMessage});
}

final class TripStudentsSuccess extends TripStudentsState {}
