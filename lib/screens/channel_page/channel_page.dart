import 'package:flutter/material.dart';

import 'package:beaten_beat/constants/color_palette.dart';

class ChannelPage extends StatelessWidget {
  const ChannelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorPalette.navy,
      body: Column(
        children: [
          Center(
              child: Text(
            'Channel',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: ColorPalette.sky,
            ),
          ))
        ],
      ),
    );
  }
}
