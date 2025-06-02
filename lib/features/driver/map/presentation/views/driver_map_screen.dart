import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/features/driver/dashboard/data/models/driver_home/trip.dart';
import 'package:safe_bus/features/driver/map/presentation/managers/cubit/driver_map_cubit.dart';
import 'package:safe_bus/features/driver/map/presentation/managers/cubit/real_time_location_cubit.dart';
import 'package:safe_bus/features/driver/map/presentation/managers/cubit/students_cubit.dart';
import 'package:safe_bus/features/driver/map/presentation/views/widgets/busroute_listview_header.dart';
import 'package:safe_bus/features/driver/map/presentation/views/widgets/children_list_view.dart';

class DriverMapScreen extends StatelessWidget {
  const DriverMapScreen({super.key, required this.trip});
  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) {
            return RealTimeLocationCubit(trip.busRouteId!);
          },
        ),

        BlocProvider(
          create: (context) {
            return StudentsCubit(busRouteId: trip.busRouteId!);
          },
        ),
        BlocProvider(
          lazy: false,
          create:
              (context) => DriverMapCubit(
                trip: trip,
                currentDestination: LatLng(
                  trip.schoolLatitude,
                  trip.schoolLongitude,
                ),
              ),
        ),
      ],
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(),
        body: Stack(
          children: [const _MapView(), _StudentsDraggableSheet(trip)],
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
            child: BlocBuilder<DriverMapCubit, DriverMapState>(
              builder: (context, state) {
                if (state is DriverMapFailure) {
                  print(state.errMessage);
                }
                return GoogleMap(
                  zoomControlsEnabled: false,
                  initialCameraPosition:
                      context.read<DriverMapCubit>().initialCameraPosition,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  markers: context.read<DriverMapCubit>().markers,
                  polylines: context.read<DriverMapCubit>().polylines,
                  onMapCreated: context.read<DriverMapCubit>().onMapCreated,
                );
              },
            ),
          ),
    );
  }
}

class _StudentsDraggableSheet extends StatelessWidget {
  const _StudentsDraggableSheet(this.trip);
  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentsCubit, StudentsState>(
      builder: (context, state) {
        return DraggableScrollableSheet(
          initialChildSize: 0.25,
          minChildSize: 0.25,
          maxChildSize: 0.7,
          builder: (context, controller) {
            if (state is StudentsSuccess) {
              return ChildrenListView(
                controller: controller,
                students: state.students,
                header: BlocBuilder<DriverMapCubit, DriverMapState>(
                  builder: (context, state) {
                    return BusRouteListViewHeader(
                      zoneName: "Bus ${trip.busId} Zoned Route",
                      cityName: "Zone ${trip.zoneName ?? ''}",
                      time: context.read<DriverMapCubit>().duration,
                      distance: context.read<DriverMapCubit>().distanceMeters,
                    );
                  },
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(color: KColors.greenPrimary),
            );
          },
        );
      },
    );
  }
}
