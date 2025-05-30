import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:safe_bus/core/services/signal_r_service.dart';
import 'dart:async'; // This is where StreamSubscription is defined
part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit({required this.busRouteId, required this.signalRService})
    : super(LocationInitial()) {
    _init();
  }

  final int busRouteId;
  final SignalRService signalRService;
  StreamSubscription<Position>? _positionSubscription;
  Position? _lastPosition;

  Future<void> _init() async {
    try {
      await signalRService.connect();
      await signalRService.invoke('RegisterAsDriver', [busRouteId.toString()]);

      _positionSubscription = Geolocator.getPositionStream().listen((position) {
        _handleNewPosition(position);
      });

      emit(LocationConnected());
    } catch (e) {
      emit(LocationError('Connection failed: $e'));
    }
  }

  Future<void> _handleNewPosition(Position position) async {
    try {
      if (_lastPosition == null ||
          Geolocator.distanceBetween(
                _lastPosition!.latitude,
                _lastPosition!.longitude,
                position.latitude,
                position.longitude,
              ) >
              20) {
        await signalRService.invoke('UpdateLocation', [
          {
            'busRouteId': busRouteId,
            'latitude': position.latitude,
            'longitude': position.longitude,
            'speed': position.speed,
            'bearing': position.heading,
            'timestamp': DateTime.now().toIso8601String(),
          },
        ]);

        _lastPosition = position;
        emit(LocationUpdated(position));
      }
    } catch (e) {
      emit(LocationError('Update failed: $e'));
    }
  }

  @override
  Future<void> close() {
    _positionSubscription?.cancel();
    signalRService.disconnect();
    return super.close();
  }
}
