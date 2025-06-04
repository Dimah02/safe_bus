class Driver {
  int? userId;
  String? name;

  Driver({this.userId, this.name});

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      userId: json['userId'] as int?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'name': name};
  }
}
