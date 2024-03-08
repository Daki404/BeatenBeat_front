import 'dart:js';
import 'dart:async';
import 'dart:convert';

import 'package:beaten_beat/apis/jukebox_api.dart';
import 'package:beaten_beat/screens/music_page/music_data.dart';
import 'package:beaten_beat/screens/music_page/remote/control_panel.dart';
import 'package:beaten_beat/screens/music_page/remote/playlist_panel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:dio/dio.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class RemoteView extends StatefulWidget {
  final String groupId;
  List<MusicData> playlist;
  YoutubePlayerController controller;

  RemoteView(
      {super.key,
      required this.groupId,
      required this.playlist,
      required this.controller});

  @override
  _RemoteViewState createState() => _RemoteViewState();
}

class _RemoteViewState extends State<RemoteView> {
  bool isNext = false;
  bool _initFlag = false;
  late StompClient stompClient;
  late StreamSubscription<StompFrame> stompSubscription;

  @override
  void initState() {
    super.initState();
    stompClient = StompClient(
      config: StompConfig(
        url: 'ws://localhost/play',
        onConnect: onConnect,
        beforeConnect: () async {
          print("wiating to connecting...");
          await Future.delayed(const Duration(seconds: 2));
          print("connecting...");
        },
        onWebSocketError: (dynamic error) => print(error.toString()),
      ),
    );
    stompClient.activate();
  }

  void onConnect(StompFrame frame) {
    stompClient.subscribe(
      destination: '/sub/room/${widget.groupId}',
      callback: (frame) {
        Map<String, String> result = json.decode(frame.body!);
        print(result);
        String? cmd = result['cmd'];

        if (cmd == 'next') {
          nextMusic();
        } else if (cmd == 'prev') {
          previousMusic();
        }
      },
    );
  }

  void sendSignal(String signal) {
    stompClient.send(
      destination: '/pub/notice',
      body: json.encode({'cmd': signal, 'groupId': widget.groupId, 'url': ''}),
    );
  }

  void addMusic(MusicData data) {
    setState(() {
      widget.playlist.add(data);
    });

    if (widget.controller.value.playerState != PlayerState.playing) {
      widget.controller.loadVideoById(videoId: widget.playlist[0].videoID);
    }
  }

  void nextMusic() async {
    if (widget.playlist.length == 0) {
      return;
    }
    final Dio dio = Dio();
    dio.options.extra['withCredentials'] = true;
    String requestUrl = '${JukeboxApi.jukeUrl}/${widget.groupId}';

    widget.playlist.add(widget.playlist[0]);
    widget.playlist.removeAt(0);
    await dio.put(requestUrl, data: {
      "startURL": widget.playlist[0].url,
    });

    isNext = true;
    if (widget.controller.value.playerState == PlayerState.playing) {
      widget.controller.stopVideo();
    }
    setState(() {
      widget.playlist = [...widget.playlist];
    });

    widget.controller.loadVideoById(videoId: widget.playlist[0].videoID);

    Future.delayed(Duration(seconds: 2), () {
      isNext = false;
    });
  }

  void previousMusic() async {
    if (widget.playlist.length == 0) {
      return;
    }

    final Dio dio = Dio();
    dio.options.extra['withCredentials'] = true;
    String requestUrl = '${JukeboxApi.jukeUrl}/${widget.groupId}';

    widget.playlist.insert(0, widget.playlist[widget.playlist.length - 1]);
    widget.playlist.removeAt(widget.playlist.length - 1);
    await dio.put(requestUrl, data: {
      "startURL": widget.playlist[0].url,
    });

    if (widget.controller.value.playerState == PlayerState.playing)
      widget.controller.stopVideo();

    widget.controller.loadVideoById(videoId: widget.playlist[0].videoID);

    setState(() {
      widget.playlist = [...widget.playlist];
    });
  }

  @override
  Widget build(BuildContext context) {
    double widgetWidth = MediaQuery.of(context).size.width;
    double widgetHeight = MediaQuery.of(context).size.height - 200;

    Future<List<MusicData>> initMusic() async {
      try {
        final Dio dio = Dio();
        final Dio dio_out = Dio();
        dio.options.extra['withCredentials'] = true;
        RegExp myRegExp = RegExp(r'/vi/([^/]+)');

        String requestUrl = '${JukeboxApi.jukeUrl}/${widget.groupId}';
        var response = await dio.get(requestUrl);

        if (response.statusCode == 200) {
          final jsonData = response.data;
          String st_song = jsonData['songURL'];
          List<String> songlist = jsonData['songList'].cast<String>();
          List<MusicData> musicList = [];

          if (songlist.length == 0) {
            return musicList;
          }

          while (songlist.first != st_song) {
            String firstElement = songlist.removeAt(0);
            songlist.add(firstElement);
          }

          print(songlist);

          for (var song in songlist) {
            String requestUrl =
                'http://youtube.com/oembed?url=${song}&format=json';
            var response = await dio_out.get(requestUrl);
            final songData = response.data;

            MusicData musicData = MusicData(
              url: song,
              videoID:
                  myRegExp.firstMatch(songData['thumbnail_url'])?.group(1) ??
                      '',
              videoTitle: songData['title'],
              thumbnailUrl: songData['thumbnail_url'],
            );
            musicList.add(musicData);
          }

          print(musicList);
          return musicList;
        }
      } catch (e) {
        print("Error occurred: $e");
      }
      return [];
    }

    bool getNextFlag() {
      return isNext;
    }

    MusicData getVideo() {
      return widget.playlist[0];
    }

    return Container(
        height: widgetHeight,
        width: widgetWidth,
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            FutureBuilder(
                future: initMusic(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }

                  widget.playlist = snapshot.data!;

                  return YoutubePlayerControllerProvider(
                    controller: context.ytController,
                    child: PlaylistPanel(
                      width: widgetWidth * 0.3,
                      height: widgetHeight,
                      playlist: widget.playlist,
                      addMusic: addMusic,
                      groupId: widget.groupId,
                    ),
                  );
                }),
            YoutubePlayerControllerProvider(
              controller: context.ytController,
              child: ControlPanel(
                width: widgetWidth * 0.5,
                height: widgetHeight,
                sendSignal: sendSignal,
                nextMusic: nextMusic,
                prevMusic: previousMusic,
                getNextFlag: getNextFlag,
                getVideo: getVideo,
              ),
            ),
          ],
        ));
  }
}
