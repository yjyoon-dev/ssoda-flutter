import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:image_cropper/image_cropper.dart';

class StoreLogo extends StatelessWidget {
  final VoidCallback getImageFromGallery;
  final String? logoPath;
  const StoreLogo({Key? key, required this.getImageFromGallery, this.logoPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          logoPath == null
              ? SizedBox(
                  height: 75,
                  width: 75,
                  child: ElevatedButton(
                    onPressed: getImageFromGallery,
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          CircleBorder()),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kThemeColor),
                      overlayColor:
                          MaterialStateProperty.all<Color>(Colors.white24),
                    ),
                  ))
              : GestureDetector(
                  onTap: getImageFromGallery,
                  child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: FileImage(File(logoPath!)),
                              fit: BoxFit.cover))),
                ),
          SizedBox(height: kDefaultPadding / 3 * 2),
          if (logoPath == null)
            Text('가게 로고 등록',
                style: TextStyle(color: kLiteFontColor, fontSize: 12)),
        ],
      ),
    );
  }
}
