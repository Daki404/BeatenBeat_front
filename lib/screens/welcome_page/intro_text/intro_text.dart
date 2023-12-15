import 'package:flutter/material.dart';

import 'package:beaten_beat/constants/color_palette.dart';

import 'package:auto_size_text/auto_size_text.dart';

class IntroText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height - 100;

    return Container(
      width: screenWidth,
      height: screenHeight,
      padding: EdgeInsets.all(50),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: AutoSizeText(
              'Welcome to Beaten-beat!',
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorPalette.sky,
                fontSize: 2000,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
