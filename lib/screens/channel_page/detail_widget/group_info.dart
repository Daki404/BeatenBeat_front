import 'package:beaten_beat/constants/color_palette.dart';
import 'package:beaten_beat/constants/text_style_palette.dart';
import 'package:beaten_beat/screens/music_page/music_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

class GroupInfo extends StatelessWidget {
  final String groupId;
  final String groupName;
  final String imgUrl;

  GroupInfo(
      {required this.groupId, required this.groupName, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final radius = screenWidth * 0.2;

    return Stack(
      alignment: Alignment.bottomLeft,
      children: <Widget>[
        Positioned(
          child: ImageNetwork(
            image: imgUrl,
            height: radius,
            width: radius,
          ),
        ),
        Positioned(
          bottom: 20,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              groupName,
              style: TextStyles.introTextKr,
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return MusicDialog(groupId: groupId);
                  },
                );
              },
              child: Text(
                "접속하기",
                style: TextStyles.introTextKr.copyWith(
                  fontSize: 20,
                ),
              ),
            ),
          ]),
        )
      ],
    );
  }
}
