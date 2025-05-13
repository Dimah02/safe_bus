import 'result.dart';

class HereApiModel {
  List<Result>? results;
  List<dynamic>? errors;
  String? processingTimeDesc;
  String? responseCode;
  dynamic warnings;
  String? requestId;

  HereApiModel({
    this.results,
    this.errors,
    this.processingTimeDesc,
    this.responseCode,
    this.warnings,
    this.requestId,
  });

  factory HereApiModel.fromJson(Map<String, dynamic> json) {
    return HereApiModel(
      results:
          (json['results'] as List<dynamic>?)
              ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
              .toList(),
      errors: json['errors'] as List<dynamic>?,
      processingTimeDesc: json['processingTimeDesc'] as String?,
      responseCode: json['responseCode'] as String?,
      warnings: json['warnings'] as dynamic,
      requestId: json['requestId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'results': results?.map((e) => e.toJson()).toList(),
      'errors': errors,
      'processingTimeDesc': processingTimeDesc,
      'responseCode': responseCode,
      'warnings': warnings,
      'requestId': requestId,
    };
  }
}
