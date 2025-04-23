class SecondaryText {
  String? text;

  SecondaryText({this.text});

  factory SecondaryText.fromJson(Map<String, dynamic> json) {
    return SecondaryText(text: json['text'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {'text': text};
  }
}
