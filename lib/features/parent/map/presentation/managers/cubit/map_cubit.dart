import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:safe_bus/core/services/location_service.dart';
import 'package:safe_bus/core/services/map_services.dart';
import 'package:safe_bus/core/services/routes_service.dart';
import 'package:safe_bus/core/services/signal_r_service.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit(this.busRouteId, this.signalRService) : super(MapInitial());
  MapServices mapServices = MapServices(
    locationService: LocationService(),
    routesService: RoutesService(),
  );
  final int busRouteId;
  final SignalRService signalRService;
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(0, 0),
    zoom: 0,
  );

  Marker? _busMarker;
  LatLng currentDestination = LatLng(31.986629415135333, 35.949454055114884);

  void onMapCreated(GoogleMapController controller) async {
    emit(MapLoading());
    try {
      googleMapController = controller;
      await _initializeSignalR();
      await updateCurrentLocation();

      emit(MapSuccess());
    } catch (e) {
      emit(MapFailure(errorMessage: e.toString()));
    }
  }

  Future<void> _initializeSignalR() async {
    try {
      // Start SignalR connection
      await signalRService.connect();

      // Register parent for specific bus route
      await signalRService.invoke('RegisterAsParent', [busRouteId.toString()]);

      // Listen for location updates
      signalRService.on('LocationUpdated', _handleLocationUpdate);
    } catch (e) {
      emit(
        MapFailure(errorMessage: 'Failed to connect to real-time service: $e'),
      );
      // Implement retry logic here if needed
    }
  }

  void _handleLocationUpdate(dynamic data) {
    if (data is List && data.isNotEmpty) {
      final location = data[0] as Map<String, dynamic>;
      final lat = location['latitude'] as double;
      final lng = location['longitude'] as double;
      final bearing = location['bearing'] as double? ?? 0;

      // Update bus marker
      _updateBusMarker(lat, lng, bearing);

      // Move camera to follow bus (optional)
      googleMapController.animateCamera(
        CameraUpdate.newLatLng(LatLng(lat, lng)),
      );

      emit(MapSuccess()); // Rebuild UI with new marker
    }
  }

  void _updateBusMarker(double lat, double lng, double bearing) {
    final busMarkerId = MarkerId('bus_location');

    _busMarker = Marker(
      markerId: busMarkerId,
      position: LatLng(lat, lng),
      rotation: bearing,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: const InfoWindow(title: 'School Bus'),
    );

    markers = {...markers.where((m) => m.markerId != busMarkerId), _busMarker!};
  }

  @override
  Future<void> close() {
    // Clean up SignalR connection when cubit is closed
    signalRService.disconnect();
    return super.close();
  }

  Future<void> updateCurrentLocation() async {
    try {
      await mapServices.updateCurrentLocation(
        googleMapController: googleMapController,
        onUpdateCurrentLocation: () {},
      );
    } on LocationServiceException {
      // TODO
    } on LocationPermissionException {
      //TODO
    } catch (e) {
      //TODO
    }
  }
}
