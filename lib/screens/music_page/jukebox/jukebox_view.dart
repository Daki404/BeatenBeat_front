import 'package:flutter/material.dart';

class JukeBoxView extends StatelessWidget {
  final String groupId;

  JukeBoxView({required this.groupId});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(30),
        child: Text("JukeBox View: $groupId"));
  }
}
