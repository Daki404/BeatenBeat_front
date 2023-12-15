import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height - 100;

    return SizedBox(
      width: screenWidth,
      height: screenHeight,
      child: Positioned.fill(
        child: Image.asset(
          'assets/images/album_all.png',
          repeat: ImageRepeat.repeat,
        ),
      ),
    );
  }
}
