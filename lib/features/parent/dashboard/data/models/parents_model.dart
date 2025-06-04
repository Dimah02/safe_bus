import 'dart:convert';
import 'package:safe_bus/features/parent/dashboard/data/models/students_model.dart';

List<Parents> parentsFromJson(String str) =>
    List<Parents>.from(json.decode(str).map((x) => Parents.fromJson(x)));

String parentsToJson(List<Parents> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Parents {
  final String emergencyContact;
  late List<Students> students;
  final int userId;
  final String name;
  final String phoneNo;
  // final int userType;
  // final String email;
  // final String passwordHashed;
  // final dynamic refreshToken;
  // final dynamic refreshTokenExpiryTime;
  // final dynamic sentNotifications;
  // final dynamic receivedNotifications;

  Parents({
    required this.emergencyContact,
    required this.students,
    required this.userId,
    required this.name,
    required this.phoneNo,
    // required this.userType,
    // required this.email,
    // required this.passwordHashed,
    // required this.refreshToken,
    // required this.refreshTokenExpiryTime,
    // required this.sentNotifications,
    // required this.receivedNotifications,
  });

  factory Parents.fromJson(Map<String, dynamic> json) => Parents(
    emergencyContact: json["emergencyContact"],
    students: [],
    userId: json["userId"],
    name: json["name"],
    phoneNo: json["phoneNo"],
    // userType: json["userType"],
    // email: json["email"],
    // passwordHashed: json["passwordHashed"],
    // refreshToken: json["refreshToken"],
    // refreshTokenExpiryTime: json["refreshTokenExpiryTime"],
    // sentNotifications: json["sentNotifications"],
    // receivedNotifications: json["receivedNotifications"],
  );

  Map<String, dynamic> toJson() => {
    "emergencyContact": emergencyContact,
    "students": students.map((s) => s.toJson()).toList(),
    "userId": userId,
    "name": name,
    "phoneNo": phoneNo,
    // "userType": userType,
    // "email": email,
    // "passwordHashed": passwordHashed,
    // "refreshToken": refreshToken,
    // "refreshTokenExpiryTime": refreshTokenExpiryTime,
    // "sentNotifications": sentNotifications,
    // "receivedNotifications": receivedNotifications,
  };
}
