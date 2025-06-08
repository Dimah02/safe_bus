import 'assistant_teacher.dart';
import 'bus.dart';
import 'driver.dart';

class StudentRoute {
  int? busRouteId;
  String? zoneName;
  double? distance;
  bool? isActive;
  DateTime? startTime;
  DateTime? endTime;
  int? tripType;
  int? tripRound;
  dynamic currentLocationJson;
  dynamic lastLocationUpdate;
  String? schoolName;
  double? schoolLatitude;
  double? schoolLongitude;
  Driver? driver;
  AssistantTeacher? assistantTeacher;
  Bus? bus;

  StudentRoute({
    this.busRouteId,
    this.zoneName,
    this.distance,
    this.isActive,
    this.startTime,
    this.endTime,
    this.tripType,
    this.tripRound,
    this.currentLocationJson,
    this.lastLocationUpdate,
    this.schoolName,
    this.schoolLatitude,
    this.schoolLongitude,
    this.driver,
    this.assistantTeacher,
    this.bus,
  });

  factory StudentRoute.fromJson(Map<String, dynamic> json) {
    return StudentRoute(
      busRouteId: json['busRouteId'] as int?,
      zoneName: json['zoneName'] as String?,
      distance: (json['distance'] as num?)?.toDouble(),
      isActive: json['isActive'] as bool?,
      startTime:
          json['startTime'] != null
              ? DateTime.parse(json['startTime'])
              : DateTime.now(),
      endTime:
          json['endTime'] != null
              ? DateTime.parse(json['endTime'])
              : DateTime.now().add(Duration(hours: 1, minutes: 30)),
      tripType: json['tripType'] as int?,
      tripRound: json['tripRound'] as int?,
      currentLocationJson: json['currentLocationJson'] as dynamic,
      lastLocationUpdate: json['lastLocationUpdate'] as dynamic,
      schoolName: json['schoolName'] as String?,
      schoolLatitude: (json['schoolLatitude'] as num?)?.toDouble(),
      schoolLongitude: (json['schoolLongitude'] as num?)?.toDouble(),
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
      bus:
          json['bus'] == null
              ? null
              : Bus.fromJson(json['bus'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'busRouteId': busRouteId,
      'zoneName': zoneName,
      'distance': distance,
      'isActive': isActive,
      'startTime': startTime,
      'endTime': endTime,
      'tripType': tripType,
      'tripRound': tripRound,
      'currentLocationJson': currentLocationJson,
      'lastLocationUpdate': lastLocationUpdate,
      'schoolName': schoolName,
      'schoolLatitude': schoolLatitude,
      'schoolLongitude': schoolLongitude,
      'driver': driver?.toJson(),
      'assistantTeacher': assistantTeacher?.toJson(),
      'bus': bus?.toJson(),
    };
  }

  String getTimeLeftString() {
    if (startTime == null) return 'Not scheduled';

    final now = DateTime.now();
    final difference = startTime!.difference(now);

    if (difference.isNegative) {
      return 'In progress';
    }

    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;

    return '${hours}hours ${minutes}mins Left';
  }

  String getFormattedDate() {
    final day = startTime!.day;
    final month = _getMonthName(startTime!.month);
    final year = startTime!.year;
    final weekday = _getWeekdayName(startTime!.weekday);

    return '$weekday, $day $month $year';
  }

  String getFormattedDate2() {
    final weekday = _getWeekdayName(startTime!.weekday);

    return '$weekday, ${startTime!.hour}:${startTime!.minute} to ${endTime!.hour}:${endTime!.minute}';
  }

  String getFormattedEndTime() {
    return '${endTime!.hour}:${endTime!.minute}';
  }

  String getFormattedStartTime() {
    return '${startTime!.hour}:${startTime!.minute}';
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  String _getWeekdayName(int weekday) {
    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return weekdays[weekday - 1];
  }

  String getDurationString() {
    Duration duration =
        startTime?.difference(endTime ?? DateTime.now()) ??
        Duration(minutes: 30);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    return '${hours}h ${minutes}m';
  }
}
