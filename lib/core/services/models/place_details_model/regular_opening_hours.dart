import 'period.dart';

class RegularOpeningHours {
  bool? openNow;
  List<Period>? periods;
  List<String>? weekdayDescriptions;
  String? nextOpenTime;

  RegularOpeningHours({
    this.openNow,
    this.periods,
    this.weekdayDescriptions,
    this.nextOpenTime,
  });

  factory RegularOpeningHours.fromJson(Map<String, dynamic> json) {
    return RegularOpeningHours(
      openNow: json['openNow'] as bool?,
      periods:
          (json['periods'] as List<dynamic>?)
              ?.map((e) => Period.fromJson(e as Map<String, dynamic>))
              .toList(),
      weekdayDescriptions: json['weekdayDescriptions'] as List<String>?,
      nextOpenTime: json['nextOpenTime'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'openNow': openNow,
      'periods': periods?.map((e) => e.toJson()).toList(),
      'weekdayDescriptions': weekdayDescriptions,
      'nextOpenTime': nextOpenTime,
    };
  }
}
