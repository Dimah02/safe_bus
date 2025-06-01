part of 'driver_map_cubit.dart';

@immutable
sealed class DriverMapState {}

final class DriverMapInitial extends DriverMapState {}

final class DriverMapLoading extends DriverMapState {}

final class DriverMapFailure extends DriverMapState {
  final String errMessage;

  DriverMapFailure(this.errMessage);
}

final class DriverMapSuccess extends DriverMapState {}

final class DriverMapRouteLoading extends DriverMapState {}

final class DriverMapRouteFailure extends DriverMapState {
  final String errMessage;

  DriverMapRouteFailure(this.errMessage);
}

final class DriverMapRouteSuccess extends DriverMapState {}

final class UpdatingRouteSuccess extends DriverMapState {}

final class CalculationSuccess extends DriverMapState {}
