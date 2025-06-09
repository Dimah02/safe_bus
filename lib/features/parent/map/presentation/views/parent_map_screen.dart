import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safe_bus/features/parent/dashboard/data/models/studentandbusroute.dart';
import 'package:safe_bus/features/parent/map/presentation/managers/cubit/map_cubit.dart';
import 'package:safe_bus/features/parent/map/presentation/managers/cubit/student_route_cubit.dart';
import 'package:safe_bus/features/parent/map/presentation/views/widgets/custome_draggable_sheet.dart';

class ParentMapScreen extends StatelessWidget {
  const ParentMapScreen({super.key, required this.studentAndBusRoute});
  final Studentandbusroute studentAndBusRoute;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create:
              (context) =>
                  MapCubit(studentAndBusRoute.studnetroute.busRouteId!),
        ),
        BlocProvider(
          lazy: false,
          create:
              (context) =>
                  StudentRouteCubit()..getStudentRoute(
                    studentId: studentAndBusRoute.studentId,
                    isMorning: studentAndBusRoute.isMorning,
                  ),
        ),
      ],
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(),
        body: Stack(
          children: [
            _MapView(),

            CustomeDraggableSheet(studentAndBusRoute: studentAndBusRoute),
          ],
        ),
      ),
    );
  }
}

class _MapView extends StatelessWidget {
  const _MapView();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:
          (context, constraints) => SizedBox(
            height: constraints.maxHeight - (constraints.maxHeight * 0.25),
            child: GoogleMap(
              zoomControlsEnabled: false,
              initialCameraPosition:
                  BlocProvider.of<MapCubit>(context).initialCameraPosition,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              markers: BlocProvider.of<MapCubit>(context).markers,
              onMapCreated: BlocProvider.of<MapCubit>(context).onMapCreated,
            ),
          ),
    );
  }
}
