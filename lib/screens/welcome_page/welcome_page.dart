import 'dart:math';

import 'package:beaten_beat/screens/welcome_page/explain_view/lp_explain.dart';
import 'package:beaten_beat/screens/welcome_page/hero_banner/hero_banner.dart';
import 'package:beaten_beat/screens/welcome_page/intro_view/intro_view.dart';
import 'package:flutter/material.dart';

import 'package:beaten_beat/constants/color_palette.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  ScrollController _scrollController = ScrollController();

  late LpExplain lpOne;
  late LpExplain lpTwo;
  late LpExplain lpThree;

  GlobalKey<LpExplainState> lpOneKey = GlobalKey();
  GlobalKey<LpExplainState> lpTwoKey = GlobalKey();
  GlobalKey<LpExplainState> lpThreeKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      print('offset = ${_scrollController.offset}');
    });

    lpOne = LpExplain(
      key: lpOneKey,
      title: 'YouTube 컨텐츠 탐색',
      script:
          '리모컨 (Multiple Remote Controller) 으로 멤버와 함께 YouTube 컨텐츠를 탐색하고, 플레이리스트에 추가해 보세요.',
      videoUrl:
          'https://bgms-bucket.s3.ap-northeast-2.amazonaws.com/video/step1.mp4',
    );
    lpTwo = LpExplain(
      key: lpTwoKey,
      title: '리모컨과 연결된 재생 플레이어',
      script:
          'YouTube 컨텐츠 플레이어를 실행하여 플레이리스트를 재생할 수 있습니다. 플레이어를 켜고 스피커에 연결하여 공간에 음악을 재생해 보세요.',
      videoUrl:
          'https://bgms-bucket.s3.ap-northeast-2.amazonaws.com/video/step2_4.mp4',
    );
    lpThree = LpExplain(
      key: lpThreeKey,
      title: '원격 재생 컨트롤 기능',
      script:
          '리모컨이 설치 되어있는 모든 Device에서 컨텐츠 재생, 컨텐츠 넘기기, 볼륨 조절 등 YouTube 컨텐츠 플레이어를 제어해 보세요!',
      videoUrl:
          'https://bgms-bucket.s3.ap-northeast-2.amazonaws.com/video/step3.mp4',
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height - 100;

    return Scaffold(
      backgroundColor: ColorPalette.blackRussian,
      body: ScrollTransformView(
        children: [
          ScrollTransformItem(
            builder: (scrollOffset) {
              return Opacity(
                opacity: max(
                  (1000 - scrollOffset) / 1000,
                  0.3,
                ),
                child: HeroBanner(),
              );
            },
            offsetBuilder: (scrollOffset) => Offset(0, scrollOffset),
          ),
          ScrollTransformItem(
            builder: (scrollOffset) {
              return AbsorbPointer(absorbing: true, child: IntroView());
            },
            offsetBuilder: (scrollOffset) => Offset(0, 0),
          ),
          ScrollTransformItem(builder: (scrollOffset) {
            return AbsorbPointer(absorbing: true, child: lpOne);
          }, offsetBuilder: (scrollOffset) {
            lpOneKey.currentState?.increaseDegree(1);
            return Offset(
                2 * screenWidth - scrollOffset * screenWidth / screenHeight,
                max(0, scrollOffset - 2 * screenHeight));
          }),
          ScrollTransformItem(builder: (scrollOffset) {
            return AbsorbPointer(absorbing: true, child: lpTwo);
          }, offsetBuilder: (scrollOffset) {
            lpTwoKey.currentState?.increaseDegree(-1);
            return Offset(
                3 * screenWidth - scrollOffset * screenWidth / screenHeight,
                max(-screenHeight, scrollOffset - 3 * screenHeight));
          }),
          ScrollTransformItem(builder: (scrollOffset) {
            return AbsorbPointer(absorbing: true, child: lpThree);
          }, offsetBuilder: (scrollOffset) {
            lpThreeKey.currentState?.increaseDegree(1);
            return Offset(
                max(
                    0,
                    4 * screenWidth -
                        scrollOffset * screenWidth / screenHeight),
                max(-screenHeight, scrollOffset - 4 * screenHeight));
          }),
          ScrollTransformItem(
            builder: (scrollOffset) {
              return Container(
                color: ColorPalette.mineShaft,
                height: screenHeight,
              );
            },
            offsetBuilder: (scrollOffset) => Offset(0, 0),
          ),
        ],
      ),
    );
  }
}
