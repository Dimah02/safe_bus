import 'dart:convert';
import 'package:safe_bus/features/parent/data/models/students.dart';
import 'package:safe_bus/features/driver/dashboard/data/models/driver_home/trip.dart';

List<Rides> ridesFromJson(String str) => List<Rides>.from(json.decode(str).map((x) => Rides.fromJson(x)));

String ridesToJson(List<Rides> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Rides {
    final int rideId;
    final int busRouteId;
    final int studentId;
    final int rideStatus;
    final Trip busRoute;
    final Students student;

    Rides({
        required this.rideId,
        required this.busRouteId,
        required this.studentId,
        required this.rideStatus,
        required this.busRoute,
        required this.student,
    });

    factory Rides.fromJson(Map<String, dynamic> json) => Rides(
        rideId: json["rideId"],
        busRouteId: json["busRouteId"],
        studentId: json["studentId"],
        rideStatus: json["rideStatus"],
        busRoute: json["busRoute"],
        student: json["student"],
    );

    Map<String, dynamic> toJson() => {
        "rideId": rideId,
        "busRouteId": busRouteId,
        "studentId": studentId,
        "rideStatus": rideStatus,
        "busRoute": busRoute,
        "student": student,
    };
}