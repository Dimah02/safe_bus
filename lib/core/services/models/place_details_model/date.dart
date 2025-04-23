class Date {
  int? year;
  int? month;
  int? day;

  Date({this.year, this.month, this.day});

  factory Date.fromJson(Map<String, dynamic> json) {
    return Date(
      year: json['year'] as int?,
      month: json['month'] as int?,
      day: json['day'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'year': year, 'month': month, 'day': day};
  }
}
