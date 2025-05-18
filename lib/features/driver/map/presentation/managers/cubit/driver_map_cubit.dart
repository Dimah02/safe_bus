import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:safe_bus/core/services/location_service.dart';
import 'package:safe_bus/core/services/map_services.dart';
import 'package:safe_bus/core/services/routes_service.dart';
import 'package:safe_bus/core/services/signal_r_service.dart';

part 'driver_map_state.dart';

class DriverMapCubit extends Cubit<DriverMapState> {
  DriverMapCubit({required this.busRouteId, required this.signalRService})
    : super(DriverMapInitial());
  MapServices mapServices = MapServices(
    locationService: LocationService(),
    routesService: RoutesService(),
  );
  late GoogleMapController googleMapController;
  final int busRouteId;
  final SignalRService signalRService;
  LatLng? currentLocation;

  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(0, 0),
    zoom: 0,
  );
  LatLng currentDestination = LatLng(31.986629415135333, 35.949454055114884);
  Timer? _locationUpdateTimer;
  Position? _lastSentPosition;

  void onMapCreated(GoogleMapController controller) async {
    emit(DriverMapLoading());
    try {
      googleMapController = controller;
      await _initializeSignalR();
      await updateCurrentLocation();

      emit(DriverMapSuccess());
    } catch (e) {
      emit(DriverMapFailure(e.toString()));
    }
  }

  Future<void> _initializeSignalR() async {
    try {
      // Connect to SignalR
      await signalRService.connect();

      // Register as driver for this bus route
      await signalRService.invoke('RegisterAsDriver', [busRouteId.toString()]);

      // Start periodic location updates
      _startLocationUpdates();
    } catch (e) {
      emit(DriverMapFailure('Failed to connect to real-time service: $e'));
      // Implement retry logic here if needed
    }
  }

  void _startLocationUpdates() {
    // Stop any existing timer
    _locationUpdateTimer?.cancel();

    // Send updates every 5 seconds
    _locationUpdateTimer = Timer.periodic(Duration(seconds: 5), (timer) async {
      await _sendCurrentLocation();
    });
  }

  Future<void> _sendCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition();

      // Only send if position changed significantly (20 meters)
      if (_lastSentPosition == null ||
          _distanceBetween(_lastSentPosition!, position) > 20) {
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

        _lastSentPosition = position;
      }
    } catch (e) {
      print('Failed to send location update: $e');
      // Implement retry logic or error handling
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
    // Clean up resources
    _locationUpdateTimer?.cancel();
    signalRService.disconnect();
    return super.close();
  }

  Future<void> displayRoute() async {
    emit(DriverMapRouteLoading());
    try {
      List<LatLng> waypoints = [];
      waypoints.add(LatLng(31.987850868590268, 35.94694823912341));
      waypoints.add(LatLng(31.988279377767896, 35.945522788491516));
      waypoints.add(LatLng(31.98695558402733, 35.94400711946519));
      waypoints.add(LatLng(31.986274549735082, 35.94539648273253));
      waypoints.add(LatLng(31.984078370999274, 35.944963434365185));
      waypoints.add(LatLng(31.985057857904316, 35.948869890889995));

      await mapServices
          .getRouteData(
            currentDestination: currentDestination,
            waypoints: waypoints,
          )
          .then((value) {
            mapServices.displayMarkers(
              currentDestination: currentDestination,
              waypoints: waypoints,
              markers: markers,
            );
            return mapServices.displayRoute(
              points: value,
              polylines: polylines,
              googleMapController: googleMapController,
            );
          });
      emit(DriverMapRouteSuccess());
    } catch (e) {
      emit(DriverMapRouteFailure(e.toString()));
    }
  }

  Future<void> updateCurrentLocation() async {
    try {
      await mapServices.updateCurrentLocation(
        googleMapController: googleMapController,
        onUpdateCurrentLocation: (location) {
          displayRoute();
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
