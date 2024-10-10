import 'package:flutter/material.dart';

class AppTypography {
  static TextStyle get s22 => const TextStyle(
        fontSize: 22,
        height: 28 / 22,
      );

  static TextStyle get s20 => const TextStyle(
        fontSize: 20,
        height: 28 / 20,
      );

  static TextStyle get s18 => const TextStyle(
        fontSize: 18,
        height: 28 / 18,
      );

  static TextStyle get s16 => const TextStyle(
        fontSize: 16,
        height: 24 / 16,
      );
  static TextStyle get s14 => const TextStyle(
        fontSize: 14,
        height: 20 / 14,
      );
  static TextStyle get s12 => const TextStyle(
        fontSize: 12,
        height: 16 / 12,
      );
  static TextStyle get s11 => const TextStyle(
        fontSize: 11,
        height: 16 / 11,
      );
}

extension TextStyleX on TextStyle {
  TextStyle get thin => withFontWeight(FontWeight.w100);
  TextStyle get extraLight => withFontWeight(FontWeight.w200);
  TextStyle get light => withFontWeight(FontWeight.w300);
  TextStyle get regular => withFontWeight(FontWeight.w400);
  TextStyle get medium => withFontWeight(FontWeight.w500);
  TextStyle get semibold => withFontWeight(FontWeight.w600);
  TextStyle get bold => withFontWeight(FontWeight.w700);
  TextStyle get extraBold => withFontWeight(FontWeight.w800);
  TextStyle get black => withFontWeight(FontWeight.w900);

  TextStyle withColor(Color color) => copyWith(color: color);

  TextStyle withFontWeight(FontWeight fontWeight) =>
      copyWith(fontWeight: fontWeight);
}
