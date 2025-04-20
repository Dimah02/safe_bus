import 'package:flutter/material.dart';
import 'package:safe_bus/core/styles/colors.dart';

class KDropdownMenuTheme {
  KDropdownMenuTheme._();

  static DropdownMenuThemeData lightdropDownTheme = DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      errorMaxLines: 3,
      prefixIconColor: KColors.greenPrimary,
      suffixIconColor: KColors.greenPrimary,
      labelStyle: const TextStyle().copyWith(
        fontSize: 12,
        color: KColors.greenPrimary,
      ),
      hintStyle: const TextStyle().copyWith(
        fontSize: 12,
        color: KColors.greenSecondary,
      ),
      errorStyle: const TextStyle().copyWith(
        fontSize: 12,
        fontStyle: FontStyle.normal,
      ),
      floatingLabelStyle: const TextStyle().copyWith(
        color: KColors.greenPrimary,
      ),
      border: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(width: 1, color: KColors.greenPrimary),
      ),
      enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(width: 1, color: KColors.greenPrimary),
      ),
      focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(width: 1, color: Colors.black12),
      ),
      errorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(width: 1, color: Colors.red),
      ),
      focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(width: 2, color: Colors.orange),
      ),
    ),
  );
}
