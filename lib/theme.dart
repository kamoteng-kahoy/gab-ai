import 'package:flutter/material.dart';
import 'colors.dart'; // Adjust the import according to your project structure

final ThemeData appTheme = ThemeData(
  primaryColor: SystemColors.primaryColor,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(
        color: SystemColors.textColorDarker,
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
      color: SystemColors.textColorDarker,
    ),
  ),
  textTheme: ThemeData.light().textTheme.apply(
    fontFamily: 'Merriweather', 
    bodyColor: SystemColors.textColorDarker,
    displayColor: SystemColors.textColorDarker,
  ).copyWith(
    headlineLarge: const TextStyle(
      fontFamily: 'Merriweather',
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
      color: SystemColors.textColorDarker,
    ),
    headlineMedium: const TextStyle(
      fontFamily: 'Merriweather',
      fontSize: 24.0,
      color: SystemColors.textColorDarker,
    ),
    headlineSmall: const TextStyle(
      fontFamily: 'Merriweather',
      fontSize: 20.0,
      color: SystemColors.textColorDarker,
    ),
    bodyMedium: const TextStyle(
      fontFamily: 'Nunito Sans',
      fontSize: 16.0,
      color: SystemColors.textColorDarker,
    ),// Add other text styles as needed
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: SystemColors.primaryColorDarker,
    ),
  ),
);