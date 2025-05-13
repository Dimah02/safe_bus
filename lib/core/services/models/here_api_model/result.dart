import 'interconnection.dart';
import 'time_breakdown.dart';
import 'waypoint.dart';

class Result {
  List<Waypoint>? waypoints;
  String? distance;
  String? time;
  List<Interconnection>? interconnections;
  String? description;
  TimeBreakdown? timeBreakdown;

  Result({
    this.waypoints,
    this.distance,
    this.time,
    this.interconnections,
    this.description,
    this.timeBreakdown,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      waypoints:
          (json['waypoints'] as List<dynamic>?)
              ?.map((e) => Waypoint.fromJson(e as Map<String, dynamic>))
              .toList(),
      distance: json['distance'] as String?,
      time: json['time'] as String?,
      interconnections:
          (json['interconnections'] as List<dynamic>?)
              ?.map((e) => Interconnection.fromJson(e as Map<String, dynamic>))
              .toList(),
      description: json['description'] as String?,
      timeBreakdown:
          json['timeBreakdown'] == null
              ? null
              : TimeBreakdown.fromJson(
                json['timeBreakdown'] as Map<String, dynamic>,
              ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'waypoints': waypoints?.map((e) => e.toJson()).toList(),
      'distance': distance,
      'time': time,
      'interconnections': interconnections?.map((e) => e.toJson()).toList(),
      'description': description,
      'timeBreakdown': timeBreakdown?.toJson(),
    };
  }
}
