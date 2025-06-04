import 'student_route.dart';

class Ride {
  int? rideId;
  int? rideStatus;
  StudentRoute? studentRoute;

  Ride({this.rideId, this.rideStatus, this.studentRoute});

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      rideId: json['rideId'] as int?,
      rideStatus: json['rideStatus'] as int?,
      studentRoute:
          json['studentRoute'] == null
              ? null
              : StudentRoute.fromJson(
                json['studentRoute'] as Map<String, dynamic>,
              ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rideId': rideId,
      'rideStatus': rideStatus,
      'studentRoute': studentRoute?.toJson(),
    };
  }
}
