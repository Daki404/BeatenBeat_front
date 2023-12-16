import 'package:flutter/material.dart';

class Carousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height - 100;

    return Container(
      height: screenHeight,
      width: screenWidth * 5,
      child: Row(
        children: [
          Container(
            height: screenHeight,
            width: screenWidth,
            color: Colors.red,
          ),
          Container(
            height: screenHeight,
            width: screenWidth,
            color: Colors.cyan,
          ),
          Container(
            height: screenHeight,
            width: screenWidth,
            color: Colors.amber,
          ),
          Container(
            height: screenHeight,
            width: screenWidth,
            color: Colors.cyan,
          ),
          Container(
            height: screenHeight,
            width: screenWidth,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
