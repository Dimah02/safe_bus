class Low {
  double? latitude;
  double? longitude;

  Low({this.latitude, this.longitude});

  factory Low.fromJson(Map<String, dynamic> json) {
    return Low(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'latitude': latitude, 'longitude': longitude};
  }
}
