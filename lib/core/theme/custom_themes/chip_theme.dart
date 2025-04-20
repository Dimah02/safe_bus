import 'package:flutter/material.dart';
import 'package:safe_bus/core/styles/colors.dart' show KColors;

class KChipTheme {
  KChipTheme._();
  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: Colors.grey,
    labelStyle: const TextStyle(color: Colors.black),
    selectedColor: KColors.greenPrimary,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    checkmarkColor: Colors.white,
  );
  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: Colors.grey,
    labelStyle: TextStyle(color: Colors.white),
    selectedColor: KColors.greenPrimary,
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    checkmarkColor: Colors.white,
  );
}
