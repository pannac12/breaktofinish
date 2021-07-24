import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SizedText extends StatelessWidget {
  String text = '';

  SizedText(String text) {
    this.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text.tr,
      maxLines: 2,
      minFontSize: 4,
      textAlign: TextAlign.center,
    );
  }
}
