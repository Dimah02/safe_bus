import 'author_attribution.dart';
import 'original_text.dart';
import 'text.dart';

class Review {
  String? name;
  String? relativePublishTimeDescription;
  int? rating;
  Text? text;
  OriginalText? originalText;
  AuthorAttribution? authorAttribution;
  DateTime? publishTime;
  String? flagContentUri;
  String? googleMapsUri;

  Review({
    this.name,
    this.relativePublishTimeDescription,
    this.rating,
    this.text,
    this.originalText,
    this.authorAttribution,
    this.publishTime,
    this.flagContentUri,
    this.googleMapsUri,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      name: json['name'] as String?,
      relativePublishTimeDescription:
          json['relativePublishTimeDescription'] as String?,
      rating: json['rating'] as int?,
      text:
          json['text'] == null
              ? null
              : Text.fromJson(json['text'] as Map<String, dynamic>),
      originalText:
          json['originalText'] == null
              ? null
              : OriginalText.fromJson(
                json['originalText'] as Map<String, dynamic>,
              ),
      authorAttribution:
          json['authorAttribution'] == null
              ? null
              : AuthorAttribution.fromJson(
                json['authorAttribution'] as Map<String, dynamic>,
              ),
      publishTime:
          json['publishTime'] == null
              ? null
              : DateTime.parse(json['publishTime'] as String),
      flagContentUri: json['flagContentUri'] as String?,
      googleMapsUri: json['googleMapsUri'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'relativePublishTimeDescription': relativePublishTimeDescription,
      'rating': rating,
      'text': text?.toJson(),
      'originalText': originalText?.toJson(),
      'authorAttribution': authorAttribution?.toJson(),
      'publishTime': publishTime?.toIso8601String(),
      'flagContentUri': flagContentUri,
      'googleMapsUri': googleMapsUri,
    };
  }
}
