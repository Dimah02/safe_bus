class High {
  double? latitude;
  double? longitude;

  High({this.latitude, this.longitude});

  factory High.fromJson(Map<String, dynamic> json) {
    return High(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'latitude': latitude, 'longitude': longitude};
  }
}
