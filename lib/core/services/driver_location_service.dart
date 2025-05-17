import 'package:geolocator/geolocator.dart';
import 'package:safe_bus/core/services/signal_r_service.dart';

class DriverLocationService {
  final SignalRService _signalRService;
  final int _busRouteId;
  bool _isTracking = false;
  Position? _lastPosition;

  DriverLocationService({
    required String baseUrl,
    required String token,
    required int busRouteId,
  }) : _signalRService = SignalRService(
         baseUrl: baseUrl,
         hubName: 'busTrackingHub',
         token: token,
       ),
       _busRouteId = busRouteId;

  Future<void> startTracking() async {
    await _signalRService.connect();
    await _signalRService.invoke('RegisterAsDriver', [_busRouteId.toString()]);

    _isTracking = true;
    _sendLocationUpdates();
  }

  Future<void> stopTracking() async {
    _isTracking = false;
    await _signalRService.disconnect();
  }

  Future<void> _sendLocationUpdates() async {
    while (_isTracking) {
      final position = await Geolocator.getCurrentPosition();

      // Only send if position changed significantly (20 meters)
      if (_lastPosition == null ||
          Geolocator.distanceBetween(
                _lastPosition!.latitude,
                _lastPosition!.longitude,
                position.latitude,
                position.longitude,
              ) >
              20) {
        await _signalRService.invoke('UpdateLocation', [
          {
            'busRouteId': _busRouteId,
            'latitude': position.latitude,
            'longitude': position.longitude,
            'speed': position.speed,
            'bearing': position.heading,
            'timestamp': DateTime.now().toIso8601String(),
          },
        ]);
        _lastPosition = position;
      }

      await Future.delayed(const Duration(seconds: 5));
    }
  }
}
