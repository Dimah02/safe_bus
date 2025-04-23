import 'high.dart';
import 'low.dart';

class Viewport {
  Low? low;
  High? high;

  Viewport({this.low, this.high});

  factory Viewport.fromJson(Map<String, dynamic> json) {
    return Viewport(
      low:
          json['low'] == null
              ? null
              : Low.fromJson(json['low'] as Map<String, dynamic>),
      high:
          json['high'] == null
              ? null
              : High.fromJson(json['high'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {'low': low?.toJson(), 'high': high?.toJson()};
  }
}
