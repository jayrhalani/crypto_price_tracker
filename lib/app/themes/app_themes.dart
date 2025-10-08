import 'package:flutter/material.dart';

enum AppTheme { system, light, dark }

class AppThemeManager {
  static ThemeData get lightTheme => ThemeData.light().copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    ),
  );

  static ThemeData get darkTheme => ThemeData.dark().copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ),
  );

  static ThemeMode getThemeMode(AppTheme theme) {
    switch (theme) {
      case AppTheme.light:
        return ThemeMode.light;
      case AppTheme.dark:
        return ThemeMode.dark;
      case AppTheme.system:
      return ThemeMode.system;
    }
  }
}