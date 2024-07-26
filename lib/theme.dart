import 'package:flutter/material.dart';
import 'colors.dart'; // Adjust the import according to your project structure

final ThemeData appTheme = ThemeData(
  primaryColor: SystemColors.primaryColor,
  hintColor: SystemColors.accentColor,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(
        color: SystemColors.textColor,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(
        color: SystemColors.primaryColorDarker,
        width: 2.0,
      ),
    ),
    labelStyle: const TextStyle(
      color: SystemColors.textColor,
    ),
  ),
  textTheme: ThemeData.light().textTheme.apply(
    fontFamily: 'Merriweather',
    bodyColor: SystemColors.textColor,
    displayColor: SystemColors.textColor,
  ).copyWith(
    headlineLarge: const TextStyle(
      fontFamily: 'Merriweather',
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: SystemColors.textColor,
    ),
    bodyLarge: const TextStyle(
      fontFamily: 'Nunito Sans',
      fontSize: 16.0,
      color: SystemColors.textColor,
    ),
    // Add other text styles as needed
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: SystemColors.primaryColorDarker,
    ),
  ),
);