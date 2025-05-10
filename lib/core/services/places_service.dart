import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:http/http.dart" as http;
import 'package:safe_bus/core/services/models/place_auto_complete_model/place_auto_complete_model.dart';
import 'package:safe_bus/core/services/models/place_details_model/place_details_model.dart';

class PlacesService {
  final String _baseURL = "https://places.googleapis.com/v1/places";
  Future<List<PlaceAutoCompleteModel>> getPredictions({
    required String input,
    required String token,
  }) async {
    Map<String, String> headers = {};
    headers['Content-Type'] = 'application/json';
    headers['X-Goog-Api-Key'] = dotenv.env["APIKEY"] ?? '';

    var response = await http.post(
      Uri.parse("$_baseURL:autocomplete?sessionToken=$token"),
      headers: headers,
      body: json.encode({"input": input}),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<PlaceAutoCompleteModel> places = [];
      for (var place in data['suggestions']) {
        places.add(PlaceAutoCompleteModel.fromJson(place));
      }
      return places;
    } else {
      throw Exception(
        'Failed to get predictions: ${response.statusCode} - ${response.body}',
      );
    }
  }

  Future<PlaceDetailsModel> getPlaceDetails({
    required String placeId,
    required String token,
  }) async {
    Map<String, String> headers = {};
    headers['Accept'] = 'application/json';
    headers['X-Goog-Api-Key'] = dotenv.env["APIKEY"] ?? '';
    headers['X-Goog-FieldMask'] = "displayName,formattedAddress,location";

    var response = await http.get(
      Uri.parse("$_baseURL/$placeId?sessionToken=$token"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return PlaceDetailsModel.fromJson(data);
    } else {
      throw Exception(
        'Failed to get place Details: ${response.statusCode} - ${response.body}',
      );
    }
  }
}
