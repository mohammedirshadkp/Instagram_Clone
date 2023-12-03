import 'package:flutter/material.dart';

class Pallete {
  static const primaryColor = Color.fromRGBO(250, 250, 250, 1);
  static const secondaryColor = Color.fromRGBO(38, 38, 38, 1);
  static const darkModeColor = Colors.black;

  //light mode
  static var lightModeAppTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: primaryColor,
    cardColor: primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      titleTextStyle: TextStyle(
          color: secondaryColor, fontWeight: FontWeight.bold, fontSize: 16),
      iconTheme: IconThemeData(
        color: secondaryColor,
      ),
    ),
    iconTheme: const IconThemeData(color: secondaryColor),
    drawerTheme: const DrawerThemeData(
      backgroundColor: primaryColor,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: primaryColor,
    ),
    listTileTheme: const ListTileThemeData(
      textColor: secondaryColor,
      iconColor: secondaryColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: primaryColor,
      selectedIconTheme: IconThemeData(color: secondaryColor),
      unselectedIconTheme: IconThemeData(color: secondaryColor),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: secondaryColor),
      bodySmall: TextStyle(color: secondaryColor),
      bodyMedium: TextStyle(color: secondaryColor),
      titleSmall: TextStyle(color: secondaryColor),
      titleLarge: TextStyle(color: secondaryColor),
    ),
    primaryColor: primaryColor,
  );

  //Dark mode

  static var darkModeAppTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: darkModeColor,
    cardColor: darkModeColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: darkModeColor,
      elevation: 0,
      titleTextStyle: TextStyle(
          color: primaryColor, fontWeight: FontWeight.bold, fontSize: 16),
      iconTheme: IconThemeData(
        color: primaryColor,
      ),
    ),
    iconTheme: const IconThemeData(color: primaryColor),
    drawerTheme: const DrawerThemeData(
      backgroundColor: darkModeColor,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: primaryColor),
      bodySmall: TextStyle(color: primaryColor),
      bodyMedium: TextStyle(color: primaryColor),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: darkModeColor,
      selectedIconTheme: IconThemeData(color: primaryColor),
      unselectedIconTheme: IconThemeData(color: primaryColor),
    ),
    primaryColor: darkModeColor,
  );
}
