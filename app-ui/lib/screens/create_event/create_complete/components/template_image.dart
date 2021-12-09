import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

class TemplateImage extends StatelessWidget {
  const TemplateImage({Key? key, required this.templateImage})
      : super(key: key);
  final String templateImage;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.only(top: kToolbarHeight),
        height: size.height * 0.5,
        child: ClipRRect(
            child: Image.file(File(templateImage)),
            borderRadius: BorderRadius.circular(8)),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: kShadowColor,
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(1, 1), // changes position of shadow
          ),
        ], borderRadius: BorderRadius.circular(8)));
  }
}
