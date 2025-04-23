import 'display_name.dart';

class Landmark {
  String? name;
  String? placeId;
  DisplayName? displayName;
  List<String>? types;
  String? spatialRelationship;
  double? straightLineDistanceMeters;
  double? travelDistanceMeters;

  Landmark({
    this.name,
    this.placeId,
    this.displayName,
    this.types,
    this.spatialRelationship,
    this.straightLineDistanceMeters,
    this.travelDistanceMeters,
  });

  factory Landmark.fromJson(Map<String, dynamic> json) {
    return Landmark(
      name: json['name'] as String?,
      placeId: json['placeId'] as String?,
      displayName:
          json['displayName'] == null
              ? null
              : DisplayName.fromJson(
                json['displayName'] as Map<String, dynamic>,
              ),
      types: json['types'] as List<String>?,
      spatialRelationship: json['spatialRelationship'] as String?,
      straightLineDistanceMeters:
          (json['straightLineDistanceMeters'] as num?)?.toDouble(),
      travelDistanceMeters: (json['travelDistanceMeters'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'placeId': placeId,
      'displayName': displayName?.toJson(),
      'types': types,
      'spatialRelationship': spatialRelationship,
      'straightLineDistanceMeters': straightLineDistanceMeters,
      'travelDistanceMeters': travelDistanceMeters,
    };
  }
}
