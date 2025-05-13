import 'package:flutter/material.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/styles/sizes.dart';
import 'package:safe_bus/features/driver/map/presentation/views/widgets/busroute_listview_header.dart';
import 'package:safe_bus/features/driver/map/presentation/views/widgets/custom_driver_map.dart';

class ParentMapScreen extends StatelessWidget {
  const ParentMapScreen({super.key});

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
                  child: CustomDriverMap(),
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
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BusRouteListViewHeader(
                          zoneName: "Bus 01 Zoned Route",
                          cityName: "Amman, Shafa Bdran",
                          time: "1 Hour and 30 Minutes",
                          distance: "9 KM",
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Pick Up Bus Route",
                          style: TextStyle(
                            fontSize: KSizes.fonstSizeLg,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 16),
                        _from(),
                        SizedBox(height: 24),
                        _to(),
                        SizedBox(height: 24),
                        _reportIssue(),
                      ],
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

  Container _from() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromARGB(40, 118, 118, 128),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("From", style: TextStyle(color: KColors.grey)),
              Text("ZYZ School", style: TextStyle(color: KColors.grey)),
            ],
          ),
          Text("7:00 AM", style: TextStyle(color: KColors.grey)),
        ],
      ),
    );
  }

  Container _to() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: KColors.orangeAccent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("To", style: TextStyle(color: KColors.white)),
              Text("ZYZ Home", style: TextStyle(color: KColors.white)),
            ],
          ),
          Text("7:30 AM", style: TextStyle(color: KColors.white)),
        ],
      ),
    );
  }

  Container _reportIssue() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromARGB(40, 118, 118, 128),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.info, color: KColors.fontBlue),
          SizedBox(width: 16),
          Text("Report An Issue", style: TextStyle(color: KColors.grey)),
        ],
      ),
    );
  }
}
