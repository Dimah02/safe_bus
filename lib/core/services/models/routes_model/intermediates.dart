import 'package:safe_bus/core/services/models/location_info/location_info_model.dart';

class Intermediates {
  final List<LocationInfoModel> intermediates;

  Intermediates({required this.intermediates});

  factory Intermediates.fromJson(Map<String, dynamic> json) {
    var intermediatesList = json['intermediates'] as List;
    List<LocationInfoModel> intermediates =
        intermediatesList
            .map((item) => LocationInfoModel.fromJson(item))
            .toList();

    return Intermediates(intermediates: intermediates);
  }

  List<dynamic> toJson() {
    return intermediates.map((e) => e.toJson()).toList();
  }
}
