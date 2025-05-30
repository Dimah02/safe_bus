part of 'location_cubit.dart';

@immutable
sealed class LocationState {}

final class LocationInitial extends LocationState {}

class LocationConnected extends LocationState {}

class LocationUpdated extends LocationState {
  final Position position;
  LocationUpdated(this.position);
}

class LocationError extends LocationState {
  final String message;
  LocationError(this.message);
}
