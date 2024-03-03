import 'package:beaten_beat/apis/group_api.dart';
import 'package:beaten_beat/constants/color_palette.dart';
import 'package:beaten_beat/constants/text_style_palette.dart';
import 'package:beaten_beat/provider/auth_provider.dart';
import 'package:beaten_beat/screens/channel_page/group_widget/add_profile.dart';
import 'package:beaten_beat/screens/channel_page/group_widget/group_profile.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';

class GroupData {
  final String id;
  final String name;
  final String imageUrl;
  final String leaderId;

  GroupData({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.leaderId,
  });
}

class ChannelPage extends StatefulWidget {
  const ChannelPage({Key? key}) : super(key: key);

  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  Future<List<GroupData>> fetchData() async {
    try {
      final Dio dio = Dio();
      dio.options.extra['withCredentials'] = true;

      // GET 요청 보내기
      var response = await dio.get(GroupApi.groupUrl);

      // 응답 처리
      if (response.statusCode == 200) {
        final jsonData = response.data;
        List<GroupData> groups = [];

        for (var group in jsonData['groups']) {
          groups.add(GroupData(
            id: group['id'],
            name: group['name'],
            imageUrl: group['imageURL'] ??
                "https://images.unsplash.com/photo-1680869689561-45f98ee573b7?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            leaderId: group['leader_id'],
          ));
        }
        return groups;
      }
    } catch (e) {
      // 예외 처리
      print('Error occurred: $e');
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height - 100;
    final screenWidth = MediaQuery.of(context).size.width;
    final avatarRadius = screenWidth * 0.15;
    final String myId = Provider.of<AuthProvider>(context).myId;

    return Scaffold(
      backgroundColor: ColorPalette.blackRussian,
      body: SingleChildScrollView(
        child: FutureBuilder<List<GroupData>>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              }

              List<GroupData> leadingGroups = snapshot.data!
                  .where((group) => myId == group.leaderId)
                  .toList();

              leadingGroups.add(
                GroupData(
                  id: "-1",
                  name: "",
                  imageUrl:
                      "https://icon-library.com/images/plus-icon-white/plus-icon-white-15.jpg",
                  leaderId: myId,
                ),
              );

              List<GroupData> joinedGroups = snapshot.data!
                  .where((group) => myId != group.leaderId)
                  .toList();

              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    padding: EdgeInsets.all(20),
                    child: AutoSizeText(
                      "내가 만든 채널",
                      maxLines: 1,
                      maxFontSize: 50,
                      style: TextStyles.introTextKr.copyWith(fontSize: 25),
                    ),
                  ),
                  if (snapshot.data != null)
                    GridView.count(
                      shrinkWrap: true,
                      primary: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 3, // 열의 수를 지정 (그리드 아이템의 수)
                      children: List.generate(leadingGroups.length, (index) {
                        GroupData group = leadingGroups[index];

                        if (group.name.isEmpty) {
                          return AddProfile(radius: avatarRadius);
                        } else {
                          return GroupProfile(
                              id: group.id,
                              name: group.name,
                              imgURL: group.imageUrl,
                              raidus: avatarRadius);
                        }
                      }),
                    ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    padding: EdgeInsets.all(20),
                    child: AutoSizeText(
                      "내가 소속 된 채널",
                      maxLines: 1,
                      maxFontSize: 50,
                      style: TextStyles.introTextKr.copyWith(fontSize: 25),
                    ),
                  ),
                  if (snapshot.data != null)
                    GridView.count(
                      shrinkWrap: true,
                      primary: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 3, // 열의 수를 지정 (그리드 아이템의 수)
                      children: List.generate(joinedGroups.length, (index) {
                        GroupData group = joinedGroups[index];

                        return GroupProfile(
                            id: group.id,
                            name: group.name,
                            imgURL: group.imageUrl,
                            raidus: avatarRadius);
                      }),
                    ),
                ],
              );
            }),
      ),
    );
  }
}
