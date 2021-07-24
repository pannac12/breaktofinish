import 'package:flutter/material.dart';

class ScheduleView extends StatelessWidget {
  static const String route = '/details';
  final List images = [
    "https://i.imgur.com/P8oU4c9.png",
    "https://i.imgur.com/PF6Si6r.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule"),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext ctx, int index) {
          return Image.network(images[index]);
        },
        itemCount: images.length,
      ),
    );
  }
}
