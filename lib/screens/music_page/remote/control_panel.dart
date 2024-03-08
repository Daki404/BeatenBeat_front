import 'package:beaten_beat/constants/text_style_palette.dart';
import 'package:beaten_beat/screens/music_page/music_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_network/image_network.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class ControlPanel extends StatefulWidget {
  final double width;
  final double height;
  Function getNextFlag;
  Function getVideo;
  Function sendSignal;
  Function nextMusic;
  Function prevMusic;

  ControlPanel(
      {required this.width,
      required this.height,
      required this.sendSignal,
      required this.nextMusic,
      required this.prevMusic,
      required this.getNextFlag,
      required this.getVideo});

  @override
  _ControlPanelState createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          YoutubePlayer(
            controller: context.ytController,
            aspectRatio: 16 / 9,
          ),
          const SizedBox(height: 20),
          Text(
            widget.getVideo().videoTitle,
            style: TextStyles.introTextKr.copyWith(fontSize: 30),
          ),
          const SizedBox(height: 20),
          StreamBuilder<YoutubeVideoState>(
            stream: context.ytController.videoStateStream,
            initialData: const YoutubeVideoState(),
            builder: (context, snapshot) {
              final position = snapshot.data?.position.inMilliseconds ?? 0;
              final duration =
                  context.ytController.metadata.duration.inMilliseconds;

              if (!widget.getNextFlag() && (position / duration) > 0.99) {
                widget.sendSignal('next');
              }

              return LinearProgressIndicator(
                value: duration == 0 ? 0 : position / duration,
                minHeight: 1,
              );
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.skip_previous, size: 100),
                onPressed: () {
                  widget.sendSignal('prev');
                },
              ),
              YoutubeValueBuilder(
                builder: (context, value) {
                  return IconButton(
                      icon: Icon(
                        value.playerState == PlayerState.playing
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 100,
                      ),
                      onPressed: () {
                        value.playerState == PlayerState.playing
                            ? context.ytController.pauseVideo()
                            : context.ytController.playVideo();
                      });
                },
              ),
              IconButton(
                icon: const Icon(Icons.skip_next, size: 100),
                onPressed: () {
                  widget.sendSignal('next');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
