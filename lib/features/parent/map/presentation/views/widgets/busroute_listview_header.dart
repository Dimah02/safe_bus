import 'package:flutter/material.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/styles/sizes.dart';
import 'package:safe_bus/features/driver/map/presentation/views/widgets/route_info.dart';

class BusRouteListViewHeader extends StatelessWidget {
  const BusRouteListViewHeader({
    super.key,
    required this.zoneName,
    required this.cityName,
    required this.time,
    required this.distance,
  });
  final String zoneName, cityName, time, distance;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: SizedBox(
            width: KSizes.xl,
            child: Divider(thickness: KSizes.xs, height: 0),
          ),
        ),
        SizedBox(height: KSizes.md),
        Text(
          zoneName,
          style: TextStyle(
            fontSize: KSizes.fonstSizexLg,
            fontWeight: FontWeight.w700,
          ),
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(
              color: KColors.fontColor,
              fontSize: KSizes.fonstSizeLg,
            ),
            children: [
              TextSpan(text: "City · "),
              TextSpan(
                text: cityName,
                style: TextStyle(color: KColors.fontBlue),
              ),
            ],
          ),
        ),
        SizedBox(height: KSizes.sm),
        if (distance.isNotEmpty)
          Column(
            children: [
              SizedBox(width: double.infinity, child: Divider(thickness: 1)),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: RouteInfo(
                      title: "ESTIMATED TIME FOR THE TRIP",
                      data: time,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    width: 50,
                    child: VerticalDivider(thickness: 1, width: 4),
                  ),
                  Expanded(child: RouteInfo(title: "DISTANCE", data: distance)),
                ],
              ),
              SizedBox(width: double.infinity, child: Divider(thickness: 1)),
            ],
          ),
      ],
    );
  }
}
