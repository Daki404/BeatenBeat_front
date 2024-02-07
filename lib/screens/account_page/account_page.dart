import 'package:flutter/material.dart';

import 'package:beaten_beat/constants/color_palette.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorPalette.navy,
      body: Column(
        children: [
          Center(
            child: Text(
              'Welcome to\nAccount',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: ColorPalette.sky,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
