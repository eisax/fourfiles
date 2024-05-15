import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
    fontFamily: 'Roboto',
    primaryColor: const Color(0xFF7ED957),
    secondaryHeaderColor: const Color(0xFFbfdeff),
    disabledColor: const Color(0xffa2a7ad),
    brightness: Brightness.dark,
    hintColor: const Color(0xFFbebebe),
    shadowColor: Colors.black.withOpacity(0.4),
    cardColor: const Color(0xFF334257).withOpacity(0.27),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: Color(0xFFe4e8ef)),
      titleLarge: TextStyle(color: Color(0xFF8e9fb9)),
      titleSmall: TextStyle(color: Color(0xFFe4e8ef)),
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: const Color(0xFFcda335))),
    appBarTheme: const AppBarTheme(backgroundColor: Color(0x4D334257)),
    colorScheme: const ColorScheme.dark(
            primary: Color(0xFFcda335), secondary: Color(0xFFcda335))
        .copyWith(background: const Color(0xFF212326))
        .copyWith(error: const Color(0xFFdd3135)));
