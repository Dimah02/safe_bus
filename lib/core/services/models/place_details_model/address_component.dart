class AddressComponent {
  String? longText;
  String? shortText;
  List<String>? types;
  String? languageCode;

  AddressComponent({
    this.longText,
    this.shortText,
    this.types,
    this.languageCode,
  });

  factory AddressComponent.fromJson(Map<String, dynamic> json) {
    return AddressComponent(
      longText: json['longText'] as String?,
      shortText: json['shortText'] as String?,
      types: json['types'] as List<String>?,
      languageCode: json['languageCode'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'longText': longText,
      'shortText': shortText,
      'types': types,
      'languageCode': languageCode,
    };
  }
}
