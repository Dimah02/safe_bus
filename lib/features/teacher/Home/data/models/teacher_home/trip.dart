import 'package:flutter/material.dart';
import 'package:safe_bus/features/teacher/Home/data/models/teacher_home/assistant_teacher.dart';
import 'package:safe_bus/features/teacher/Home/data/models/teacher_home/bus.dart';
import 'package:safe_bus/features/teacher/Home/data/models/teacher_home/driver.dart';

class Trip {
  final int? busRouteId;
  final int? busId;
  final int? driverId;
  final int? assistantTeacherId;
  final Bus? bus;
  final Driver? driver;
  final AssistantTeacher? assistantTeacher;
  final String? zoneName;
  final int? distance;
  final DateTime? date;
  final String? tripNumber;
  final int? studentCount;
  final Duration? duration;
  TripStatus? status;
  final DateTime? startTime;
  final DateTime? endTime;
  final double schoolLatitude;
  final double schoolLongitude;

  Trip({
    required this.busRouteId,
    required this.busId,
    required this.driverId,
    required this.assistantTeacherId,
    required this.bus,
    required this.driver,
    required this.assistantTeacher,
    required this.zoneName,
    required this.date,
    required this.tripNumber,
    required this.distance,
    required this.studentCount,
    required this.duration,
    required this.status,
    this.startTime,
    this.endTime,
    required this.schoolLatitude,
    required this.schoolLongitude,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      busRouteId: json['busRouteId'] as int?,
      busId: json['busId'] as int?,
      driverId: json['driverId'] as int?,
      assistantTeacherId: json['assistantTeacherId'] as int?,
      bus:
          json['bus'] == null
              ? null
              : Bus.fromJson(json['bus'] as Map<String, dynamic>),
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
      zoneName: json['zoneName'] as String? ?? "Zone 1",
      distance: json['distance']?.round() as int? ?? 20,
      date: DateTime.now(),
      tripNumber: json['busRouteId']?.toString(),
      studentCount: json['rides']?.length ?? 0,
      duration: Duration(hours: 2),
      status: TripStatus.current,
      startTime:
          json['startTime'] != null
              ? DateTime.parse(json['startTime'])
              : DateTime.now(),
      endTime:
          json['endTime'] != null
              ? DateTime.parse(json['endTime'])
              : DateTime.now().add(Duration(hours: 1, minutes: 30)),
      schoolLatitude: json['schoolLatitude'],
      schoolLongitude: json['schoolLongitude'],
    );
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
    final day = date!.day;
    final month = _getMonthName(date!.month);
    final year = date!.year;
    final weekday = _getWeekdayName(date!.weekday);

    return '$weekday, $day $month $year';
  }

  String getFormattedDate2() {
    final weekday = _getWeekdayName(date!.weekday);

    return '$weekday, ${startTime!.hour}:${startTime!.minute} to ${endTime!.hour}:${endTime!.minute}';
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
    final hours = duration!.inHours;
    final minutes = duration!.inMinutes % 60;

    return '${hours}h ${minutes}m';
  }
}

enum TripStatus { upcoming, current, completed, pending, cancelled }

extension TripStatusExtension on TripStatus {
  String get name {
    switch (this) {
      case TripStatus.upcoming:
        return 'Upcoming';
      case TripStatus.current:
        return 'Current';
      case TripStatus.completed:
        return 'Completed';
      case TripStatus.pending:
        return 'Pending';
      case TripStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color get color {
    switch (this) {
      case TripStatus.upcoming:
        return Colors.orange;
      case TripStatus.current:
        return Colors.green;
      case TripStatus.completed:
        return Colors.green;
      case TripStatus.pending:
        return Colors.blue;
      case TripStatus.cancelled:
        return Colors.red;
    }
  }
}
