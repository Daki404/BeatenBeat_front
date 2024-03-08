import 'package:beaten_beat/apis/group_api.dart';
import 'package:beaten_beat/constants/text_style_palette.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GroupUsers {
  final String groupId;
  List<String> userList;

  GroupUsers({
    required this.groupId,
    required this.userList,
  });
}

class UserList extends StatefulWidget {
  final String groupId;

  const UserList({super.key, required this.groupId});

  @override
  _UserListState createState() {
    return _UserListState();
  }
}

class _UserListState extends State<UserList> {
  String _inputUserName = "";
  late GroupUsers _groupUserData;

  Future<GroupUsers> fetchData() async {
    List<String> userIdList = [];

    try {
      final Dio dio = Dio();
      dio.options.extra['withCredentials'] = true;
      String requestUrl = GroupApi.groupUrl + '/${widget.groupId}';

      var response = await dio.get(requestUrl);

      if (response.statusCode == 200) {
        final jsonData = response.data;
        for (var userName in jsonData['userNameList']) {
          userIdList.add(userName);
        }
      }

      return GroupUsers(groupId: widget.groupId, userList: userIdList);
    } catch (e) {
      print("Error occurred: $e");
    }

    return GroupUsers(groupId: '-1', userList: userIdList);
  }

  // _groupuserList => setState.
  Future<void> inviteUser(String nickName) async {
    try {
      final Dio dio = Dio();
      dio.options.extra['withCredentials'] = true;
      String requestUrl = '${GroupApi.groupUrl}/${widget.groupId}';

      Response response = await dio.post(requestUrl, data: {
        "nickName": nickName,
      });

      if (response.statusCode == 200) {
        print("Success to invite User!");
        setState(() {
          _groupUserData.userList.add(nickName);
        });
      } else {
        print("Failed to invite User..");
      }
    } catch (e) {
      print("Error occur: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final widgetWidth = screenWidth * 0.2;

    return Column(
      children: <Widget>[
        Row(
          children: [
            Container(
              width: widgetWidth,
              padding: const EdgeInsets.all(20),
              child: TextField(
                onChanged: (value) {
                  _inputUserName = value;
                },
                decoration: const InputDecoration(
                  hintText: '추가할 User의 Nickname을 적어주세요!',
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
                onPressed: () => inviteUser(_inputUserName),
                icon: const Icon(Icons.add))
          ],
        ),
        SizedBox(
          width: widgetWidth,
          height: 30,
        ),
        FutureBuilder(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              }

              _groupUserData = GroupUsers(
                  groupId: widget.groupId, userList: snapshot.data!.userList);

              return Container(
                width: widgetWidth,
                margin: const EdgeInsets.all(10),
                child: Container(
                  width: widgetWidth,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        for (var nickname in _groupUserData.userList)
                          Text(nickname,
                              style: TextStyles.introTextKr
                                  .copyWith(fontSize: 20)),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ],
    );
  }
}
