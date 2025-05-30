import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit({required this.currentDestination}) : super(MapInitial()) {
    _initialize();
  }

  final LatLng currentDestination;
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  CameraPosition get initialCameraPosition =>
      CameraPosition(target: currentDestination, zoom: 15);

  Set<Marker> get markers => _markers;
  Set<Polyline> get polylines => _polylines;

  Future<void> _initialize() async {
    emit(MapLoading());
    // Initial setup can be done here if needed
    emit(MapReady());
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    if (state is! MapReady) emit(MapReady());

    // Center the map on the destination immediately
    _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(currentDestination, 15),
    );
  }

  @override
  Future<void> close() {
    _mapController.dispose();
    return super.close();
  }
}
