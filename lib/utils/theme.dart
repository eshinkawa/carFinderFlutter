import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color primary = Color(0xff5b305a);
  static const Color onPrimary = Colors.white;
  static const Color surface = Color(0xff1a1a2e);
  static const Color onSurface = Colors.white;
  static const Color secondary = Color(0xff6991c7);
  static const Color tertiary = Color(0xffb75d69);
  static const Color error = Color(0xffb33951);

  static final ColorScheme _colorScheme = ColorScheme.dark(
    primary: primary,
    onPrimary: onPrimary,
    secondary: secondary,
    onSecondary: Colors.white,
    surface: surface,
    onSurface: onSurface,
    tertiary: tertiary,
    onTertiary: Colors.white,
    error: error,
    onError: Colors.white,
  );

  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        colorScheme: _colorScheme,
        scaffoldBackgroundColor: surface,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: onSurface,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: surface,
          indicatorColor: primary.withAlpha(80),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        cardTheme: CardThemeData(
          color: primary.withAlpha(80),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        dialogTheme: DialogThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: primary.withAlpha(80),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      );
}
