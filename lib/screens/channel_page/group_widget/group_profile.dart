import 'package:beaten_beat/screens/channel_page/detail_widget/detail_dialog.dart';
import 'package:beaten_beat/screens/channel_page/group_widget/default_profile.dart';
import 'package:flutter/material.dart';

class GroupProfile extends DefaultProfile {
  GroupProfile({
    required String id,
    required double raidus,
    required String name,
    required String imgURL,
  }) : super(id: id, name: name, imgURL: imgURL, radius: raidus);

  @override
  Future<void> clicked(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DetailDialog(name: name, groupId: id, imgUrl: imgURL);
      },
    );
  }
}
