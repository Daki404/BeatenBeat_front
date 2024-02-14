import 'package:auto_size_text/auto_size_text.dart';
import 'package:beaten_beat/apis/ueser_api.dart';
import 'package:beaten_beat/constants/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_network/image_network.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  Future<Map<String, String>?> getUserInfo(BuildContext context) async {
    try {
      final Dio dio = Dio();
      dio.options.extra['withCredentials'] = true;

      // GET 요청 보내기
      var response = await dio.get(UserApi.myinfo);

      // 응답 처리
      if (response.statusCode == 200) {
        Map<String, String> responseData = response.data;
        return responseData;
      }
    } catch (e) {
      // 예외 처리
      print('Error occurred: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final avatarRadius = screenWidth * 0.2;

    return Scaffold(
      backgroundColor: ColorPalette.blackRussian,
      body: FutureBuilder<Map<String, dynamic>?>(
          future: getUserInfo(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: ColorPalette.paua,
                color: ColorPalette.mineShaft,
              ));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error occurred'));
            } else if (snapshot.hasData) {
              final userInfo = snapshot.data!;
              final String imageUrl = userInfo['image_url'] ??
                  'https://mblogthumb-phinf.pstatic.net/MjAyMTAzMTJfMjI4/MDAxNjE1NTI1OTg5NTQ3.jEVPufXOBndKsRPMn59BrM-wmv_h_602_fvvMvh5xvwg.im0lDZ3ZnFKeQMBn-UIqGFyh7p6I5xlBCmc4uVgsvJcg.JPEG.sj330035/%EC%B9%B4%ED%86%A1%ED%94%84%EC%82%AC_(3).jpeg?type=w800';
              final String nickName = userInfo['nickname'] ?? 'Unknown';
              final String socialType = userInfo['socialType'] ?? 'Unknown';

              return Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      child: ImageNetwork(
                        image: imageUrl,
                        height: avatarRadius,
                        width: avatarRadius,
                        borderRadius: BorderRadius.circular(avatarRadius / 2),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          'nick_name : ${nickName}',
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
                        SizedBox(
                          height: 50,
                        ),
                        AutoSizeText(
                          'social_type : ${socialType}',
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
                  )
                ],
              );
            }
            return Center(child: Text("No data available!"));
          }),
    );
  }
}
