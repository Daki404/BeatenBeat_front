import 'package:beaten_beat/constants/color_palette.dart';
import 'package:beaten_beat/provider/auth_provider.dart';
import 'package:beaten_beat/routes/routes.dart';
import 'package:beaten_beat/screens/profile_page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:beaten_beat/widgets/navigaion_bar/navigation_item.dart';

class GlobalNavigationBar extends StatefulWidget {
  const GlobalNavigationBar({super.key});

  @override
  _GlobalNavigationBarState createState() => _GlobalNavigationBarState();
}

class _GlobalNavigationBarState extends State<GlobalNavigationBar> {
  int index = 0;

  NavigationItem toggleItem() {
    String title = 'Account';
    String routePath = routeAccount;

    if (Provider.of<AuthProvider>(context).isLoggedIn) {
      title = 'Profile';
      routePath = routeProfile;
    }

    return NavigationItem(
      selected: index == 1,
      title: title,
      routeName: routePath,
      onHighlight: onHighlight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
          color: ColorPalette.gray300,
          width: 2.0,
        )),
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            NavigationItem(
              selected: index == 0,
              title: 'Home',
              routeName: routeHome,
              onHighlight: onHighlight,
            ),
            toggleItem(),
            NavigationItem(
              selected: index == 2,
              title: 'Channel',
              routeName: routeChannel,
              onHighlight: onHighlight,
            ),
          ]),
    );
  }

  void onHighlight(String route) {
    switch (route) {
      case routeHome:
        changeHighlight(0);
        break;

      case routeAccount:
        changeHighlight(1);
        break;

      case routeChannel:
        changeHighlight(2);
        break;
    }
  }

  void changeHighlight(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }
}
