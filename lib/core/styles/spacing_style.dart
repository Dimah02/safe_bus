import 'package:flutter/material.dart';
import 'package:safe_bus/core/styles/sizes.dart';

class KSpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight =
      EdgeInsetsDirectional.only(
        top: KSizes.appBarHeight,
        bottom: KSizes.defaultSpace,
        start: KSizes.defaultSpace,
        end: KSizes.defaultSpace,
      );
  static const EdgeInsetsGeometry paddingNoTop = EdgeInsetsDirectional.only(
    bottom: KSizes.defaultSpace,
    start: KSizes.defaultSpace,
    end: KSizes.defaultSpace,
  );
}
