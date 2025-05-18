import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safe_bus/core/services/location_service.dart';
import 'package:safe_bus/core/services/models/location_info/lat_lng.dart';
import 'package:safe_bus/core/services/models/location_info/location_info_model.dart';
import 'package:safe_bus/core/services/models/location_info/location_model.dart';
import 'package:safe_bus/core/services/models/routes_model/intermediates.dart';
import 'package:safe_bus/core/services/routes_service.dart';

class MapServices {
  final LocationService locationService;
  final RoutesService routesService;
  int updateCameraOnce; // if 0 yes if one  no
  static bool routeDisplayed = false;
  LatLng? currentLocation;

  MapServices({
    required this.locationService,
    required this.routesService,
    this.updateCameraOnce = 1,
  });

  Future<List<LatLng>> getRouteData({
    required LatLng currentDestination,
    required List<LatLng> waypoints,
  }) async {
    LocationInfoModel origin, destination;
    origin = LocationInfoModel(
      location: LocationModel(
        latLng: LatLngModel(
          latitude: currentLocation!.latitude,
          longitude: currentLocation!.longitude,
        ),
      ),
    );
    destination = LocationInfoModel(
      location: LocationModel(
        latLng: LatLngModel(
          latitude: currentDestination.latitude,
          longitude: currentDestination.longitude,
        ),
      ),
    );
    List<LocationInfoModel> locations = List.empty();
    locations =
        waypoints
            .map(
              (e) => LocationInfoModel(
                location: LocationModel(
                  latLng: LatLngModel(
                    latitude: e.latitude,
                    longitude: e.longitude,
                  ),
                ),
              ),
            )
            .toList();
    Intermediates intermediates = Intermediates(intermediates: locations);
    var routes = await routesService.fetchRoutes(
      origin: origin,
      destination: destination,
      intermediates: intermediates,
    );
    PolylinePoints polylinePoints = PolylinePoints();

    return polylinePoints
        .decodePolyline(routes.routes!.first.polyline!.encodedPolyline!)
        .map((e) => LatLng(e.latitude, e.longitude))
        .toList();
  }

  void displayRoute({
    required List<LatLng> points,
    required Set<Polyline> polylines,
    required GoogleMapController googleMapController,
  }) {
    Polyline route = Polyline(
      polylineId: PolylineId("Route"),
      points: points,
      color: Colors.blue,
      width: 5,
    );
    polylines.clear();
    polylines.add(route);

    LatLngBounds bounds = getLatLngBound(points);
    googleMapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 16));
    routeDisplayed = true;
  }

  LatLngBounds getLatLngBound(List<LatLng> points) {
    double minLat = double.infinity;
    double maxLat = double.negativeInfinity;
    double minLng = double.infinity;
    double maxLng = double.negativeInfinity;
    for (var point in points) {
      minLat = math.min(minLat, point.latitude);
      maxLat = math.max(maxLat, point.latitude);
      minLng = math.min(minLng, point.longitude);
      maxLng = math.max(maxLng, point.longitude);
    }
    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  void displayMarkers({
    required LatLng currentDestination,
    required List<LatLng> waypoints,
    required Set<Marker> markers,
  }) {
    Marker destinationMarker = Marker(
      markerId: MarkerId("Destination"),
      position: currentDestination,
    );
    markers.clear();

    for (int i = 0; i < waypoints.length; i++) {
      markers.add(
        Marker(markerId: MarkerId("waypoint${i + 1}"), position: waypoints[i]),
      );
    }
    markers.add(destinationMarker);
  }

  Future<void> updateCurrentLocation({
    required GoogleMapController googleMapController,
    required Function(LatLng? newLocation) onUpdateCurrentLocation,
  }) async {
    locationService.getRealTimeLocationData((locationData) {
      currentLocation = LatLng(locationData.latitude!, locationData.longitude!);

      CameraPosition cameraPosition = CameraPosition(
        target: currentLocation!,
        zoom: 16,
      );

      if (updateCameraOnce == 0) {
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(cameraPosition),
        );
        updateCameraOnce = 2;
      } else if (updateCameraOnce == 1) {
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(cameraPosition),
        );
      }
      onUpdateCurrentLocation(currentLocation);
    });
  }
}
