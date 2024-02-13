import 'package:beaten_beat/provider/auth_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:beaten_beat/routes/routes.dart';
import 'package:beaten_beat/routes/router_generator.dart';
import 'package:beaten_beat/view.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (_) => AuthProvider(), child: const MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Beaten-beat',
      theme: ThemeData(
        fontFamily: 'Helvetica',
      ),
      builder: (_, child) => AppView(
        child: child!,
      ),
      initialRoute: routeHome,
      navigatorKey: navKey,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
