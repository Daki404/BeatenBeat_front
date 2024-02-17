import 'dart:html' as html;
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:beaten_beat/constants/color_palette.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:beaten_beat/screens/profile_page/profile_page.dart';
import 'package:beaten_beat/screens/profile_page/oauth_page.dart';

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:beaten_beat/provider/auth_provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = Provider.of<AuthProvider>(context).isLoggedIn;
    Widget pageToShow = isLoggedIn ? ProfilePage() : OAuthPage();

    return Scaffold(body: pageToShow);
  }
}
