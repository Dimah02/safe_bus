import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:safe_bus/features/driver/map/presentation/managers/cubit/driver_map_cubit.dart';

class CustomDriverMap extends StatefulWidget {
  const CustomDriverMap({super.key});

  @override
  State<CustomDriverMap> createState() => _CustomDriverMapState();
}

class _CustomDriverMapState extends State<CustomDriverMap> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverMapCubit, DriverMapState>(
      listener: (context, state) async {
        if (state is DriverMapFailure) {
          print(state.errMessage);
        }
        if (state is DriverMapRouteFailure) {
          print(state.errMessage);
        }
        if (state is DriverMapSuccess || state is DriverMapRouteSuccess) {
          setState(() {});
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
    );
  }
}
