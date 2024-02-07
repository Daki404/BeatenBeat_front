import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:beaten_beat/constants/text_style_palette.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri snsUrl = Uri.parse('https://www.instagram.com/binary_j_/');
final Uri githubUrl = Uri.parse('https://github.com/Daki404');
final Uri blogUrl = Uri.parse('https://lone-coder.tistory.com/');

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height - 100;
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        width: screenWidth,
        height: screenHeight / 3,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(1000),
            child: Image.asset(
              'assets/images/profile.gif',
              width: min(screenWidth / 4, screenHeight / 4),
              height: min(screenWidth / 4, screenHeight / 4),
              fit: BoxFit.fill,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AutoSizeText(
                  'Daki404',
                  style: TextStyles.introTextKr
                      .copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  maxFontSize: 30,
                ),
                AutoSizeText(
                  'Program or\nBe Programmed.',
                  style: TextStyles.introTextKr.copyWith(fontSize: 25),
                  maxFontSize: 20,
                  maxLines: 2,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => launchUrl(githubUrl),
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/images/github.png',
                          width: screenWidth / 20,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => launchUrl(snsUrl),
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/images/instagram.png',
                          width: screenWidth / 20,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => launchUrl(blogUrl),
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/images/tstory.png',
                          width: screenWidth / 20,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ]));
  }
}
