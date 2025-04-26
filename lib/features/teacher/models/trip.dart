import 'package:flutter/material.dart';

class Trip {
  final String id;
  final String zoneName;
  final DateTime date;
  final String tripNumber;
  final double distance;
  final int studentCount;
  final Duration duration;
  final TripStatus status;
  final DateTime? startTime;
  final DateTime? endTime;

  Trip({
    required this.id,
    required this.zoneName,
    required this.date,
    required this.tripNumber,
    required this.distance,
    required this.studentCount,
    required this.duration,
    required this.status,
    this.startTime,
    this.endTime,
  });

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
    final day = date.day;
    final month = _getMonthName(date.month);
    final year = date.year;
    final weekday = _getWeekdayName(date.weekday);

    return '$weekday, $day $month $year';
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April',
      'May', 'June', 'July', 'August',
      'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  String _getWeekdayName(int weekday) {
    const weekdays = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday',
      'Friday', 'Saturday', 'Sunday'
    ];
    return weekdays[weekday - 1];
  }

  String getDurationString() {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    return '${hours}h ${minutes}m';
  }
}

enum TripStatus {
  upcoming,
  current,
  completed,
  pending,
  cancelled
}

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