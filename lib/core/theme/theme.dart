import 'package:flutter/material.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/theme/custom_themes/appbar_theme.dart';
import 'package:safe_bus/core/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:safe_bus/core/theme/custom_themes/checkbox_theme.dart';
import 'package:safe_bus/core/theme/custom_themes/chip_theme.dart';
import 'package:safe_bus/core/theme/custom_themes/dropdown_menu_theme.dart';
import 'package:safe_bus/core/theme/custom_themes/elevated_button_theme.dart';
import 'package:safe_bus/core/theme/custom_themes/outlined_button_theme.dart';
import 'package:safe_bus/core/theme/custom_themes/text_field_theme.dart';
import 'package:safe_bus/core/theme/custom_themes/text_theme.dart';

class KAppTheme {
  KAppTheme._();
  static ThemeData lighTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Sofia',
    focusColor: KColors.fontColor,
    brightness: Brightness.light,
    primaryColor: KColors.greenPrimary,
    scaffoldBackgroundColor: Colors.white,
    textTheme: KTextTheme.lightTextTheme,
    elevatedButtonTheme: KElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: KAppbarTheme.lightAppBarTheme,
    bottomSheetTheme: KBottomSheetTheme.lightBottomSheetTheme,
    checkboxTheme: KCheckboxTheme.lightCheckboxTheme,
    chipTheme: KChipTheme.lightChipTheme,
    outlinedButtonTheme: KOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: KTextFieldTheme.lightInputDecorationTheme,
    dropdownMenuTheme: KDropdownMenuTheme.lightdropDownTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: KColors.greenSecondary,
    scaffoldBackgroundColor: KColors.black,
    textTheme: KTextTheme.dartTextTheme,
    elevatedButtonTheme: KElevatedButtonTheme.darkElevatedButtonTheme,
    appBarTheme: KAppbarTheme.darkAppBarTheme,
    bottomSheetTheme: KBottomSheetTheme.darkBottomSheetTheme,
    checkboxTheme: KCheckboxTheme.darkCheckboxTheme,
    chipTheme: KChipTheme.darkChipTheme,
    outlinedButtonTheme: KOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: KTextFieldTheme.darkInputDecorationTheme,
  );
}
