import 'package:flutter/material.dart';
import 'package:safe_bus/features/driver/dashboard/data/models/driver_home/trip.dart';
import 'package:safe_bus/features/driver/map/presentation/views/widgets/children_list_view.dart';
import 'package:safe_bus/features/driver/map/presentation/views/widgets/custom_driver_map.dart';

class DriverMapScreen extends StatelessWidget {
  const DriverMapScreen({super.key, required this.trip});
  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Stack(
        children: [
          LayoutBuilder(
            builder:
                (context, constraints) => SizedBox(
                  height:
                      constraints.maxHeight - (constraints.maxHeight * 0.25),
                  child: CustomDriverMap(
                    busRouteId: trip.busRouteId!,
                    authToken: "token",
                  ),
                ),
          ),

          DraggableScrollableSheet(
            initialChildSize: 0.25,
            minChildSize: 0.25,
            maxChildSize: 0.7,
            builder: (context, controller) {
              return ChildrenListView(controller: controller);
            },
          ),
        ],
      ),
    );
  }
}
