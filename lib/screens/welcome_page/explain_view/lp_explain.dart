import 'dart:math';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:beaten_beat/constants/color_palette.dart';
import 'package:beaten_beat/constants/text_style_palette.dart';
import 'package:beaten_beat/screens/welcome_page/explain_view/video_app.dart';
import 'package:flutter/material.dart';

class LpExplain extends StatefulWidget {
  final String title;
  final String script;
  final String videoUrl;

  const LpExplain({
    Key? key,
    required this.title,
    required this.script,
    required this.videoUrl,
  }) : super(key: key);

  @override
  State<LpExplain> createState() => LpExplainState();
}

class LpExplainState extends State<LpExplain> {
  int degrees = 0;

  void increaseDegree(int weight) {
    setState(() {
      degrees = (degrees + 10 * weight) % 360;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height - 100;
    double lpSize = min(screenHeight, screenWidth) / 2;

    return Container(
      height: screenHeight,
      width: screenWidth,
      child: Stack(
        children: [
          Positioned(
            top: screenHeight / 2 - lpSize / 2 - lpSize * 0.1,
            left: screenWidth / 2 - lpSize / 2 - lpSize * 0.1,
            child: Transform.rotate(
              angle: degrees * pi / 180,
              child: Image.asset(
                'assets/images/lp.png',
                width: lpSize,
                height: lpSize,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                //color: widget.backgroundColor,
                width: screenWidth * 0.4,
                height: screenHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AutoSizeText(
                      widget.title,
                      maxLines: 1,
                      maxFontSize: 100,
                      style: TextStyles.introTextKr
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    AutoSizeText(
                      widget.script,
                      maxFontSize: 50,
                      maxLines: 3,
                      style: TextStyles.introTextKr.copyWith(fontSize: 25),
                    )
                  ],
                ),
              ),
              VideoApp(videoUrl: widget.videoUrl),
            ],
          ),
        ],
      ),
    );
  }
}
