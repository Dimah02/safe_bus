part of 'driver_home_cubit.dart';

@immutable
sealed class DriverHomeState {}

final class DriverHomeInitial extends DriverHomeState {}

final class DriverHomeLoading extends DriverHomeState {}

final class DriverHomeFailure extends DriverHomeState {
  final String errMessage;

  DriverHomeFailure({required this.errMessage});
}

final class DriverHomeSuccess extends DriverHomeState {
  final DriverHome home;

  DriverHomeSuccess({required this.home});
}
