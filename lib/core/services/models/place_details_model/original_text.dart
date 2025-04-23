class OriginalText {
  String? text;
  String? languageCode;

  OriginalText({this.text, this.languageCode});

  factory OriginalText.fromJson(Map<String, dynamic> json) {
    return OriginalText(
      text: json['text'] as String?,
      languageCode: json['languageCode'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'languageCode': languageCode};
  }
}
