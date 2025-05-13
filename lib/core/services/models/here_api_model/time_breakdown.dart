class TimeBreakdown {
  int? driving;
  int? service;
  int? rest;
  int? waiting;
  int? timeBreakdownBreak;

  TimeBreakdown({
    this.driving,
    this.service,
    this.rest,
    this.waiting,
    this.timeBreakdownBreak,
  });

  factory TimeBreakdown.fromJson(Map<String, dynamic> json) {
    return TimeBreakdown(
      driving: json['driving'] as int?,
      service: json['service'] as int?,
      rest: json['rest'] as int?,
      waiting: json['waiting'] as int?,
      timeBreakdownBreak: json['break'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'driving': driving,
      'service': service,
      'rest': rest,
      'waiting': waiting,
      'break': timeBreakdownBreak,
    };
  }
}
