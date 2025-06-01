import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:safe_bus/core/services/signal_r_service.dart';

part 'real_time_location_state.dart';

class RealTimeLocationCubit extends Cubit<RealTimeLocationState> {
  RealTimeLocationCubit(this.busRouteId) : super(RealTimeLocationInitial()) {
    String baseurl = dotenv.env["SOCKETURL"] ?? '';
    signalRService = SignalRService(
      baseUrl: baseurl,
      hubName: 'busTrackingHub',
    );
    _initializeSignalR();
  }

  final int busRouteId;
  SignalRService? signalRService;
  Timer? _locationUpdateTimer;
  Position? _lastSentPosition;

  Future<void> _initializeSignalR() async {
    try {
      await signalRService?.connect();

      await signalRService?.invoke('RegisterAsDriver', [busRouteId.toString()]);

      _startLocationUpdates();
    } catch (e) {
      emit(
        RealTimeLocationFailure(
          errorMessage: 'Failed to connect to real-time service: $e',
        ),
      );
    }
  }

  void _startLocationUpdates() {
    _locationUpdateTimer?.cancel();

    _locationUpdateTimer = Timer.periodic(Duration(seconds: 5), (timer) async {
      await _sendCurrentLocation();
    });
  }

  Future<void> _sendCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition();

      if (_lastSentPosition == null ||
          _distanceBetween(_lastSentPosition!, position) > 20) {
        await signalRService?.invoke('UpdateLocation', [
          {
            'busRouteId': busRouteId,
            'latitude': position.latitude,
            'longitude': position.longitude,
            'speed': position.speed,
            'bearing': position.heading,
            'timestamp': DateTime.now().toIso8601String(),
          },
        ]);

        _lastSentPosition = position;
      }
    } catch (e) {
      print('Failed to send location update: $e');
    }
  }

  double _distanceBetween(Position a, Position b) {
    return Geolocator.distanceBetween(
      a.latitude,
      a.longitude,
      b.latitude,
      b.longitude,
    );
  }

  @override
  Future<void> close() {
    print("LocationCubit is closing...");
    _locationUpdateTimer?.cancel();
    signalRService?.disconnect();
    return super.close();
  }
}
