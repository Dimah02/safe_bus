import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:safe_bus/core/services/location_service.dart';
import 'package:safe_bus/core/services/map_services.dart';
import 'package:safe_bus/core/services/routes_service.dart';

part 'driver_map_state.dart';

class DriverMapCubit extends Cubit<DriverMapState> {
  DriverMapCubit() : super(DriverMapInitial());
  MapServices mapServices = MapServices(
    locationService: LocationService(),
    routesService: RoutesService(),
  );
  late GoogleMapController googleMapController;

  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(0, 0),
    zoom: 0,
  );
  LatLng currentDestination = LatLng(31.986629415135333, 35.949454055114884);

  void onMapCreated(GoogleMapController controller) async {
    emit(DriverMapLoading());
    try {
      googleMapController = controller;
      await updateCurrentLocation();

      emit(DriverMapSuccess());
    } catch (e) {
      emit(DriverMapFailure(e.toString()));
    }
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
        onUpdateCurrentLocation: () {
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
