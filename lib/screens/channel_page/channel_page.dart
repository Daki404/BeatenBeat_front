import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'package:beaten_beat/constants/color_palette.dart';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class ChannelPage extends StatelessWidget {
  const ChannelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.navy,
      body: Column(
        children: [
          Center(
              child: Text(
            'Channel',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: ColorPalette.sky,
            ),
          )),
          Center(
            child: ElevatedButton(
              onPressed: () {
                fetchData();
              },
              child: Text("Call!"),
            ),
          )
        ],
      ),
    );
  }

  void fetchData() async {
    try {
      final Dio dio = Dio();
      dio.options.extra['withCredentials'] = true;

      // 주어진 URL
      var url = Uri.parse('http://localhost:8080/api/v1/user/me');

      // GET 요청 보내기
      var response = await dio.get(url.toString());

      // 응답 처리
      if (response.statusCode == 200) {
        // 요청 성공
        print('Response data: ${response.data}');
      } else {
        // 요청 실패
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // 예외 처리
      print('Error occurred: $e');
    }
  }
}
