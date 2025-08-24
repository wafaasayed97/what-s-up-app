import 'package:flutter/material.dart';
import '/core/constants/strings.dart';
import '/core/theme/dark_colors.dart';

final ColorScheme darkColorScheme = ColorScheme(
  primary: AppDarkColors.primary,

  // primaryVariant: Colors.blueAccent,
  secondary: Colors.green,
  // secondaryVariant: Colors.greenAccent,
  surface: Colors.black,
  onSurface: Colors.white,
  surfaceContainerHighest: Colors.white,
  error: Color(0xFFEC221F),
  onPrimary: Colors.white,
  onSecondary: Colors.black,
  onError: Colors.white,
  brightness: Brightness.dark,
  // More colors
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme: darkColorScheme,
  useMaterial3: true,
  fontFamily: AppStrings.fontFamily,
  hintColor: Colors.black,
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Colors.white),
    fillColor: Colors.black,
  ),
);
