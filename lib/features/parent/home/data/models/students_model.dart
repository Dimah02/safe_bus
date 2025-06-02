import 'dart:convert';

List<Students> studentsFromJson(String str) => List<Students>.from(json.decode(str).map((x) => Students.fromJson(x)));

String studentsToJson(List<Students> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Students {
    final int studentId;
    final int parentId;
    final String studentName;
    final String image;
    final int grade;
    final int gender;
    final dynamic parent;
    final dynamic rides;
    final dynamic studentLocations;
    final dynamic absences;

    Students({
        required this.studentId,
        required this.parentId,
        required this.studentName,
        required this.image,
        required this.grade,
        required this.gender,
        required this.parent,
        required this.rides,
        required this.studentLocations,
        required this.absences,
    });

    factory Students.fromJson(Map<String, dynamic> json) => Students(
        studentId: json["studentId"],
        parentId: json["parentId"],
        studentName: json["studentName"],
        image: json["image"],
        grade: json["grade"],
        gender: json["gender"],
        parent: json["parent"],
        rides: json["rides"],
        studentLocations: json["studentLocations"],
        absences: json["absences"],
    );

    Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "parentId": parentId,
        "studentName": studentName,
        "image": image,
        "grade": grade,
        "gender": gender,
        "parent": parent,
        "rides": rides,
        "studentLocations": studentLocations,
        "absences": absences,
    };
}