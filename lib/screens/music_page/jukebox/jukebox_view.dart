import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class JukeBoxView extends StatelessWidget {
  final String groupId;

  JukeBoxView({required this.groupId});

  @override
  Widget build(BuildContext context) {
    return Text("Hello");
    /*
    YoutubePlayerScaffold(
      aspectRatio: 16 / 9,
      builder: (context, player) {
        return Column(
          children: <Widget>[
            player,
          ],
        );
      },
      controller: context.ytController,
    );*/
  }
}
