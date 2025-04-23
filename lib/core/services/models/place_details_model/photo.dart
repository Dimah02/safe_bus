import 'author_attribution.dart';

class Photo {
  String? name;
  int? widthPx;
  int? heightPx;
  List<AuthorAttribution>? authorAttributions;
  String? flagContentUri;
  String? googleMapsUri;

  Photo({
    this.name,
    this.widthPx,
    this.heightPx,
    this.authorAttributions,
    this.flagContentUri,
    this.googleMapsUri,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      name: json['name'] as String?,
      widthPx: json['widthPx'] as int?,
      heightPx: json['heightPx'] as int?,
      authorAttributions:
          (json['authorAttributions'] as List<dynamic>?)
              ?.map(
                (e) => AuthorAttribution.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
      flagContentUri: json['flagContentUri'] as String?,
      googleMapsUri: json['googleMapsUri'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'widthPx': widthPx,
      'heightPx': heightPx,
      'authorAttributions': authorAttributions?.map((e) => e.toJson()).toList(),
      'flagContentUri': flagContentUri,
      'googleMapsUri': googleMapsUri,
    };
  }
}
