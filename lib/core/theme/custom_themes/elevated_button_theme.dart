import 'package:flutter/material.dart';
import 'package:safe_bus/core/styles/colors.dart' show KColors;

class KElevatedButtonTheme {
  KElevatedButtonTheme._();
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: KColors.greenSecondary,
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: const BorderSide(color: KColors.greenSecondary),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      textStyle: const TextStyle(
        fontSize: 16,
        color: KColors.white,
        fontWeight: FontWeight.w700,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
    ),
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: KColors.greenPrimary,
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: const BorderSide(color: KColors.greenPrimary),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
