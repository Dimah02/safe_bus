import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:safe_bus/core/services/signal_r_service.dart';
import 'package:safe_bus/features/parent/map/presentation/managers/cubit/map_cubit.dart';

class CustomParentMap extends StatefulWidget {
  final int busRouteId;
  final String authToken;
  const CustomParentMap({
    super.key,
    required this.busRouteId,
    required this.authToken,
  });

  @override
  State<CustomParentMap> createState() => _CustomParentMapState();
}

class _CustomParentMapState extends State<CustomParentMap> {
  late final SignalRService _signalRService;
  late final MapCubit _cubit;
  @override
  void initState() {
    super.initState();
    String baseurl = dotenv.env["BASEURL"] ?? '';
    _signalRService = SignalRService(
      baseUrl: baseurl,
      hubName: 'busTrackingHub',
      token: widget.authToken,
    );
    _cubit = MapCubit(widget.busRouteId, _signalRService);
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
          BlocConsumer<MapCubit, MapState>(
            listener: (context, state) async {
              if (state is MapFailure) {
                print(state.errorMessage);
              }
              if (state is MapSuccess) {
                setState(() {});
              }
            },
            builder: (context, state) {
              return GoogleMap(
                zoomControlsEnabled: false,
                initialCameraPosition:
                    BlocProvider.of<MapCubit>(context).initialCameraPosition,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                markers: BlocProvider.of<MapCubit>(context).markers,
                onMapCreated: BlocProvider.of<MapCubit>(context).onMapCreated,
              );
            },
          ),
        ],
      ),
    );
  }
}
