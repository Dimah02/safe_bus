import 'match.dart';

class MainText {
  String? text;
  List<Match>? matches;

  MainText({this.text, this.matches});

  factory MainText.fromJson(Map<String, dynamic> json) {
    return MainText(
      text: json['text'] as String?,
      matches:
          (json['matches'] as List<dynamic>?)
              ?.map((e) => Match.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'matches': matches?.map((e) => e.toJson()).toList()};
  }
}
