import 'package:auto_size_text/auto_size_text.dart';
import 'package:beaten_beat/constants/text_style_palette.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

class DefaultProfile extends StatelessWidget {
  final String id;
  final String name;
  final String imgURL;
  final double radius;

  DefaultProfile(
      {required this.id,
      required this.name,
      required this.imgURL,
      required this.radius});

  Future<void> clicked(BuildContext context) async {
    print("I'm cliked!");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: radius, // 고정된 폭 설정
      height: radius, // 그리드 아이템의 높이 조정
      child: Column(
        children: [
          ImageNetwork(
            image: imgURL,
            height: radius,
            width: radius,
            borderRadius: BorderRadius.circular(radius / 2),
            onTap: () {
              clicked(context);
            },
          ),
          AutoSizeText(
            name,
            maxFontSize: 30,
            minFontSize: 20,
            maxLines: 1,
            style: TextStyles.introTextKr,
          ),
        ],
      ),
    );
  }
}
