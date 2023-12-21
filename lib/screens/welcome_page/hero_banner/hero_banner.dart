import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height - 100;

    final double arrowLength = screenHeight / 3;
    final double arrowWidth = arrowLength * 290 / 1589;
    final Image arrowImage = Image.asset('assets/images/arrow.png',
        height: arrowLength, width: arrowWidth);

    return Stack(
      children: [
        ShakeWidget(
          shakeConstant: ShakeSlowConstant1(),
          autoPlay: false,
          enableWebMouseHover: true,
          child: SizedBox(
            width: screenWidth,
            height: screenHeight,
            child: Positioned.fill(
              child: Image.asset(
                'assets/images/album_all.png',
                repeat: ImageRepeat.repeat,
              ),
            ),
          ),
        ),
        Positioned(
          top: screenHeight / 2,
          left: screenWidth / 2 - arrowWidth / 2,
          child: arrowImage,
        ),
      ],
    );
  }
}
