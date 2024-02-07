import 'package:beaten_beat/constants/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  TextStyles._();
  static const TextStyle navigation = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    color: ColorPalette.sky,
  );
  static const TextStyle introText = TextStyle(
    fontSize: 50,
    color: ColorPalette.sky,
  );
  static TextStyle get introTextKr => GoogleFonts.notoSans(
        textStyle: introText,
      );
}
