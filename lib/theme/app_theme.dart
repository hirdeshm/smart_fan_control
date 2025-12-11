import 'package:flutter/material.dart';

class AppTheme {
  // LIGHT THEME
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.amber,        // 💛 Yellow theme
      brightness: Brightness.light,
    ),

    scaffoldBackgroundColor: Colors.grey.shade100,
  );

  // DARK THEME
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.amber,        // 💛 Yellow in Dark Mode
      brightness: Brightness.dark,
    ),

    scaffoldBackgroundColor: Colors.black,
  );
}
