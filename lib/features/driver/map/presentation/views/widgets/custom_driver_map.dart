import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:safe_bus/core/services/signal_r_service.dart';
import 'package:safe_bus/features/driver/map/presentation/managers/cubit/driver_map_cubit.dart';

class CustomDriverMap extends StatefulWidget {
  final int busRouteId;
  final String authToken;
  const CustomDriverMap({
    super.key,
    required this.busRouteId,
    required this.authToken,
  });

  @override
  State<CustomDriverMap> createState() => _CustomDriverMapState();
}

class _CustomDriverMapState extends State<CustomDriverMap> {
  late final SignalRService _signalRService;
  late final DriverMapCubit _cubit;
  @override
  void initState() {
    super.initState();
    _signalRService = SignalRService(
      baseUrl: 'https://your-api-url.com', // Replace with your API URL
      hubName: 'busTrackingHub',
    );
    _cubit = DriverMapCubit(
      busRouteId: widget.busRouteId,
      signalRService: _signalRService,
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: Stack(
        children: [
          BlocConsumer<DriverMapCubit, DriverMapState>(
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
                    BlocProvider.of<DriverMapCubit>(
                      context,
                    ).initialCameraPosition,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                markers: BlocProvider.of<DriverMapCubit>(context).markers,
                polylines: BlocProvider.of<DriverMapCubit>(context).polylines,
                onMapCreated:
                    BlocProvider.of<DriverMapCubit>(context).onMapCreated,
              );
            },
          ),
        ],
      ),
    );
  }
}
