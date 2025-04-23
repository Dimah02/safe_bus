class AuthorAttribution {
  String? displayName;
  String? uri;
  String? photoUri;

  AuthorAttribution({this.displayName, this.uri, this.photoUri});

  factory AuthorAttribution.fromJson(Map<String, dynamic> json) {
    return AuthorAttribution(
      displayName: json['displayName'] as String?,
      uri: json['uri'] as String?,
      photoUri: json['photoUri'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'displayName': displayName, 'uri': uri, 'photoUri': photoUri};
  }
}
