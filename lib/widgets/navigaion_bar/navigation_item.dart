import 'package:beaten_beat/routes/routes.dart';
import 'package:flutter/material.dart';

import 'package:beaten_beat/widgets/navigaion_bar/interative_nav_item.dart';

class NavigationItem extends StatelessWidget {
  final String title;
  final String routeName;
  final bool selected;
  final Function onHighlight;

  const NavigationItem({
    super.key,
    required this.title,
    required this.routeName,
    required this.selected,
    required this.onHighlight,
  });

  @override
  Widget build(BuildContext context) {
    print(selected);
    return GestureDetector(
      onTap: () {
        navKey.currentState?.pushNamed(routeName);
        onHighlight(routeName);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: InteractiveNavItem(
          text: title,
          routeName: routeName,
          selected: selected,
        ),
      ),
    );
  }
}
