import 'package:beaten_beat/screens/welcome_page/footer/profile.dart';
import 'package:beaten_beat/screens/welcome_page/footer/summary.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height - 100;

    return Container(
      width: screenWidth,
      height: screenHeight,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: Image.asset(
              'assets/images/simple_logo.png',
              width: screenWidth / 2,
              height: screenHeight / 3,
            ),
          ),
          Summary(),
          Profile(),
        ],
      ),
    );
  }
}
