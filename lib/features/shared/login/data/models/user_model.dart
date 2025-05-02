class UserModel {
  String? name;
  String? phoneNo;
  int? userType;
  String? email;
  dynamic sentNotifications;
  dynamic receivedNotifications;

  UserModel({
    this.name,
    this.phoneNo,
    this.userType,
    this.email,
    this.sentNotifications,
    this.receivedNotifications,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['user']['name'] as String?,
      phoneNo: json['user']['phoneNo'] as String?,
      userType: json['user']['userType'] as int?,
      email: json['user']['email'] as String?,
      sentNotifications: json['user']['sentNotifications'] as dynamic,
      receivedNotifications: json['user']['receivedNotifications'] as dynamic,
    );
  }
}
