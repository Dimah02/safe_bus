import 'place_prediction.dart';

class PlaceAutoCompleteModel {
  PlacePrediction? placePrediction;

  PlaceAutoCompleteModel({this.placePrediction});

  factory PlaceAutoCompleteModel.fromJson(Map<String, dynamic> json) {
    return PlaceAutoCompleteModel(
      placePrediction:
          json['placePrediction'] == null
              ? null
              : PlacePrediction.fromJson(
                json['placePrediction'] as Map<String, dynamic>,
              ),
    );
  }

  Map<String, dynamic> toJson() {
    return {'placePrediction': placePrediction?.toJson()};
  }
}
