import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class StompTest extends StatefulWidget {
  @override
  _StompTestState createState() => _StompTestState();
}

class _StompTestState extends State<StompTest> {
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
      destination: '/sub/room/1',
      callback: (frame) {
        List<dynamic>? result = json.decode(frame.body!);
        print(result);
      },
    );
  }

  @override
  void dispose() {
    stompSubscription.cancel();
    stompClient.deactivate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: IconButton(
      icon: Icon(
        Icons.add,
        size: 50,
      ),
      onPressed: () {
        stompClient.send(
          destination: '/pub/notice',
          body: json.encode({'groupId': 1, 'cmd': "hello?", 'url': "sex"}),
        );
      },
    ));
  }
}
