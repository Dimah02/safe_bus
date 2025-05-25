class ActiveLocation {
  int? locationId;
  String? name;
  String? description;
  double? latitude;
  double? longitude;
  int? order;
  int? locationType;

  ActiveLocation({
    this.locationId,
    this.name,
    this.description,
    this.latitude,
    this.longitude,
    this.order,
    this.locationType,
  });

  factory ActiveLocation.fromJson(Map<String, dynamic> json) {
    return ActiveLocation(
      locationId: json['locationId'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      order: json['order'] as int?,
      locationType: json['locationType'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'locationId': locationId,
      'name': name,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'order': order,
      'locationType': locationType,
    };
  }
}
