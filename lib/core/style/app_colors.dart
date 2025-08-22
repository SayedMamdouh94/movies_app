import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary & Secondary
  static const Color kPrimary = Color(0xFF0D2039); // Dark navy blue
  static const Color kPrimary50 = Color(0xFFE2E5EA); // Very light version
  static const Color kPrimary100 = Color(0xFFBCC4D3); // Light version
  static const Color kPrimary200 = Color(0xFF8A9BB0); // Light-medium version
  static const Color kPrimary300 = Color(0xFF5A6E85); // Medium version
  static const Color kPrimary400 = Color(0xFF334455); // Medium-dark version
  static const Color kPrimary500 = Color(0xFF0D2039); // Base primary

  static const Color kSecondary = Color(0xFFFE8F29); // Orange
  static const Color kSecondary50 = Color(0xFFFFF4E8); // Very light orange
  static const Color kSecondary100 = Color(0xFFFFE4C4); // Light orange
  static const Color kSecondary200 = Color(0xFFFFC98A); // Light-medium orange
  static const Color kSecondary300 = Color(0xFFFFAD50); // Medium orange
  static const Color kSecondary400 = Color(0xFFFF9A3D); // Medium-dark orange
  static const Color kSecondary500 = Color(0xFFFE8F29); // Base secondary

  // Supportive Colors
  static const Color kAccent = Color(0xFFFE8F29); // Orange used as accent
  static const Color kError = Color(0xFFDC2626); // Darker, more effective red
  static const Color kSuccess = Color(
    0xFF059669,
  ); // Darker, more effective green
  static const Color kWarning = Color(
    0xFFFFF0CF,
  ); // Optional: Can adjust if needed
  static const Color kInfo = Color(0xFF3498DB); // Optional: Can be muted blue

  // Backgrounds
  static const Color kBackground = Color(0xfff9f7f4);
  static const Color kWhite = Color(0xFFFFFFFF);
  static const Color kBlack = Color(0xFF000000);

  // Grays (updated to match new scheme, subtle warm grays)
  static const Color kGray950 = Color(0xFF1A1A1A);
  static const Color kGray900 = Color(0xFF2E2E2E);
  static const Color kGray800 = Color(0xFF404040);
  static const Color kGray700 = Color(0xFF595959);
  static const Color kGray600 = Color(0xFF737373);
  static const Color kGray500 = Color(0xFF8C8C8C);
  static const Color kGray400 = Color(0xFFA6A6A6);
  static const Color kGray300 = Color(0xFFC2C2C2);
  static const Color kGray200 = Color(0xFFD9D9D9);
  static const Color kGray100 = Color(0xFFEFEFEF);
  static const Color kGray50 = Color(0xFFF9F7F4); // Align with new light tone

  // Text Colors
  static const Color kTextPrimary = Color(
    0xFF0D2039,
  ); // Match primary for readability
  static const Color kTextSecondary = Color(0xFF595959); // Neutral dark gray

  static const List<Color> gradientColors = [
    kPrimary, // Dark navy
    kSecondary, // Orange
    kPrimary100, // Light navy
  ];

  static const LinearGradient kPrimaryGradient = LinearGradient(
    colors: [
      kPrimary, // #0D2039
      kSecondary, // #FE8F29
      kPrimary100, // #BCC4D3
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
