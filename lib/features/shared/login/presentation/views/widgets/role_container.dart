import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/styles/sizes.dart';

class RoleContainer extends StatelessWidget {
  const RoleContainer({
    super.key,
    required this.name,
    required this.image,
    required this.bgColor,
  });
  final String name;
  final String image;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: (MediaQuery.of(context).size.width - 48 - 24) / 2,

      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 8,
            child: Text(
              name,
              style: TextStyle(
                color: KColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 8,
            child: Icon(
              FontAwesomeIcons.arrowRight,
              color: KColors.white,
              size: KSizes.iconSm,
            ),
          ),

          Positioned(bottom: 0, right: 14, child: SvgPicture.asset(image)),
        ],
      ),
    );
  }
}
