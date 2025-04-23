class Text {
  String? text;
  String? languageCode;

  Text({this.text, this.languageCode});

  factory Text.fromJson(Map<String, dynamic> json) {
    return Text(
      text: json['text'] as String?,
      languageCode: json['languageCode'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'languageCode': languageCode};
  }
}
