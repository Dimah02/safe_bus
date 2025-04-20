import 'package:flutter/material.dart';
import 'package:safe_bus/core/styles/colors.dart' show KColors;

class KOutlinedButtonTheme {
  KOutlinedButtonTheme._();
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: KColors.greenPrimary,
      side: const BorderSide(color: KColors.greenPrimary),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      side: const BorderSide(color: KColors.greenPrimary),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );
}
