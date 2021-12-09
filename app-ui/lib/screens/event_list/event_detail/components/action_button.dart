import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:gallery_saver/gallery_saver.dart';

class ActionButton extends StatelessWidget {
  final ScreenshotController screenshotController;
  const ActionButton({Key? key, required this.screenshotController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              child: AutoSizeText(
                '템플릿 이미지 저장',
                style: TextStyle(
                    color: kThemeColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
                minFontSize: 12,
              ),
              onPressed: () async {
                await showProgressDialog(context, _saveTemplateImage(context));
              },
              style: ButtonStyle(
                  shadowColor: MaterialStateProperty.all<Color>(kShadowColor),
                  overlayColor: MaterialStateProperty.all<Color>(
                      kThemeColor.withOpacity(0.2)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      kScaffoldBackgroundColor),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27.0),
                          side: BorderSide(color: kThemeColor)))),
            ),
          ),
        ),
        SizedBox(width: kDefaultPadding),
        Expanded(
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              child: Text(
                '닫기',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                  shadowColor: MaterialStateProperty.all<Color>(kShadowColor),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(kThemeColor),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27.0)))),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _saveTemplateImage(BuildContext context) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    final result = await screenshotController.captureAndSave(tempPath);

    final success = await GallerySaver.saveImage(result!);

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
