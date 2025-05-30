part of 'map_cubit.dart';

@immutable
abstract class MapState {}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapReady extends MapState {}

class MapError extends MapState {
  final String message;
  MapError(this.message);
}
