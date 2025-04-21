import 'package:flutter/material.dart';
import 'package:safe_bus/core/styles/colors.dart';

class KTextFieldTheme {
  KTextFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,

    prefixIconColor: KColors.textFieldHintColor,
    suffixIconColor: KColors.textFieldHintColor,
    labelStyle: const TextStyle().copyWith(
      fontSize: 12,
      color: KColors.textFieldLable,
    ),
    hintStyle: const TextStyle().copyWith(
      fontSize: 12,
      color: KColors.textFieldHintColor,
    ),
    errorStyle: const TextStyle().copyWith(
      fontSize: 12,
      fontStyle: FontStyle.normal,
    ),
    floatingLabelStyle: const TextStyle().copyWith(
      color: KColors.textFieldLable,
    ),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(width: 1, color: KColors.textFieldStrok),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(width: 1, color: KColors.textFieldStrok),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(width: 1, color: KColors.textFieldStrok),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(width: 1, color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(width: 2, color: Colors.orange),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    labelStyle: const TextStyle().copyWith(fontSize: 12, color: Colors.white),
    hintStyle: const TextStyle().copyWith(fontSize: 12, color: Colors.white),
    errorStyle: const TextStyle().copyWith(
      fontSize: 12,
      fontStyle: FontStyle.normal,
    ),
    floatingLabelStyle: const TextStyle().copyWith(color: Colors.black),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: Colors.grey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: Colors.grey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: Colors.white),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 2, color: Colors.orange),
    ),
  );
}
