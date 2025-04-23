import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:safe_bus/core/services/location_service.dart';
import 'package:safe_bus/core/services/map_services.dart';
import 'package:safe_bus/core/services/places_service.dart';
import 'package:safe_bus/core/services/routes_service.dart';

import 'package:uuid/uuid.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  late MapServices mapServices;
  late GoogleMapController googleMapController;
  late Uuid uuid;
  late LatLng currentDestination;
  String? token;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    uuid = Uuid();
    initialCameraPosition = const CameraPosition(target: LatLng(0, 0), zoom: 0);
    mapServices = MapServices(
      locationService: LocationService(),
      placesService: PlacesService(),
      routesService: RoutesService(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          zoomControlsEnabled: false,
          initialCameraPosition: initialCameraPosition,
          myLocationEnabled: true,
          markers: markers,
          polylines: polylines,
          onMapCreated: (controller) {
            googleMapController = controller;
            updateCurrentLocation();
          },
        ),
        Positioned(
          bottom: 24,
          right: 16,
          child: IconButton(
            color: Colors.white,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.grey),
            ),
            icon: Icon(FontAwesomeIcons.locationCrosshairs, size: 32),
            onPressed: () {
              MapServices.routeDisplayed = false;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  void updateCurrentLocation() {
    try {
      mapServices.updateCurrentLocation(
        googleMapController: googleMapController,
        markers: markers,
        onUpdateCurrentLocation: () {
          setState(() {});
        },
      );
      setState(() {});
    } on LocationServiceException catch (e) {
      // TODO
    } on LocationPermissionException catch (e) {
      //TODO
    } catch (e) {
      //TODO
    }
  }
}
