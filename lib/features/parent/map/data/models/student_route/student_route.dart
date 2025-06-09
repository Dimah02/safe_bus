import 'ride.dart';

class StudentRoute {
  int? studentId;
  String? studentName;
  int? grade;
  int? gender;
  String? image;
  List<Ride>? rides;

  StudentRoute({
    this.studentId,
    this.studentName,
    this.grade,
    this.gender,
    this.image,
    this.rides,
  });

  factory StudentRoute.fromJson(Map<String, dynamic> json) {
    return StudentRoute(
      studentId: json['studentId'] as int?,
      studentName: json['studentName'] as String?,
      grade: json['grade'] as int?,
      gender: json['gender'] as int?,
      image: json['image'] as String?,
      rides:
          (json['rides'] as List<dynamic>?)
              ?.map((e) => Ride.fromJson(e as Map<String, dynamic>))
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
      'rides': rides?.map((e) => e.toJson()).toList(),
    };
  }

  Ride? morningRoute() {
    for (var ride in rides!) {
      if (ride.tripType == 0) return ride;
    }
    return null;
  }

  Ride? afternoonRoute() {
    for (var ride in rides!) {
      if (ride.tripType != 0) return ride;
    }
    return null;
  }
}
