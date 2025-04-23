class TimeZone {
  String? id;

  TimeZone({this.id});

  factory TimeZone.fromJson(Map<String, dynamic> json) {
    return TimeZone(id: json['id'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
