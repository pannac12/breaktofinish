import 'package:flutter/material.dart';

class FormatView extends StatelessWidget {
  static const String route = '/format';
  final List images = [
    "https://i.imgur.com/fSnxbxP.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Format"),
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
