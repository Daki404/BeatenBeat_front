import 'dart:html' as html;
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:beaten_beat/constants/urls.dart';
import 'package:beaten_beat/constants/color_palette.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';

class OAuthPage extends StatelessWidget {
  const OAuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.navy,
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logos/logo_text.png'),
                  fit: BoxFit.cover,
                  repeat: ImageRepeat.repeat,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: ColorPalette.sky,
                      ),
                      maxLines: 1,
                      minFontSize: 20,
                      maxFontSize: 80, // Maximum font size 설정
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        html.window.open(Url.kakaoOAuthUrl, '_self');
                      },
                      icon: Image.asset(
                        'assets/logos/kakao.png',
                        height: MediaQuery.of(context).size.height * 0.05,
                      ), // 카카오 아이콘 추가
                      label: const SizedBox(
                        width: double.infinity,
                        child: Text(
                          'KaKao Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ColorPalette.blackRussian,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(ColorPalette.kakaoYellow),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        html.window.open(Url.naverOAuthUrl, '_self');
                      },
                      icon: Image.asset(
                        'assets/logos/naver.png',
                        height: MediaQuery.of(context).size.height * 0.05,
                      ), // 네이버 아이콘 추가
                      label: const SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Naver Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ColorPalette.blackRussian,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(ColorPalette.naverGreen),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        html.window.open(Url.googleOAuthUrl, '_self');
                      },
                      icon: Image.asset(
                        'assets/logos/google.png',
                        height: MediaQuery.of(context).size.height * 0.05,
                      ), // 구글 아이콘 추가
                      label: const SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Google Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ColorPalette.blackRussian,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(ColorPalette.sky),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
