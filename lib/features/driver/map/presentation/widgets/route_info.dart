import 'package:flutter/widgets.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/styles/sizes.dart';

class RouteInfo extends StatelessWidget {
  const RouteInfo({super.key, required this.title, required this.data});
  final String title, data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: KSizes.fonstSizexSm,
            color: KColors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          data,
          style: TextStyle(
            fontSize: KSizes.fonstSizeSm,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
