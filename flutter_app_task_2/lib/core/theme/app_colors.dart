import 'package:flutter/material.dart';

class AppColors {
  // System
  static const Color primary = Color(0xFF276992);
  static const Color onPrimary = Color(0xFF6F9DBA);
  static const Color text = Color(0xFF4A5155);
  static const Color icon = Color(0xFF67A8C4);
  static const Color success = Color(0xFF7CB5A3);
  static const Color onSuccess = Color(0xFFD5E8E1);
  static const Color error = Color(0xFFD96554);
  static const Color onError = Color(0xFFECDAD7);

  static const Color disable = gray20;
  static const Color onDisable = gray60;

  // Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const Color gray5 = Color(0xFFFAFAFA);
  static const Color gray10 = Color(0xFFF3F4F4);
  static const Color gray20 = Color(0xFFEFF0F1);
  static const Color gray40 = Color(0xFFCCCCCC);
  static const Color gray60 = Color(0xFFAAAAAA);
  static const Color gray80 = Color(0xFF424242);

  // Text & Icons

  // Background
  static const Color background = Color(0xFFE5E5E5);

  // Gradients
}

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF00629E),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFecf9ff),
  onPrimaryContainer: Color.fromARGB(255, 3, 8, 12),
  secondary: Color(0xFF526070),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFD5E4F7),
  onSecondaryContainer: Color(0xFF0F1D2A),
  tertiary: Color(0xFF695779),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFF0DBFF),
  onTertiaryContainer: Color(0xFF241532),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFCFCFF),
  onBackground: Color(0xFF1A1C1E),
  surface: Color(0xFFFCFCFF),
  onSurface: Color(0xFF1A1C1E),
  surfaceVariant: Color(0xFFDEE3EB),
  onSurfaceVariant: Color(0xFF42474E),
  outline: Color(0xFF72777F),
  onInverseSurface: Color(0xFFF1F0F4),
  inverseSurface: Color(0xFF2F3033),
  inversePrimary: Color(0xFF99CBFF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF00629E),
  outlineVariant: Color(0xFFC2C7CF),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF99CBFF),
  onPrimary: Color(0xFF003355),
  primaryContainer: Color(0xFF004A78),
  onPrimaryContainer: Color(0xFFCFE5FF),
  secondary: Color(0xFFBAC8DA),
  onSecondary: Color(0xFF243240),
  secondaryContainer: Color(0xFF3A4857),
  onSecondaryContainer: Color(0xFFD5E4F7),
  tertiary: Color(0xFFD4BEE6),
  onTertiary: Color(0xFF392A49),
  tertiaryContainer: Color(0xFF514060),
  onTertiaryContainer: Color(0xFFF0DBFF),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF1A1C1E),
  onBackground: Color(0xFFE2E2E5),
  surface: Color(0xFF1A1C1E),
  onSurface: Color(0xFFE2E2E5),
  surfaceVariant: Color(0xFF42474E),
  onSurfaceVariant: Color(0xFFC2C7CF),
  outline: Color(0xFF8C9199),
  onInverseSurface: Color(0xFF1A1C1E),
  inverseSurface: Color(0xFFE2E2E5),
  inversePrimary: Color(0xFF00629E),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF99CBFF),
  outlineVariant: Color(0xFF42474E),
  scrim: Color(0xFF000000),
);
