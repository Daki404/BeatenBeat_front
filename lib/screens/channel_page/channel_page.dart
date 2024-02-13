import 'package:beaten_beat/provider/auth_provider.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'package:beaten_beat/constants/color_palette.dart';

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

class ChannelPage extends StatelessWidget {
  const ChannelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = Provider.of<AuthProvider>(context).isLoggedIn;

    return Scaffold(
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
          )),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Call!"),
            ),
          ),
          Text(
            isLoggedIn ? 'Login' : 'Not Login',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
