import 'package:beaten_beat/constants/color_palette.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ChannelPage extends StatefulWidget {
  const ChannelPage({Key? key}) : super(key: key);

  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.blackRussian,
      body: Text("channel."),
    );
  }
}
