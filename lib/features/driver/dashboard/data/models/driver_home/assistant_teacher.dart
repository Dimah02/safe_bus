class AssistantTeacher {
  int? userId;
  String? name;

  AssistantTeacher({this.userId, this.name});

  factory AssistantTeacher.fromJson(Map<String, dynamic> json) {
    return AssistantTeacher(
      userId: json['userId'] as int?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'name': name};
  }
}
