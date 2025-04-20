import 'package:flutter/material.dart';
import 'package:safe_bus/core/styles/colors.dart';

class KCheckboxTheme {
  KCheckboxTheme._();
  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return KColors.white;
      } else {
        return KColors.black;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return KColors.greenPrimary;
      } else {
        return Colors.transparent;
      }
    }),
  );
  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return KColors.white;
      } else {
        return KColors.black;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return KColors.greenPrimary;
      } else {
        return Colors.transparent;
      }
    }),
  );
}
