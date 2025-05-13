class Waypoint {
  String? id;
  double? lat;
  double? lng;
  int? sequence;
  dynamic estimatedArrival;
  String? estimatedDeparture;
  List<dynamic>? fulfilledConstraints;

  Waypoint({
    this.id,
    this.lat,
    this.lng,
    this.sequence,
    this.estimatedArrival,
    this.estimatedDeparture,
    this.fulfilledConstraints,
  });

  factory Waypoint.fromJson(Map<String, dynamic> json) {
    return Waypoint(
      id: json['id'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      sequence: json['sequence'] as int?,
      estimatedArrival: json['estimatedArrival'] as dynamic,
      estimatedDeparture: json['estimatedDeparture'] as String?,
      fulfilledConstraints: json['fulfilledConstraints'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lat': lat,
      'lng': lng,
      'sequence': sequence,
      'estimatedArrival': estimatedArrival,
      'estimatedDeparture': estimatedDeparture,
      'fulfilledConstraints': fulfilledConstraints,
    };
  }
}
