import 'package:beaten_beat/widgets/hero_banner/hero_banner.dart';
import 'package:flutter/material.dart';

import 'package:beaten_beat/constants/color_palette.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorPalette.blackRussian,
      body: Column(
        children: [
          //Image(image: AssetImage('assets/logos/logo_text.png')),
          HeroBanner(),
          Center(
            child: Text(
              'Welcome to\nBeaten-beat!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: ColorPalette.sky,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
