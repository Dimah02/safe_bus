import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:safe_bus/core/services/location_service.dart';
import 'package:safe_bus/core/services/map_services.dart';
import 'package:safe_bus/core/services/routes_service.dart';
import 'package:safe_bus/core/services/signal_r_service.dart';
import 'package:safe_bus/core/styles/image_strings.dart';
import 'package:safe_bus/features/parent/dashboard/data/models/studentandbusroute.dart';
import 'package:safe_bus/features/parent/map/data/models/student_route/ride.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit(this.studentandbusroute) : super(MapInitial()) {
    String baseurl = dotenv.env["SOCKETURL"] ?? '';
    signalRService = SignalRService(
      baseUrl: baseurl,
      hubName: 'busTrackingHub',
    );
  }
  MapServices mapServices = MapServices(
    locationService: LocationService(),
    routesService: RoutesService(),
    updateCameraOnce: 0,
  );
  final Studentandbusroute studentandbusroute;
  SignalRService? signalRService;
  late GoogleMapController googleMapController;
  static LatLng? currentLocation, busLocation;
  Set<Marker> markers = {};
  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(0, 0),
    zoom: 0,
  );

  Marker? _busMarker;
  LatLng currentSource = LatLng(31.986629415135333, 35.949454055114884);
  LatLng currentDestination = LatLng(31.986629415135333, 35.949454055114884);

  void onMapCreated(GoogleMapController controller, Ride ride) async {
    emit(MapLoading());
    try {
      googleMapController = controller;
      if (studentandbusroute.isMorning) {
        currentSource = LatLng(
          ride.pickupLocation?.latitude ?? 31.986629415135333,
          ride.pickupLocation?.longitude ?? 35.949454055114884,
        );
        currentDestination = LatLng(
          ride.schoolLatitude ?? 32.04846862285567,
          ride.schoolLongitude ?? 35.896327963398846,
        );
      } else {
        currentDestination = LatLng(
          ride.dropoffLocation?.latitude ?? 31.986629415135333,
          ride.dropoffLocation?.longitude ?? 35.949454055114884,
        );
        currentSource = LatLng(
          ride.schoolLatitude ?? 32.04846862285567,
          ride.schoolLongitude ?? 35.896327963398846,
        );
      }
      BitmapDescriptor schoolIcon, locationIcon;
      schoolIcon = await BitmapDescriptor.asset(
        ImageConfiguration(),
        KImage.buildingpng35,
      );
      locationIcon = await BitmapDescriptor.asset(
        ImageConfiguration(),
        KImage.locationpng35,
      );
      markers.add(
        Marker(
          markerId: MarkerId("Source"),
          position: currentSource,
          icon: studentandbusroute.isMorning ? locationIcon : schoolIcon,
          infoWindow: InfoWindow(
            title: studentandbusroute.isMorning ? "Home" : "School",
          ),
        ),
      );
      markers.add(
        Marker(
          markerId: MarkerId("Destination"),
          position: currentDestination,
          icon: studentandbusroute.isMorning ? schoolIcon : locationIcon,
          infoWindow: InfoWindow(
            title: studentandbusroute.isMorning ? "School" : "Home",
          ),
        ),
      );

      await _initializeSignalR();
      await updateCurrentLocation();

      emit(MapSuccess());
    } catch (e) {
      emit(MapFailure(errorMessage: e.toString()));
    }
  }

  Future<void> _initializeSignalR() async {
    try {
      await signalRService?.connect();

      await signalRService?.invoke('RegisterAsParent', [
        studentandbusroute.studnetroute.busRouteId.toString(),
      ]);

      signalRService?.on('LocationUpdated', _handleLocationUpdate);
    } catch (e) {
      emit(
        MapFailure(errorMessage: 'Failed to connect to real-time service: $e'),
      );
    }
  }

  void _handleLocationUpdate(dynamic data) {
    if (data != null && data.isNotEmpty) {
      //{busRouteId: 1, latitude: 31.993227496908702, longitude: 35.93561771597489, speed: 15, bearing: 0, timestamp: 2023-11-15T14:30:45.123456}
      final lat = data['latitude'].toDouble() as double;
      final lng = data['longitude'].toDouble() as double;
      final bearing = data['bearing'].toDouble() ?? 0;
      busLocation = LatLng(lat, lng);
      _updateBusMarker(lat, lng, bearing);
      if (currentLocation != null) {
        googleMapController.animateCamera(
          CameraUpdate.newLatLngBounds(
            LatLngBounds(
              southwest: LatLng(
                min(
                  min(currentDestination.latitude, currentSource.latitude),
                  min(lat, currentLocation?.latitude ?? 10000),
                ),
                min(
                  min(currentDestination.longitude, currentSource.longitude),
                  min(lng, currentLocation?.longitude ?? 10000),
                ),
              ),
              northeast: LatLng(
                max(
                  max(currentDestination.latitude, currentSource.latitude),
                  max(lat, currentLocation?.latitude ?? -10000),
                ),
                max(
                  max(currentDestination.longitude, currentSource.longitude),
                  max(lng, currentLocation?.longitude ?? -10000),
                ),
              ),
            ),

            36,
          ),
        );
      }

      emit(LocationsSuccess());
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

  void _updateBusMarker(double lat, double lng, double bearing) async {
    final busMarkerId = MarkerId('bus_location');

    BitmapDescriptor busIcon;
    busIcon = await BitmapDescriptor.asset(
      ImageConfiguration(),
      KImage.buspng35,
    );

    _busMarker = Marker(
      markerId: busMarkerId,
      position: LatLng(lat, lng),
      rotation: bearing,
      icon: busIcon,
      infoWindow: const InfoWindow(title: 'School Bus'),
    );

    markers = {...markers.where((m) => m.markerId != busMarkerId), _busMarker!};
  }

  @override
  Future<void> close() {
    signalRService?.disconnect();
    return super.close();
  }

  Future<void> updateCurrentLocation() async {
    try {
      await mapServices.updateCurrentLocation(
        googleMapController: googleMapController,
        onUpdateCurrentLocation: (location) {
          currentLocation = location;
          if (currentLocation != null) {
            googleMapController.animateCamera(
              CameraUpdate.newLatLngBounds(
                LatLngBounds(
                  southwest: LatLng(
                    min(
                      min(currentDestination.latitude, currentSource.latitude),
                      min(
                        currentLocation!.latitude,
                        busLocation?.latitude ?? 10000,
                      ),
                    ),
                    min(
                      min(
                        currentDestination.longitude,
                        currentSource.longitude,
                      ),
                      min(
                        currentLocation!.longitude,
                        busLocation?.longitude ?? 10000,
                      ),
                    ),
                  ),
                  northeast: LatLng(
                    max(
                      max(currentDestination.latitude, currentSource.latitude),
                      max(
                        currentLocation!.latitude,
                        busLocation?.latitude ?? -10000,
                      ),
                    ),
                    max(
                      max(
                        currentDestination.longitude,
                        currentSource.longitude,
                      ),
                      max(
                        currentLocation!.longitude,
                        busLocation?.longitude ?? -10000,
                      ),
                    ),
                  ),
                ),
                36,
              ),
            );
          }
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
