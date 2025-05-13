class Interconnection {
  String? fromWaypoint;
  String? toWaypoint;
  int? distance;
  int? time;
  int? rest;
  int? waiting;

  Interconnection({
    this.fromWaypoint,
    this.toWaypoint,
    this.distance,
    this.time,
    this.rest,
    this.waiting,
  });

  factory Interconnection.fromJson(Map<String, dynamic> json) {
    return Interconnection(
      fromWaypoint: json['fromWaypoint'] as String?,
      toWaypoint: json['toWaypoint'] as String?,
      distance: json['distance'] as int?,
      time: json['time'] as int?,
      rest: json['rest'] as int?,
      waiting: json['waiting'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fromWaypoint': fromWaypoint,
      'toWaypoint': toWaypoint,
      'distance': distance,
      'time': time,
      'rest': rest,
      'waiting': waiting,
    };
  }
}
