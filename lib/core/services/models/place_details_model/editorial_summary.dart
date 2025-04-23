class EditorialSummary {
  String? text;
  String? languageCode;

  EditorialSummary({this.text, this.languageCode});

  factory EditorialSummary.fromJson(Map<String, dynamic> json) {
    return EditorialSummary(
      text: json['text'] as String?,
      languageCode: json['languageCode'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'languageCode': languageCode};
  }
}
