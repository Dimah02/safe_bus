import 'assistant_teacher.dart';
import 'driver.dart';
import 'dropoff_location.dart';
import 'pickup_location.dart';

class Ride {
  int? rideId;
  int? rideStatus;
  int? busRouteId;
  String? zoneName;
  String? schoolName;
  double? schoolLatitude;
  double? schoolLongitude;
  double? distance;
  bool? isActive;
  String? startTime;
  String? endTime;
  int? tripType;
  int? tripRound;
  Driver? driver;
  AssistantTeacher? assistantTeacher;
  PickupLocation? pickupLocation;
  DropoffLocation? dropoffLocation;

  Ride({
    this.rideId,
    this.rideStatus,
    this.busRouteId,
    this.zoneName,
    this.schoolName,
    this.schoolLatitude,
    this.schoolLongitude,
    this.distance,
    this.isActive,
    this.startTime,
    this.endTime,
    this.tripType,
    this.tripRound,
    this.driver,
    this.assistantTeacher,
    this.pickupLocation,
    this.dropoffLocation,
  });

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      rideId: json['rideId'] as int?,
      rideStatus: json['rideStatus'] as int?,
      busRouteId: json['busRouteId'] as int?,
      zoneName: json['zoneName'] as String?,
      schoolName: json['schoolName'] as String?,
      schoolLatitude: (json['schoolLatitude'] as num?)?.toDouble(),
      schoolLongitude: (json['schoolLongitude'] as num?)?.toDouble(),
      distance: (json['distance'] as num?)?.toDouble(),
      isActive: json['isActive'] as bool?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      tripType: json['tripType'] as int?,
      tripRound: json['tripRound'] as int?,
      driver:
          json['driver'] == null
              ? null
              : Driver.fromJson(json['driver'] as Map<String, dynamic>),
      assistantTeacher:
          json['assistantTeacher'] == null
              ? null
              : AssistantTeacher.fromJson(
                json['assistantTeacher'] as Map<String, dynamic>,
              ),
      pickupLocation:
          json['pickupLocation'] == null
              ? null
              : PickupLocation.fromJson(
                json['pickupLocation'] as Map<String, dynamic>,
              ),
      dropoffLocation:
          json['dropoffLocation'] == null
              ? null
              : DropoffLocation.fromJson(
                json['dropoffLocation'] as Map<String, dynamic>,
              ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rideId': rideId,
      'rideStatus': rideStatus,
      'busRouteId': busRouteId,
      'zoneName': zoneName,
      'schoolName': schoolName,
      'schoolLatitude': schoolLatitude,
      'schoolLongitude': schoolLongitude,
      'distance': distance,
      'isActive': isActive,
      'startTime': startTime,
      'endTime': endTime,
      'tripType': tripType,
      'tripRound': tripRound,
      'driver': driver?.toJson(),
      'assistantTeacher': assistantTeacher?.toJson(),
      'pickupLocation': pickupLocation?.toJson(),
      'dropoffLocation': dropoffLocation?.toJson(),
    };
  }
}
