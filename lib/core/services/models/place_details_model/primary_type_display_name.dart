class PrimaryTypeDisplayName {
  String? text;
  String? languageCode;

  PrimaryTypeDisplayName({this.text, this.languageCode});

  factory PrimaryTypeDisplayName.fromJson(Map<String, dynamic> json) {
    return PrimaryTypeDisplayName(
      text: json['text'] as String?,
      languageCode: json['languageCode'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'languageCode': languageCode};
  }
}
