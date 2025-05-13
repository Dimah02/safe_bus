import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:safe_bus/core/services/models/location_info/location_info_model.dart';
import 'package:safe_bus/core/services/models/routes_model/intermediates.dart';
import 'package:safe_bus/core/services/models/routes_model/routes_model.dart';

class RoutesService {
  final String _baseURL =
      "https://routes.googleapis.com/directions/v2:computeRoutes";
  Future<RoutesModel> fetchRoutes({
    required LocationInfoModel origin,
    required LocationInfoModel destination,
    required Intermediates intermediates,
  }) async {
    Map<String, String> headers = {};
    headers['Content-Type'] = 'application/json';
    headers['X-Goog-Api-Key'] = dotenv.env["APIKEY"] ?? '';
    headers['X-Goog-FieldMask'] =
        "routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline";

    var response = await http.post(
      Uri.parse(_baseURL),
      headers: headers,
      body: json.encode({
        "origin": origin.toJson(),
        "destination": destination.toJson(),
        "intermediates": intermediates.toJson(),
        "travelMode": "DRIVE",
        "routingPreference": "TRAFFIC_AWARE",
        "computeAlternativeRoutes": false,
        "routeModifiers": {
          "avoidTolls": false,
          "avoidHighways": false,
          "avoidFerries": false,
        },
        "languageCode": "en-US",
        "units": "IMPERIAL",
      }),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return RoutesModel.fromJson(data);
    } else {
      throw Exception(
        'Failed to get Routes: ${response.statusCode} - ${response.body}',
      );
    }
  }
}
