import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safe_bus/core/services/map_services.dart';

import 'package:safe_bus/core/services/models/place_auto_complete_model/place_auto_complete_model.dart';
import 'package:safe_bus/core/services/models/place_details_model/place_details_model.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({
    super.key,
    required this.places,
    required this.mapServices,
    required this.onPlaceSelect,
    this.token,
  });

  final List<PlaceAutoCompleteModel> places;
  final MapServices mapServices;
  final void Function(PlaceDetailsModel) onPlaceSelect;
  final String? token;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final PlaceAutoCompleteModel place = places[index];
          return ListTile(
            leading: Icon(FontAwesomeIcons.locationPin),
            title: Text(place.placePrediction?.text?.text ?? ""),
            trailing: IconButton(
              onPressed: () async {
                final placeDetails = await mapServices.getPlaceDetails(
                  placeId: places[index].placePrediction!.placeId.toString(),
                  token: token!,
                );

                onPlaceSelect(placeDetails);
              },
              icon: Icon(FontAwesomeIcons.arrowRight),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(height: 0);
        },
        itemCount: places.length,
      ),
    );
  }
}
