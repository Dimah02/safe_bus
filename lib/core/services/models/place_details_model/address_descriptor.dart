import 'area.dart';
import 'landmark.dart';

class AddressDescriptor {
  List<Landmark>? landmarks;
  List<Area>? areas;

  AddressDescriptor({this.landmarks, this.areas});

  factory AddressDescriptor.fromJson(Map<String, dynamic> json) {
    return AddressDescriptor(
      landmarks:
          (json['landmarks'] as List<dynamic>?)
              ?.map((e) => Landmark.fromJson(e as Map<String, dynamic>))
              .toList(),
      areas:
          (json['areas'] as List<dynamic>?)
              ?.map((e) => Area.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'landmarks': landmarks?.map((e) => e.toJson()).toList(),
      'areas': areas?.map((e) => e.toJson()).toList(),
    };
  }
}
