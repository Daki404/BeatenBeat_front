import 'package:flutter/material.dart';

class RemoteView extends StatelessWidget {
  final String groupId;

  RemoteView({required this.groupId});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(30),
        child: Text("Remote View: $groupId"));
  }
}
