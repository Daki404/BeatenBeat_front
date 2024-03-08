import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:beaten_beat/apis/jukebox_api.dart';
import 'package:beaten_beat/constants/text_style_palette.dart';
import 'package:beaten_beat/screens/music_page/music_data.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_network/image_network.dart';

class PlaylistPanel extends StatefulWidget {
  final double width;
  final double height;
  final String groupId;
  List<MusicData> playlist;
  Function addMusic;

  PlaylistPanel({
    required this.width,
    required this.height,
    required this.playlist,
    required this.addMusic,
    required this.groupId,
  });

  @override
  _PlaylistPanelState createState() => _PlaylistPanelState();
}

class _PlaylistPanelState extends State<PlaylistPanel> {
  String _inputUrl = "";

  void addMusic(String youtubeUrl) async {
    try {
      final Dio dio = Dio();
      final Dio dio_in = Dio();
      dio_in.options.extra['withCredentials'] = true;

      RegExp myRegExp = RegExp(r'/vi/([^/]+)');

      String requestUrl =
          'http://youtube.com/oembed?url=${youtubeUrl}&format=json';

      var response = await dio.get(requestUrl);

      if (response.statusCode == 200) {
        final jsonData = response.data;

        MusicData musicData = MusicData(
          url: youtubeUrl,
          videoID:
              myRegExp.firstMatch(jsonData['thumbnail_url'])?.group(1) ?? '',
          videoTitle: jsonData['title'],
          thumbnailUrl: jsonData['thumbnail_url'],
        );

        String requestUrl = '${JukeboxApi.jukeUrl}/${widget.groupId}';
        var response_2 = await dio_in.post(requestUrl, data: {
          "youtube_URL": youtubeUrl,
        });

        setState(() {
          widget.playlist = [...widget.playlist, musicData];
          widget.addMusic(musicData);
        });
      }
    } catch (e) {
      print("Error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Container(
                width: widget.width * 0.6,
                padding: const EdgeInsets.all(10),
                child: TextField(
                  onChanged: (value) {
                    _inputUrl = value;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter Youtube URL',
                  ),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.add_circle_outline, size: 50),
                onPressed: () {
                  addMusic(_inputUrl);
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: widget.width,
            height: widget.height - 100,
            child: ListView.builder(
              itemCount: widget.playlist.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    height: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image:
                            NetworkImage(widget.playlist[index].thumbnailUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 5,
                          sigmaY: 5,
                        ),
                        child: Container(
                          color: Colors.grey.withOpacity(0.1),
                          child: Text(
                            widget.playlist[index].videoTitle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:
                                TextStyles.introTextKr.copyWith(fontSize: 30),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
