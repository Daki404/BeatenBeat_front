import 'package:beaten_beat/constants/color_palette.dart';
import 'package:flutter/material.dart';
import 'group_info.dart';
import 'user_list.dart';

class DetailDialog extends StatelessWidget {
  final String groupId;
  final String name;
  final String imgUrl;

  DetailDialog(
      {required this.groupId, required this.name, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: ColorPalette.mineShaft,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.5,
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GroupInfo(
                groupId: groupId,
                groupName: name,
                imgUrl: imgUrl,
              ),
              UserList(
                groupId: groupId,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
