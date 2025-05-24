import 'active_location.dart';

class Students {
  int? studentId;
  String? studentName;
  int? grade;
  int? gender;
  String? image;
  List<ActiveLocation>? activeLocations;

  Students({
    this.studentId,
    this.studentName,
    this.grade,
    this.gender,
    this.image,
    this.activeLocations,
  });

  factory Students.fromJson(Map<String, dynamic> json) {
    return Students(
      studentId: json['studentId'] as int?,
      studentName: json['studentName'] as String?,
      grade: json['grade'] as int?,
      gender: json['gender'] as int?,
      image: json['image'] as String?,
      activeLocations:
          (json['activeLocations'] as List<dynamic>?)
              ?.map((e) => ActiveLocation.fromJson(e as Map<String, dynamic>))
              .toList(),
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
}
