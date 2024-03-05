import 'package:beaten_beat/constants/color_palette.dart';
import 'package:beaten_beat/screens/music_page/jukebox/jukebox_view.dart';
import 'package:beaten_beat/screens/music_page/remote/remote_view.dart';
import 'package:flutter/material.dart';

class MusicDialog extends StatefulWidget {
  final String groupId;

  MusicDialog({required this.groupId});

  @override
  _MusicDialogState createState() => _MusicDialogState();
}

class _MusicDialogState extends State<MusicDialog> {
  bool _showRemote = true;

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
          height: MediaQuery.of(context).size.height - 100,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(30),
          child: Stack(
            children: <Widget>[
              _showRemote
                  ? RemoteView(groupId: widget.groupId)
                  : JukeBoxView(groupId: widget.groupId),
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
