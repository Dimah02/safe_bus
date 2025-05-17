part of 'map_cubit.dart';

@immutable
sealed class MapState {}

final class MapInitial extends MapState {}

final class MapLoading extends MapState {}

final class MapFailure extends MapState {
  final String errorMessage;

  MapFailure({required this.errorMessage});
}

final class MapSuccess extends MapState {}
