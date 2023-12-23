import 'package:beaten_beat/screens/account_page/account_page.dart';
import 'package:beaten_beat/screens/channel_page/channel_page.dart';
import 'package:flutter/material.dart';

import 'package:beaten_beat/routes/routes.dart';
import 'package:beaten_beat/screens/welcome_page/welcome_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeHome:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => WelcomePage(),
          transitionDuration: Duration(seconds: 0),
        );

      case routeLogin:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => WelcomePage(),
          transitionDuration: Duration(seconds: 0),
        );

      case routeAccount:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => AccountPage(),
          transitionDuration: Duration(seconds: 0),
        );

      case routeChannel:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => ChannelPage(),
          transitionDuration: Duration(seconds: 0),
        );

      default:
        throw Exception('Invalid route: ${settings.name}');
    }
  }
}
