import 'dart:io';
import 'dart:typed_data';

import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ImageSaveButton extends StatelessWidget {
  const ImageSaveButton({Key? key, required this.templateImage})
      : super(key: key);
  final String templateImage;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: IntrinsicWidth(
        child: Row(
          children: [
            Icon(Icons.image_rounded, color: kThemeColor),
            Text(
              ' 이벤트 템플릿 이미지 저장',
              style: TextStyle(
                color: kThemeColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      onPressed: () async {
        await showProgressDialog(context, _saveTemplateImage(context));
      },
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.fromLTRB(12, 10, 12, 10)),
          backgroundColor:
              MaterialStateProperty.all<Color>(kThemeColor.withOpacity(0.2)),
          shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))),
    );
  }

  Future<void> _saveTemplateImage(BuildContext context) async {
    final success = await GallerySaver.saveImage(templateImage);

    context.showFlashBar(
        barType: success! ? FlashBarType.success : FlashBarType.error,
        icon: success
            ? const Icon(Icons.check_circle_rounded)
            : const Icon(Icons.error_outline_rounded),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.white,
        content: Text(
            success ? '이벤트 템플릿 이미지를 갤러리에 저장했습니다' : '템플릿 이미지 저장에 실패했습니다',
            style: TextStyle(fontSize: 14, color: kDefaultFontColor)));
  }
}
