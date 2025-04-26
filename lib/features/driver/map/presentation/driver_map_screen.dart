import 'package:flutter/material.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/styles/image_strings.dart';
import 'package:safe_bus/core/styles/sizes.dart';
import 'package:safe_bus/features/driver/map/presentation/widgets/busroute_listview_header.dart';
import 'package:safe_bus/features/driver/map/presentation/widgets/custom_google_map.dart';

class DriverMapScreen extends StatelessWidget {
  const DriverMapScreen({super.key});

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
                  child: CustomGoogleMap(),
                ),
          ),

          DraggableScrollableSheet(
            initialChildSize: 0.25,
            minChildSize: 0.25,
            maxChildSize: 0.7,
            builder: (context, controller) {
              return Container(
                decoration: BoxDecoration(color: KColors.white),
                child: ListView.builder(
                  padding: EdgeInsets.all(KSizes.md),
                  physics: ClampingScrollPhysics(),
                  controller: controller,
                  itemCount: 5 + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return BusRouteListViewHeader(
                        zoneName: "Bus 01 Zoned Route",
                        cityName: "Amman, Shafa Bdran",
                        time: "1 Hour and 30 Minutes",
                        distance: "9 KM",
                      );
                    }
                    index--;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 6,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: KColors.grey, width: 2),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(fontSize: 8),
                            ),
                          ),
                          SizedBox(width: KSizes.sm),
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage(KImage.child),
                          ),
                          SizedBox(width: KSizes.sm),
                          Text(
                            "Farah Abdullah",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(width: KSizes.lg),
                          Text(
                            "Present",
                            style: TextStyle(color: KColors.greenSecondary),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
