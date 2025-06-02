import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:safe_bus/core/services/location_service.dart';
import 'package:safe_bus/core/services/map_services.dart';
import 'package:safe_bus/core/services/routes_service.dart';
import 'package:safe_bus/features/driver/dashboard/data/models/driver_home/trip.dart';
import 'package:safe_bus/features/driver/map/data/models/student_model/student_model.dart';
import 'package:safe_bus/features/driver/map/data/repo/trip_students_repo.dart';

part 'driver_map_state.dart';

class DriverMapCubit extends Cubit<DriverMapState> {
  DriverMapCubit({required this.trip, required this.currentDestination})
    : super(DriverMapInitial());

  MapServices mapServices = MapServices(
    locationService: LocationService(),
    routesService: RoutesService(),
    updateCameraOnce: 0,
  );
  late GoogleMapController googleMapController;
  final Trip trip;
  late List<StudentModel> students;
  LatLng? currentLocation, prevLocation;
  int? _distanceMeters;
  String? _duration;

  String get distanceMeters {
    if (_distanceMeters == null) return "";

    return "${_distanceMeters! / 1000} KM";
  }

  String get duration {
    if (_duration == null) return "";
    int seconds = int.parse(_duration!.substring(0, _duration!.length - 1));
    int minutes = seconds ~/ 60;
    return "$minutes minutes left";
  }

  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(0, 0),
    zoom: 0,
  );
  final LatLng currentDestination;

  void onMapCreated(GoogleMapController controller) async {
    if (!isClosed) {
      emit(DriverMapLoading());
    }
    try {
      googleMapController = controller;

      students = await TripStudentsRepo.instance.getStudents(
        busRouteId: trip.busRouteId!,
      );
      await updateCurrentLocation(studnets: students);
      if (!isClosed) {
        emit(DriverMapSuccess());
      }
    } catch (e) {
      if (!isClosed) {
        emit(DriverMapFailure(e.toString()));
      }
    }
  }

  Future<void> displayRoute({required List<StudentModel> students}) async {
    if (!isClosed) {
      emit(DriverMapRouteLoading());
    }
    List<LatLng> waypoints = [];
    for (var student in students) {
      LatLng loc = LatLng(
        student.activeLocations!.first.latitude!,
        student.activeLocations!.first.longitude!,
      );
      if (student.isPending()) {
        waypoints.add(loc);
      }
    }
    await mapServices
        .getRouteData(
          currentDestination: currentDestination,
          waypoints: waypoints,
          onRouteDataUpdate: (newDuration, newDistance) {
            _duration = newDuration;
            _distanceMeters = newDistance;
          },
        )
        .then((value) {
          mapServices.displayMarkers(
            students: students,
            currentDestination: currentDestination,
            markers: markers,
          );
          return mapServices.displayRoute(
            points: value,
            polylines: polylines,
            googleMapController: googleMapController,
          );
        });
    if (!isClosed) {
      emit(DriverMapRouteSuccess());
    }
  }

  Future<void> updateCurrentLocation({
    required List<StudentModel> studnets,
  }) async {
    try {
      await mapServices.updateCurrentLocation(
        googleMapController: googleMapController,
        onUpdateCurrentLocation: (location) async {
          if (location != null) {
            if (prevLocation == null) {
              prevLocation = location;
              await displayRoute(students: studnets);
            } else if (_distanceBetween(prevLocation!, location) > 20) {
              await displayRoute(students: students);
              prevLocation = location;
            }
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

  double _distanceBetween(LatLng a, LatLng b) {
    return Geolocator.distanceBetween(
      a.latitude,
      a.longitude,
      b.latitude,
      b.longitude,
    );
  }
}
