import 'dart:math';

import 'package:beaten_beat/screens/welcome_page/explain_view/explain_one.dart';
import 'package:beaten_beat/screens/welcome_page/hero_banner/hero_banner.dart';
import 'package:beaten_beat/screens/welcome_page/intro_view/intro_view.dart';
import 'package:flutter/material.dart';

import 'package:beaten_beat/constants/color_palette.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      print(_scrollController.offset);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height - 100;

    return Scaffold(
      backgroundColor: ColorPalette.blackRussian,
      body: ScrollTransformView(
        children: [
          ScrollTransformItem(
            builder: (scrollOffset) {
              return Opacity(
                opacity: max(
                  (1000 - scrollOffset) / 1000,
                  0.3,
                ),
                child: HeroBanner(),
              );
            },
            offsetBuilder: (scrollOffset) => Offset(0, scrollOffset),
          ),
          ScrollTransformItem(
            builder: (scrollOffset) {
              return IntroView();
            },
            offsetBuilder: (scrollOffset) => Offset(0, 0),
          ),
          ScrollTransformItem(
            builder: (scrollOffset) {
              return Container(
                color: ColorPalette.paua,
                height: screenHeight,
              );
            },
            offsetBuilder: (scrollOffset) => Offset(
                2 * screenWidth - scrollOffset * screenWidth / screenHeight,
                max(0, scrollOffset - 2 * screenHeight)),
          ),
          ScrollTransformItem(
            builder: (scrollOffset) {
              return Container(
                color: ColorPalette.kingfisherDaisy,
                height: screenHeight,
              );
            },
            offsetBuilder: (scrollOffset) => Offset(
                3 * screenWidth - scrollOffset * screenWidth / screenHeight,
                max(-screenHeight, scrollOffset - 3 * screenHeight)),
          ),
          ScrollTransformItem(
            builder: (scrollOffset) {
              return Container(
                color: ColorPalette.darkBlue,
                height: screenHeight,
              );
            },
            offsetBuilder: (scrollOffset) => Offset(
                max(
                    0,
                    4 * screenWidth -
                        scrollOffset * screenWidth / screenHeight),
                max(-screenHeight, scrollOffset - 4 * screenHeight)),
          ),
          ScrollTransformItem(
            builder: (scrollOffset) {
              return Container(
                color: ColorPalette.mineShaft,
                height: screenHeight,
              );
            },
            offsetBuilder: (scrollOffset) => Offset(0, 0),
          ),
        ],
      ),
    );
  }
}
