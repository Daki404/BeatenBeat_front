import 'package:auto_size_text/auto_size_text.dart';
import 'package:beaten_beat/constants/text_style_palette.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Summary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height - 100;

    return Container(
      width: screenWidth,
      height: screenHeight / 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AutoSizeText(
            '함께 만들고,',
            style: TextStyles.introTextKr,
            maxFontSize: 30,
            maxLines: 1,
          ),
          AutoSizeText(
            '함께 즐기는,',
            style: TextStyles.introTextKr,
            maxFontSize: 30,
            maxLines: 1,
          ),
          AutoSizeText(
            '우리만의 플레이 리스트!',
            style: TextStyles.introTextKr,
            maxFontSize: 30,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
