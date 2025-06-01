part of 'real_time_location_cubit.dart';

@immutable
sealed class RealTimeLocationState {}

final class RealTimeLocationInitial extends RealTimeLocationState {}

final class RealTimeLocationFailure extends RealTimeLocationState {
  final String errorMessage;

  RealTimeLocationFailure({required this.errorMessage});
}
