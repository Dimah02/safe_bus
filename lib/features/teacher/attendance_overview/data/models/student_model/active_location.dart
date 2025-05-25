import 'dart:ui';

import 'package:flutter/material.dart';

class ActiveLocation {
  int? locationId;
  String? name;
  String? description;
  double? latitude;
  double? longitude;
  int? order;
  int? locationType;
  int? rideStatus;
  Color statusColor = Colors.grey;

  ActiveLocation({
    this.locationId,
    this.name,
    this.description,
    this.latitude,
    this.longitude,
    this.order,
    this.locationType,
    this.rideStatus,
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
      rideStatus: json['rideStatus'] as int?,
    );
  }

  bool isPending() {
    return rideStatus == 0;
  }

  bool isPresent() {
    return rideStatus == 1;
  }

  bool isAbsent() {
    return rideStatus == 2;
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
