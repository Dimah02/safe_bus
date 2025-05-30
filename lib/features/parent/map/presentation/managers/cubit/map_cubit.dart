import 'dart:math';

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
    updateCameraOnce: 0,
  );
  final int busRouteId;
  final SignalRService signalRService;
  late GoogleMapController googleMapController;
  static LatLng? currentLocation;
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
      print(e.toString());
      emit(
        MapFailure(errorMessage: 'Failed to connect to real-time service: $e'),
      );
      // Implement retry logic here if needed
    }
  }

  void _handleLocationUpdate(dynamic data) {
    if (data != null && data.isNotEmpty) {
      //{busRouteId: 1, latitude: 31.993227496908702, longitude: 35.93561771597489, speed: 15, bearing: 0, timestamp: 2023-11-15T14:30:45.123456}
      final lat = data['latitude'] as double;
      final lng = data['longitude'] as double;
      final bearing = data['bearing'].toDouble() ?? 0;

      // Update bus marker
      _updateBusMarker(lat, lng, bearing);

      // Move camera to follow bus (optional)
      if (currentLocation != null) {
        googleMapController.animateCamera(
          //CameraUpdate.newLatLng(LatLng(lat, lng)),
          CameraUpdate.newLatLngBounds(
            LatLngBounds(
              southwest: LatLng(
                min(lat, currentLocation!.latitude),
                min(lng, currentLocation!.longitude),
              ),
              northeast: LatLng(
                max(lat, currentLocation!.latitude),
                max(lng, currentLocation!.longitude),
              ),
            ),

            36,
          ),
        );
      }

      emit(MapSuccess()); // Rebuild UI with new marker
    }
  }

  void showMyLocation() {
    CameraPosition cameraPosition = CameraPosition(
      target: currentLocation!,
      zoom: 16,
    );
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
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
        onUpdateCurrentLocation: (location) {
          currentLocation = location;
        },
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
