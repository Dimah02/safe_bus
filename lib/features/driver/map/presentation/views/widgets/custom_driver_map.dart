import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:safe_bus/features/driver/dashboard/data/models/driver_home/trip.dart';
import 'package:safe_bus/features/driver/map/presentation/managers/cubit/driver_map_cubit.dart';

class CustomDriverMap extends StatelessWidget {
  const CustomDriverMap({super.key, required this.trip});
  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create:
          (context) => DriverMapCubit(
            trip: trip,
            currentDestination: LatLng(
              trip.schoolLatitude,
              trip.schoolLongitude,
            ),
          ),
      child: BlocConsumer<DriverMapCubit, DriverMapState>(
        listener: (context, state) async {
          if (state is DriverMapFailure) {
            print(state.errMessage);
          }
        },
        builder: (context, state) {
          return GoogleMap(
            zoomControlsEnabled: false,
            initialCameraPosition:
                BlocProvider.of<DriverMapCubit>(context).initialCameraPosition,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            markers: BlocProvider.of<DriverMapCubit>(context).markers,
            polylines: BlocProvider.of<DriverMapCubit>(context).polylines,
            onMapCreated: BlocProvider.of<DriverMapCubit>(context).onMapCreated,
          );
        },
      ),
    );
  }
}
