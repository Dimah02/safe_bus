import 'package:safe_bus/features/teacher/Home/data/models/teacher_home/trip.dart';

class DriverHome {
  int? userId;
  String? name;
  List<Trip>? currentTrips;
  List<Trip>? upcomingTrips;
  List<Trip>? recentTrips;

  DriverHome({
    this.userId,
    this.name,
    this.currentTrips,
    this.upcomingTrips,
    this.recentTrips,
  });

  factory DriverHome.fromJson(Map<String, dynamic> json) {
    return DriverHome(
      userId: json['userId'] as int?,
      name: json['name'] as String?,
      currentTrips:
          (json['currentTrips'] as List<dynamic>?)
              ?.map((e) => Trip.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      upcomingTrips:
          (json['upcomingTrips'] as List<dynamic>?)
              ?.map((e) => Trip.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      recentTrips:
          (json['recentTrips'] as List<dynamic>?)
              ?.map((e) => Trip.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
