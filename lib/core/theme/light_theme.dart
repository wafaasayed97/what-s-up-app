import 'package:flutter/material.dart';
import 'package:what_s_up_app/core/extensions/ext.dart';
import '/core/constants/strings.dart';
import '/core/theme/light_colors.dart';

final ColorScheme lightColorScheme = ColorScheme(
  primary: AppLightColors.primary,
  // primaryVariant: Colors.blueAccent,
  secondary: AppLightColors.secondary,
  // secondaryVariant: Colors.greenAccent,
  surface: Colors.white,
  tertiary: Color(0xFF757575),
  onSurface: Colors.black,
  // surfaceContainerHighest: Colors.black,
  error: Color(0xFFEC221F),
  onPrimary: Colors.white,
  onSecondary: Colors.black,
  onError: Color(0xFFEC221F),
  brightness: Brightness.light,

  // More colors
);

final lightTheme = ThemeData(
  brightness: Brightness.light,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme: lightColorScheme,
  useMaterial3: true,
  fontFamily: AppStrings.fontFamily,
  // scaffoldBackgroundColor: Colors.white,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: 36.bRadius,
    ),
    filled: true,
    fillColor: Color(0xFFFAFAFA),
    hintStyle: TextStyle(color: Color(0xFF757575)),
  ),
);
