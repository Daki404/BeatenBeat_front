import 'package:beaten_beat/constants/color_palette.dart';
import 'package:beaten_beat/screens/music_page/jukebox/jukebox_view.dart';
import 'package:beaten_beat/screens/music_page/music_data.dart';
import 'package:beaten_beat/screens/music_page/remote/remote_view.dart';
import 'package:beaten_beat/screens/music_page/stomp_test.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MusicDialog extends StatefulWidget {
  final String groupId;
  List<MusicData> playlist = [];

  MusicDialog({required this.groupId});

  @override
  _MusicDialogState createState() => _MusicDialogState();
}

class _MusicDialogState extends State<MusicDialog> {
  bool _showRemote = true;
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        mute: false,
        showControls: true,
        showFullscreenButton: true,
        loop: false,
      ),
    );
  }

  void _toggleRemote() {
    setState(() {
      _showRemote = !_showRemote;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: ColorPalette.mineShaft,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(30),
          child: Stack(
            children: <Widget>[
              YoutubePlayerControllerProvider(
                controller: controller,
                child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: _showRemote
                        ? RemoteView(
                            groupId: widget.groupId,
                            playlist: widget.playlist,
                            controller: controller)
                        : StompTest()),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.change_circle_outlined,
                      size: 50, color: ColorPalette.sky),
                  onPressed: () {
                    _toggleRemote();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
