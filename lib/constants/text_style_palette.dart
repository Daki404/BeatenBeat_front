import 'package:beaten_beat/constants/color_palette.dart';
import 'package:beaten_beat/screens/welcome_page/intro_text/intro_text.dart';
import 'package:flutter/material.dart';

class TextStyles {
  TextStyles._();
  static const TextStyle navigation = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    color: ColorPalette.sky,
  );
  static const TextStyle introText = TextStyle(
    color: ColorPalette.sky,
    fontSize: 50,
  );
}
