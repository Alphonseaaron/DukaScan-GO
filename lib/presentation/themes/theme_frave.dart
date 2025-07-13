import 'package:flutter/material.dart';
import 'package:dukascan_go/presentation/themes/colors_frave.dart';

class Themes {
  static final lightTheme = ThemeData(
    primaryColor: ColorsFrave.primaryColor,
    scaffoldBackgroundColor: ColorsFrave.backgroundColor,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      color: ColorsFrave.primaryColor,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    colorScheme: ColorScheme.light(
      primary: ColorsFrave.primaryColor,
      secondary: ColorsFrave.secundaryColor,
      surface: ColorsFrave.backgroundColor,
      error: ColorsFrave.error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black,
      onError: Colors.white,
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: ColorsFrave.primaryColorDark,
    scaffoldBackgroundColor: ColorsFrave.backgroundColorDark,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      color: ColorsFrave.primaryColorDark,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    colorScheme: ColorScheme.dark(
      primary: ColorsFrave.primaryColorDark,
      secondary: ColorsFrave.secundaryColorDark,
      surface: ColorsFrave.backgroundColorDark,
      error: ColorsFrave.error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onError: Colors.white,
    ),
  );
}
