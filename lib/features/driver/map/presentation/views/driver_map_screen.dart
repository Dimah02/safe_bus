import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safe_bus/core/services/signal_r_service.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/features/driver/dashboard/data/models/driver_home/trip.dart';
import 'package:safe_bus/features/driver/map/presentation/managers/cubit/driver_map_cubit.dart';
import 'package:safe_bus/features/driver/map/presentation/managers/cubit/trip_students_cubit.dart';
import 'package:safe_bus/features/driver/map/presentation/views/widgets/busroute_listview_header.dart';
import 'package:safe_bus/features/driver/map/presentation/views/widgets/children_list_view.dart';
import 'package:safe_bus/features/driver/map/presentation/views/widgets/custom_driver_map.dart';

class DriverMapScreen extends StatefulWidget {
  const DriverMapScreen({super.key, required this.trip});
  final Trip trip;

  @override
  State<DriverMapScreen> createState() => _DriverMapScreenState();
}

class _DriverMapScreenState extends State<DriverMapScreen> {
  late final SignalRService _signalRService;
  late final DriverMapCubit _cubit;
  @override
  void initState() {
    super.initState();
    String baseurl = dotenv.env["SOCKETURL"] ?? '';
    _signalRService = SignalRService(
      baseUrl: baseurl,
      hubName: 'busTrackingHub',
    );
    _cubit = DriverMapCubit(
      busRouteId: widget.trip.busRouteId!,
      signalRService: _signalRService,
      currentDestination: LatLng(
        widget.trip.schoolLatitude,
        widget.trip.schoolLongitude,
      ),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  TripStudentsCubit()
                    ..getStudents(busRouteId: widget.trip.busRouteId!),
        ),
        BlocProvider(create: (context) => _cubit),
      ],

      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(),
        body: Stack(
          children: [
            LayoutBuilder(
              builder:
                  (context, constraints) => SizedBox(
                    height:
                        constraints.maxHeight - (constraints.maxHeight * 0.25),
                    child: CustomDriverMap(),
                  ),
            ),

            BlocBuilder<TripStudentsCubit, TripStudentsState>(
              builder: (context, state) {
                if (state is TripStudentsSuccess) {
                  return DraggableScrollableSheet(
                    initialChildSize: 0.25,
                    minChildSize: 0.25,
                    maxChildSize: 0.7,
                    builder: (context, controller) {
                      return ChildrenListView(
                        controller: controller,
                        students: state.students,
                        header: BusRouteListViewHeader(
                          zoneName: "Bus ${widget.trip.busId} Zoned Route",
                          cityName: "${widget.trip.zoneName}",
                          time: "1 Hour and 30 Minutes",
                          distance: "9 KM",
                        ),
                      );
                    },
                  );
                }
                return DraggableScrollableSheet(
                  initialChildSize: 0.25,
                  minChildSize: 0.25,
                  maxChildSize: 0.7,
                  builder: (context, controller) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: KColors.greenPrimary,
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
