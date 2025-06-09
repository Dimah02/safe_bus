class Driver {
  int? userId;
  String? name;
  String? phoneNo;
  String? email;

  Driver({this.userId, this.name, this.phoneNo, this.email});

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
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
