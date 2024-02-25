import 'package:beaten_beat/apis/group_api.dart';
import 'package:beaten_beat/constants/color_palette.dart';
import 'package:beaten_beat/constants/text_style_palette.dart';
import 'package:beaten_beat/provider/auth_provider.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';

class GroupData {
  final String name;
  final String imageUrl;
  final String leaderId;

  GroupData({
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

    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            height: screenHeight,
            color: ColorPalette.blackRussian,
            child: FutureBuilder<List<GroupData>>(
                future: fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }

                  return Column(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                        padding: EdgeInsets.all(20),
                        child: AutoSizeText(
                          "내가 만든 채널",
                          maxLines: 1,
                          maxFontSize: 50,
                          style: TextStyles.introTextKr.copyWith(fontSize: 25),
                        ),
                      ),
                      if (snapshot.data != null)
                        Expanded(
                          child: GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: 3, // 열의 수를 지정 (그리드 아이템의 수)
                            children:
                                List.generate(snapshot.data!.length, (index) {
                              GroupData group = snapshot.data![index];

                              if (myId != group.leaderId) {
                                return const SizedBox.shrink();
                              }

                              return SizedBox(
                                width: avatarRadius, // 고정된 폭 설정
                                height: avatarRadius * 1.2, // 그리드 아이템의 높이 조정
                                child: Column(
                                  children: [
                                    ImageNetwork(
                                      image: group.imageUrl,
                                      height: avatarRadius,
                                      width: avatarRadius,
                                      borderRadius: BorderRadius.circular(
                                          avatarRadius / 2),
                                      onTap: () {},
                                    ),
                                    AutoSizeText(
                                      group.name,
                                      maxFontSize: 30,
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                        padding: EdgeInsets.all(20),
                        child: AutoSizeText(
                          "내가 소속 된 채널",
                          maxLines: 1,
                          maxFontSize: 50,
                          style: TextStyles.introTextKr.copyWith(fontSize: 25),
                        ),
                      ),
                      if (snapshot.data != null)
                        Expanded(
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 3,
                            ),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              GroupData group = snapshot.data![index];

                              if (myId == group.leaderId) {
                                return const SizedBox.shrink();
                              }

                              return Container(
                                width: avatarRadius,
                                height: avatarRadius * 1.5,
                                child: Column(
                                  children: [
                                    ImageNetwork(
                                      image: group.imageUrl,
                                      height: avatarRadius,
                                      width: avatarRadius,
                                      borderRadius: BorderRadius.circular(
                                          avatarRadius / 2),
                                      onTap: () {},
                                    ),
                                    AutoSizeText(
                                      group.name,
                                      maxFontSize: 30,
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  );
                }),
          ),
        )
      ],
    );
  }

  int getLeadingCount(List<GroupData>? data) {
    String myId = Provider.of<AuthProvider>(context).myId;
    int cnt = 0;

    for (int index = 0; index < data!.length; index++) {
      if (data[index].leaderId == myId) {
        cnt++;
      }
    }
    return cnt;
  }
}
