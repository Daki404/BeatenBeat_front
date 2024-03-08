import 'dart:math';

import 'package:beaten_beat/constants/text_style_palette.dart';
import 'package:beaten_beat/screens/welcome_page/explain_view/video_app.dart';
import 'package:flutter/material.dart';

import 'package:beaten_beat/constants/color_palette.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class IntroView extends StatefulWidget {
  @override
  _IntroViewState createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height - 100;

    return Container(
      width: screenWidth,
      height: screenHeight,
      padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: screenWidth,
          ),
          AutoSizeText(
            'Welcome to Beaten-beat!',
            maxLines: 1,
            style: TextStyles.introText.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 1000,
            ),
          ),
          const SizedBox(height: 50),
          AutoSizeText(
            '더 이상 동료에게 음악을 틀어달라고',
            maxLines: 1,
            style: TextStyles.introTextKr,
          ),
          AutoSizeText(
            '부탁하지 않아도 돼요.',
            maxLines: 1,
            style: TextStyles.introTextKr,
          ),
          const SizedBox(height: 30),
          AutoSizeText(
            'Beaten-beat는 YouTube 컨텐츠를 활용한 재생 플레이어 및 원격 컨트롤 서비스(리모컨)입니다.',
            maxLines: 2,
            style: TextStyles.introTextKr.copyWith(fontSize: 25),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: min(1100, screenWidth),
            child: Stack(children: [
              VideoApp(
                width: screenWidth - 100,
                height: 9 * (screenWidth - 100) / 16,
                videoUrl:
                    'https://beatenbeatbucket.s3.ap-northeast-2.amazonaws.com/%E3%83%95%E3%82%A1%E3%82%A4%E3%83%88%E3%82%BD%E3%83%B3%E3%82%B0+(Fight+Song)+-+Eve+Music+Video.mp4',
              ),
              PointerInterceptor(
                child: AspectRatio(aspectRatio: 16 / 9),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
