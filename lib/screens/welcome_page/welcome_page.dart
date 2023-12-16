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
              return Carousel();
            },
            offsetBuilder: (scrollOffset) {
              double st_coord = -4 * screenWidth;
              bool is_move = scrollOffset >= 2 * screenHeight;
              double distance = scrollOffset - 2 * screenHeight;
              double x_coord =
                  st_coord + (distance * (screenWidth / screenHeight));

              /*
              print(distance);
              if (x_coord >= 0) {
                double diff = x_coord;
                x_coord = 0;
                distance -= diff * screenHeight / screenWidth;
                print("end!");
                print(distance);
              }
              */
              print(scrollOffset);
              print(x_coord);
              return Offset(
                x_coord,
                is_move ? distance : 0,
              );
            },
          ),
          ScrollTransformItem(
            builder: (scrollOffset) {
              return Container(
                color: ColorPalette.paua,
                height: screenHeight,
              );
            },
            offsetBuilder: (scrollOffset) =>
                Offset(0, scrollOffset - 2 * screenHeight),
          ),
          ScrollTransformItem(
            builder: (scrollOffset) {
              return Container(
                color: ColorPalette.sky,
                height: screenHeight,
              );
            },
            offsetBuilder: (scrollOffset) =>
                Offset(0, scrollOffset - 2 * screenHeight),
          ),
        ],
      ),
    );
  }
}
