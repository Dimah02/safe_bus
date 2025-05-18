// lib/services/parent_tracking_service.dart
import 'package:safe_bus/core/services/signal_r_service.dart';

class ParentTrackingService {
  final SignalRService _signalRService;
  final int _busRouteId;
  final Function(Map<String, dynamic>) _onLocationUpdate;

  ParentTrackingService({
    required String baseUrl,
    required String token,
    required int busRouteId,
    required Function(Map<String, dynamic>) onLocationUpdate,
  }) : _signalRService = SignalRService(
         baseUrl: baseUrl,
         hubName: 'busTrackingHub',
       ),
       _busRouteId = busRouteId,
       _onLocationUpdate = onLocationUpdate;

  Future<void> startTracking() async {
    await _signalRService.connect();
    await _signalRService.invoke('RegisterAsParent', [_busRouteId.toString()]);

    _signalRService.on('LocationUpdated', (data) {
      if (data is List && data.isNotEmpty) {
        _onLocationUpdate(data[0]);
      }
    });
  }

  Future<void> stopTracking() async {
    await _signalRService.disconnect();
  }
}
