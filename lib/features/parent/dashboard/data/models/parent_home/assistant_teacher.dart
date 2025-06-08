class AssistantTeacher {
  int? userId;
  String? name;
  String? phoneNo;
  String? email;

  AssistantTeacher({this.userId, this.name, this.phoneNo, this.email});

  factory AssistantTeacher.fromJson(Map<String, dynamic> json) {
    return AssistantTeacher(
      userId: json['userId'] as int?,
      name: json['name'] as String?,
      phoneNo: json['phoneNo'] as String?,
      email: json['email'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'name': name, 'phoneNo': phoneNo, 'email': email};
  }
}
