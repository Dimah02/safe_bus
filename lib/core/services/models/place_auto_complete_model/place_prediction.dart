import 'structured_format.dart';
import 'text.dart';

class PlacePrediction {
  String? place;
  String? placeId;
  Text? text;
  StructuredFormat? structuredFormat;
  List<String>? types;

  PlacePrediction({
    this.place,
    this.placeId,
    this.text,
    this.structuredFormat,
    this.types,
  });

  factory PlacePrediction.fromJson(Map<String, dynamic> json) {
    return PlacePrediction(
      place: json['place'] as String?,
      placeId: json['placeId'] as String?,
      text:
          json['text'] == null
              ? null
              : Text.fromJson(json['text'] as Map<String, dynamic>),
      structuredFormat:
          json['structuredFormat'] == null
              ? null
              : StructuredFormat.fromJson(
                json['structuredFormat'] as Map<String, dynamic>,
              ),
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'place': place,
      'placeId': placeId,
      'text': text?.toJson(),
      'structuredFormat': structuredFormat?.toJson(),
      'types': types,
    };
  }
}
