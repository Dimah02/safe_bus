import 'active_location.dart';

class StudentModel {
  int? studentId;
  int? rideId;
  String? studentName;
  int? grade;
  int? gender;
  String? image;
  int? rideStatus;

  List<ActiveLocation>? activeLocations;

  StudentModel({
    this.studentId,
    this.studentName,
    this.grade,
    this.gender,
    this.image,
    this.activeLocations,
    this.rideStatus,
    this.rideId,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      rideId: json['rideId'] as int?,
      studentId: json['studentId'] as int?,
      studentName: json['studentName'] as String?,
      grade: json['grade'] as int?,
      gender: json['gender'] as int?,
      image: json['image'] as String?,
      activeLocations:
          (json['activeLocations'] as List<dynamic>?)
              ?.map((e) => ActiveLocation.fromJson(e as Map<String, dynamic>))
              .toList(),
      rideStatus: json['rideStatus'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'studentName': studentName,
      'grade': grade,
      'gender': gender,
      'image': image,
      'activeLocations': activeLocations?.map((e) => e.toJson()).toList(),
    };
  }

  bool isPending() {
    return rideStatus == 0;
  }

  bool isPresent() {
    return rideStatus == 1;
  }

  bool isAbsent() {
    return rideStatus == 2;
  }
}
