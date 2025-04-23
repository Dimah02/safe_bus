class Match {
  int? endOffset;

  Match({this.endOffset});

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(endOffset: json['endOffset'] as int?);
  }

  Map<String, dynamic> toJson() {
    return {'endOffset': endOffset};
  }
}
