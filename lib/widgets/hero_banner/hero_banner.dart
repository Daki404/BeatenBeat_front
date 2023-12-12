import 'package:beaten_beat/constants/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
        padding: const EdgeInsets.all(50.0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Spacer(),
          Container(
              width: screenWidth * 0.5,
              height: screenWidth * 0.5 * 9 / 16,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/lp_album2.png'),
                fit: BoxFit.contain,
              ))),
          Container(
              width: screenWidth * 0.3,
              height: screenWidth * 0.3,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/logos/logo_text.png'),
                fit: BoxFit.contain,
              ))),
          Spacer(),
        ]));
  }
}
