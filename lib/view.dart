import 'package:beaten_beat/widgets/navigaion_bar/global_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:beaten_beat/constants/color_palette.dart';

class AppView extends StatelessWidget {
  final Widget child;

  const AppView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.blackRussian,
      body: Column(
        children: [
          const GlobalNavigationBar(),
          Expanded(child: child),
        ],
      ),
    );
  }
}
