import 'dart:convert';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:beaten_beat/apis/group_api.dart';
import 'package:beaten_beat/constants/text_style_palette.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:dio/dio.dart';

class AddProfile extends StatefulWidget {
  String name = "";
  String imgURL =
      'https://icon-library.com/images/plus-icon-white/plus-icon-white-15.jpg';
  String widgetURL =
      'https://mblogthumb-phinf.pstatic.net/MjAyMTAzMDhfMjg1/MDAxNjE1MTg3MDkyODA5.NaArqzn6u4fcTOVbyrru5OjIU-09zNFh0Whj4fqyosQg.7jaO1DHJ82_wiheKeQACLo1n83QVbncNYlfXUY-4pycg.JPEG.aksen244/%C3%97Avengers_whatsapp%C3%97.jpg?type=w800';

  late String tmp_name;
  final double radius;
  final void Function() refresh;

  AddProfile({required this.radius, required this.refresh});

  Future<Uint8List?> pickUpImage(BuildContext context) async {
    Uint8List? bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
    return bytesFromPicker;
  }

  @override
  _AddProfileState createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {
  Future<void> uploadImageToServer(
      BuildContext context, Uint8List imageByte, String name) async {
    final Dio dio = Dio();
    dio.options.extra['withCredentials'] = true;

    String base64Image = base64Encode(imageByte);

    FormData formData = FormData.fromMap({
      "name": name,
      "file": await MultipartFile.fromBytes(imageByte, filename: 'image.jpg')
    });

    try {
      Response response = await dio.post(
        GroupApi.groupUrl,
        data: formData,
      );
      if (response.statusCode == 200) {
        print("Image uploaded successfully");
        widget.refresh();
      } else {
        print("Failed to upload image");
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> _showDialog() async {
    String imageUrl =
        'https://images.unsplash.com/photo-1708770362006-7f8e5b02b0f5?q=80&w=1365&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
    late Uint8List? _byteImage;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("그룹 생성"),
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageNetwork(
                    key: UniqueKey(),
                    image: imageUrl,
                    height: widget.radius,
                    width: widget.radius,
                    borderRadius: BorderRadius.circular(widget.radius / 2),
                    onTap: () async {
                      _byteImage = await widget.pickUpImage(context);

                      setState(
                        () {
                          String base64Image = base64Encode(_byteImage!);
                          imageUrl = 'data:image/jpeg;base64,${base64Image}';
                        },
                      );
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter Name',
                    ),
                    onChanged: (value) {
                      widget.tmp_name = value;
                    },
                  ),
                ],
              );
            }),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  if (_byteImage != null) {
                    uploadImageToServer(context, _byteImage!, widget.tmp_name);
                  }
                  Navigator.of(context).pop();
                },
                child: Text('생성'),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("취소"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.radius, // 고정된 폭 설정
      height: widget.radius, // 그리드 아이템의 높이 조정
      child: Column(
        children: [
          ImageNetwork(
            image: widget.imgURL,
            height: widget.radius,
            width: widget.radius,
            borderRadius: BorderRadius.circular(widget.radius / 2),
            onTap: _showDialog,
          ),
          AutoSizeText(
            widget.name,
            maxFontSize: 30,
            minFontSize: 20,
            maxLines: 1,
            style: TextStyles.introTextKr,
          ),
        ],
      ),
    );
  }
}
