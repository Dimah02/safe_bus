import 'display_name.dart';

class Area {
  String? name;
  String? placeId;
  DisplayName? displayName;
  String? containment;

  Area({this.name, this.placeId, this.displayName, this.containment});

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      name: json['name'] as String?,
      placeId: json['placeId'] as String?,
      displayName:
          json['displayName'] == null
              ? null
              : DisplayName.fromJson(
                json['displayName'] as Map<String, dynamic>,
              ),
      containment: json['containment'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'placeId': placeId,
      'displayName': displayName?.toJson(),
      'containment': containment,
    };
  }
}
