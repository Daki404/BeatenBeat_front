import 'package:flutter/material.dart';

import 'package:beaten_beat/screens/welcome_page/welcome_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Hahmlet',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        /*
        '/login': (context) => const LoginPage(),
        '/account': (context) => const AccountPage(),
        '/channel': (context) => const ChannelPage(),
        */
      },
    );
  }
}
