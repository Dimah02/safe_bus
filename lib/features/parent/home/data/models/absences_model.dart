import 'dart:convert';

import 'package:safe_bus/features/parent/home/data/models/students_model.dart';

List<Absences> absencesFromJson(String str) =>
    List<Absences>.from(json.decode(str).map((x) => Absences.fromJson(x)));

String absencesToJson(List<Absences> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Absences {
  final int absenceId;
  final int studentId;
  final DateTime date;
  final bool pickupStatus;
  final bool dropoffStatus;
  final Students student;

  Absences({
    required this.absenceId,
    required this.studentId,
    required this.date,
    required this.pickupStatus,
    required this.dropoffStatus,
    required this.student,
  });

  factory Absences.fromJson(Map<String, dynamic> json) => Absences(
    absenceId: json["absenceId"],
    studentId: json["studentId"],
    date: DateTime.parse(json["date"]),
    pickupStatus: json["pickupSatus"],
    dropoffStatus: json["dropoffStatus"],
    student: Students.fromJson(json["student"]),
  );

  Map<String, dynamic> toJson() => {
    "absenceId": absenceId,
    "studentId": studentId,
    "date": date.toIso8601String(),
    "pickupSatus": pickupStatus,
    "dropoffStatus": dropoffStatus,
    "student": student,
  };
}
