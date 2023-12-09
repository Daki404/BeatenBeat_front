import 'package:flutter/material.dart';

import 'package:beaten_beat/constants/color_palette.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorPalette.navy,
      body: Center(
        child: Text(
          'Welcome to\nFlutter',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: ColorPalette.sky,
          ),
        ),
      ),
    );
  }
}
