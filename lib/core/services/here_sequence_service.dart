import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:http/http.dart" as http;
import 'package:safe_bus/core/services/models/location_info/lat_lng.dart';
import 'package:safe_bus/core/services/models/place_auto_complete_model/place_auto_complete_model.dart';

class HereSequenceService {
  final String _baseURL =
      "https://wps.hereapi.com/v8/findsequence2?start=31.987444747067833,35.94806691506718&destination1=31.988504869325396,35.944751704926354&destination2=31.986903306510428,35.94822248318058&destination3=31.987071653916818,35.94636639465514&improveFor=time&mode=fastest;car;traffic:enabled&apikey=bdxftxqt06fDZT28N_o3vhR2AHfgH2xOQdWvvNOT530&departure=now";
  Future<List<PlaceAutoCompleteModel>> getPredictions({
    required LatLngModel start,
    required LatLngModel end,
  }) async {
    Map<String, String> headers = {};
    headers['Content-Type'] = 'application/json';
    String apikey = dotenv.env["HEREAPIKEY"] ?? '';
    String startQ = "start=${start.latitude},${start.longitude}";
    String endQ = "start=${end.latitude},${end.longitude}";
    String apikeyQ = "apikey=$apikey";

    var response = await http.post(
      Uri.parse("$_baseURL:autocomplete?sessionToken="),
      headers: headers,
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
}
