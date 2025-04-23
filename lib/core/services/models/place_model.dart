import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng location;

  PlaceModel({required this.id, required this.name, required this.location});
}

List<PlaceModel> places = [
  PlaceModel(
    id: 1,
    name: 'Place 1',
    location: const LatLng(31.99143944886116, 35.951815861649145),
  ),
  PlaceModel(
    id: 2,
    name: 'Place 2',
    location: const LatLng(31.9861980342489, 35.945593136935265),
  ),
  PlaceModel(
    id: 3,
    name: 'Place 3',
    location: const LatLng(31.985676289830915, 35.94476716518394),
  ),
];
