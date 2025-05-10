import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safe_bus/core/services/location_service.dart';
import 'package:safe_bus/core/services/models/location_info/lat_lng.dart';
import 'package:safe_bus/core/services/models/location_info/location_info_model.dart';
import 'package:safe_bus/core/services/models/location_info/location_model.dart';
import 'package:safe_bus/core/services/models/place_auto_complete_model/place_auto_complete_model.dart';
import 'package:safe_bus/core/services/models/place_details_model/place_details_model.dart';
import 'package:safe_bus/core/services/places_service.dart';
import 'package:safe_bus/core/services/routes_service.dart';

class MapServices {
  final LocationService locationService;
  final PlacesService placesService;
  final RoutesService routesService;
  static bool routeDisplayed = false;
  LatLng? currentLocation;

  MapServices({
    required this.locationService,
    required this.placesService,
    required this.routesService,
  });

  getPredictions({
    required String input,
    required String token,
    required List<PlaceAutoCompleteModel> places,
  }) async {
    if (input.isNotEmpty) {
      var result = await placesService.getPredictions(
        input: input,
        token: token,
      );
      places.clear();
      if (input.isNotEmpty) places.addAll(result);
    } else {
      places.clear();
    }
  }

  Future<List<LatLng>> getRouteData({
    required LatLng currentDestination,
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
    var routes = await routesService.fetchRoutes(
      origin: origin,
      destination: destination,
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

  void displayDestinationMarker({
    required LatLng currentDestination,
    required Set<Marker> markers,
  }) {
    Marker destinationMarker = Marker(
      markerId: MarkerId("Destination"),
      position: currentDestination,
    );
    markers.clear();
    markers.add(destinationMarker);
  }

  void updateCurrentLocation({
    required GoogleMapController googleMapController,
    required Set<Marker> markers,
    required Function onUpdateCurrentLocation,
  }) {
    locationService.getRealTimeLocationData((locationData) {
      currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
      // Marker currentLocationMarker = Marker(
      //   markerId: MarkerId("Current Location"),
      //   position: currentLocation!,
      // );
      //markers.add(currentLocationMarker);
      CameraPosition cameraPosition = CameraPosition(
        target: currentLocation!,
        zoom: 16,
      );

      if (routeDisplayed == false) {
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(cameraPosition),
        );
      }
      onUpdateCurrentLocation();
    });
  }

  Future<PlaceDetailsModel> getPlaceDetails({
    required String placeId,
    required String token,
  }) async {
    return await placesService.getPlaceDetails(token: token, placeId: placeId);
  }
}
