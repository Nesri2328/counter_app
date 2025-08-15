// lib/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static Color primaryColor = Color(0xFF263238); // Dark Blue-Grey
  static Color accentColor = Color(0xFF00BCD4); // Teal
  static Color correctColor = Color(0xFF4CAF50); // Green
  static Color incorrectColor = Color(0xFFF44336); // Red
  static Color lightTextColor = Colors.white;
  static Color darkTextColor = Colors.black87;
  static Color cardBackgroundColor = Color(
    0xFF37474F,
  ); // Slightly Lighter Blue-Grey
  static Color optionSelectedColor = Color(
    0xFF455A64,
  ); // Even Lighter Blue-Grey
  static Color quizBackgroundColor = Color(0xFF212121); // Dark Background

  static ThemeData darkTheme = ThemeData(
    // Only Dark Theme for Visual Fidelity
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    hintColor: accentColor,
    scaffoldBackgroundColor: quizBackgroundColor, // The Quiz background
    cardColor: cardBackgroundColor,
    textTheme: GoogleFonts.robotoTextTheme(
      ThemeData.dark().textTheme,
    ).apply(bodyColor: lightTextColor, displayColor: lightTextColor),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      titleTextStyle: GoogleFonts.roboto(
        color: lightTextColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: lightTextColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accentColor,
        foregroundColor: darkTextColor,
        textStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    listTileTheme: ListTileThemeData(
      textColor: lightTextColor,
      iconColor: lightTextColor,
    ),
  );

  static Color get correctAnswerColor => correctColor;

  static Color get incorrectAnswerColor => incorrectColor;
}
