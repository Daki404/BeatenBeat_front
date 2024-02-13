import 'package:beaten_beat/constants/color_palette.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.googleBlue,
      body: Row(children: [
        Expanded(
          flex: 1,
          child: Text("Hello? I'm Profile!"),
        )
      ]),
    );
  }
}
