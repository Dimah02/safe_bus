class Close {
  int? day;
  int? hour;
  int? minute;

  Close({this.day, this.hour, this.minute});

  factory Close.fromJson(Map<String, dynamic> json) {
    return Close(
      day: json['day'] as int?,
      hour: json['hour'] as int?,
      minute: json['minute'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'day': day, 'hour': hour, 'minute': minute};
  }
}
