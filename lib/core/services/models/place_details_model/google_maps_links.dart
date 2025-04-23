class GoogleMapsLinks {
  String? directionsUri;
  String? placeUri;
  String? writeAReviewUri;
  String? reviewsUri;
  String? photosUri;

  GoogleMapsLinks({
    this.directionsUri,
    this.placeUri,
    this.writeAReviewUri,
    this.reviewsUri,
    this.photosUri,
  });

  factory GoogleMapsLinks.fromJson(Map<String, dynamic> json) {
    return GoogleMapsLinks(
      directionsUri: json['directionsUri'] as String?,
      placeUri: json['placeUri'] as String?,
      writeAReviewUri: json['writeAReviewUri'] as String?,
      reviewsUri: json['reviewsUri'] as String?,
      photosUri: json['photosUri'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'directionsUri': directionsUri,
      'placeUri': placeUri,
      'writeAReviewUri': writeAReviewUri,
      'reviewsUri': reviewsUri,
      'photosUri': photosUri,
    };
  }
}
