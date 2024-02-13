import 'package:beaten_beat/provider/auth_provider.dart';
import 'package:beaten_beat/routes/routes.dart';
import 'package:flutter/material.dart';

import 'package:beaten_beat/widgets/navigaion_bar/interative_nav_item.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

class NavigationItem extends StatelessWidget {
  final String title;
  final String routeName;
  final bool selected;
  final Function onHighlight;

  const NavigationItem({
    super.key,
    required this.title,
    required this.routeName,
    required this.selected,
    required this.onHighlight,
  });

  void checkLogin(BuildContext context) async {
    try {
      final Dio dio = Dio();
      dio.options.extra['withCredentials'] = true;

      // 주어진 URL
      var url = Uri.parse('http://localhost:8080/api/v1/user/me');

      // GET 요청 보내기
      var response = await dio.get(url.toString());

      // 응답 처리
      if (response.statusCode == 200) {
        Provider.of<AuthProvider>(context, listen: false).login();
      }
    } catch (e) {
      // 예외 처리
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        checkLogin(context);
        navKey.currentState?.pushNamed(routeName);
        onHighlight(routeName);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: InteractiveNavItem(
          text: title,
          routeName: routeName,
          selected: selected,
        ),
      ),
    );
  }
}
