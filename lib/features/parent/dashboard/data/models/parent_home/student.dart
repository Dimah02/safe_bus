import 'package:safe_bus/features/parent/dashboard/data/models/parent_home/student_route.dart';

import 'ride.dart';

class Student {
  int? studentId;
  String? studentName;
  String? image;
  int? grade;
  int? gender;
  List<Ride>? rides;

  Student({
    this.studentId,
    this.studentName,
    this.image,
    this.grade,
    this.gender,
    this.rides,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentId: json['studentId'] as int?,
      studentName: json['studentName'] as String?,
      image: json['image'] as String?,
      grade: json['grade'] as int?,
      gender: json['gender'] as int?,
      rides:
          (json['rides'] as List<dynamic>?)
              ?.map((e) => Ride.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'studentName': studentName,
      'image': image,
      'grade': grade,
      'gender': gender,
      'rides': rides?.map((e) => e.toJson()).toList(),
    };
  }

  bool isPending() {
    return rides?.first.rideStatus == 0;
  }

  bool isPresent() {
    return rides?.first.rideStatus == 1;
  }

  bool isAbsent() {
    return rides?.first.rideStatus == 2;
  }

  StudentRoute? morningRoute() {
    for (var ride in rides!) {
      if (ride.studentRoute?.tripType == 0) return ride.studentRoute;
    }
    return null;
  }

  StudentRoute? afternoonRoute() {
    for (var ride in rides!) {
      if (ride.studentRoute?.tripType != 0) return ride.studentRoute;
    }
    return null;
  }
}
