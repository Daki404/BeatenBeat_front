import 'dart:math';

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
            builder: (context) {
              return IntroView();
            },
            offsetBuilder: (context) => Offset(0, 0),
          ),
          ScrollTransformItem(builder: (context) {
            return Container(
              color: ColorPalette.paua,
              height: 1000,
            );
          }),
          ScrollTransformItem(builder: (context) {
            return Container(
              color: ColorPalette.kingfisherDaisy,
              height: 1500,
            );
          }),
          ScrollTransformItem(builder: (context) {
            return Container(
              color: ColorPalette.darkBlue,
              height: 500,
            );
          }),
        ],
      ),
    );
  }
}
