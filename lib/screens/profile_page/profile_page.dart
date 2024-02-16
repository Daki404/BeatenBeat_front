import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:beaten_beat/apis/ueser_api.dart';
import 'package:beaten_beat/constants/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_network/image_network.dart';
import 'dart:html' as html;
import 'dart:convert';
import 'package:image_picker_web/image_picker_web.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Map<String, dynamic>?> _userInfoFuture;
  late String _imageUrl;
  late String _nickName;
  late String _socialType;

  @override
  void initState() {
    super.initState();
    _userInfoFuture = getUserInfo(context);
  }

  Future<Uint8List?> pickUpImage(BuildContext context) async {
    Uint8List? bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
    return bytesFromPicker;
  }

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

  Future<void> uploadImageToServer(
      BuildContext context, Uint8List imageByte) async {
    final Dio dio = Dio();
    dio.options.extra['withCredentials'] = true;

    String base64Image = base64Encode(imageByte);

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromBytes(imageByte, filename: 'image.jpg')
    });

    try {
      Response response = await dio.post(
        UserApi.myinfo,
        data: formData,
      );
      if (response.statusCode == 200) {
        print("Image uploaded successfully");
        setState(
          () {
            _imageUrl = 'data:image/jpeg;base64,${base64Image}';
          },
        );
      } else {
        print("Failed to upload image");
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
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
              final String imageUrl = userInfo['imageURL'] ??
                  'https://mblogthumb-phinf.pstatic.net/MjAyMTAzMDhfMjg1/MDAxNjE1MTg3MDkyODA5.NaArqzn6u4fcTOVbyrru5OjIU-09zNFh0Whj4fqyosQg.7jaO1DHJ82_wiheKeQACLo1n83QVbncNYlfXUY-4pycg.JPEG.aksen244/%C3%97Avengers_whatsapp%C3%97.jpg?type=w800';
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
                        onTap: () async {
                          Uint8List? byteImage = await pickUpImage(context);

                          if (byteImage != null) {
                            await uploadImageToServer(context, byteImage);
                          }
                        },
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
