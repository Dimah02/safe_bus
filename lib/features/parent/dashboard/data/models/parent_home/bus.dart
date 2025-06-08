class Bus {
  int? busId;
  String? busNumber;

  Bus({this.busId, this.busNumber});

  factory Bus.fromJson(Map<String, dynamic> json) {
    return Bus(
      busId: json['busId'] as int?,
      busNumber: json['busNumber'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'busId': busId, 'busNumber': busNumber};
  }
}
