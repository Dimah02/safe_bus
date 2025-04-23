class AccessibilityOptions {
  bool? wheelchairAccessibleParking;
  bool? wheelchairAccessibleEntrance;

  AccessibilityOptions({
    this.wheelchairAccessibleParking,
    this.wheelchairAccessibleEntrance,
  });

  factory AccessibilityOptions.fromJson(Map<String, dynamic> json) {
    return AccessibilityOptions(
      wheelchairAccessibleParking: json['wheelchairAccessibleParking'] as bool?,
      wheelchairAccessibleEntrance:
          json['wheelchairAccessibleEntrance'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'wheelchairAccessibleParking': wheelchairAccessibleParking,
      'wheelchairAccessibleEntrance': wheelchairAccessibleEntrance,
    };
  }
}
