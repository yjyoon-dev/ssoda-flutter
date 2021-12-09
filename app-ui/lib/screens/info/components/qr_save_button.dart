import 'dart:io';
import 'dart:typed_data';

import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrSaveButton extends StatelessWidget {
  final qrcodeUrl;
  const QrSaveButton({Key? key, required this.qrcodeUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        'QR 코드 이미지 저장',
        style: TextStyle(
          color: kThemeColor,
          fontSize: 12,
        ),
      ),
      onPressed: () {
        saveQrImgToGallery(context);
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

  Future<void> writeToFile(ByteData data, String path) async {
    final buffer = data.buffer;
    await File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future<String> createQrImg(String url) async {
    // check qrcode validation
    final qrValidationResult = QrValidator.validate(
      data: qrcodeUrl,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );

    if (qrValidationResult.status == QrValidationStatus.valid) {
      final qrCode = qrValidationResult.qrCode;
      final painter = QrPainter.withQr(
        qr: qrCode!,
      );

      // get temp directory for exporting qrcode image
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      final ts = DateTime.now().millisecondsSinceEpoch.toString();
      String qrImgPath = '$tempPath/event-qrcode-$ts.png';

      // write to bytefile
      final picData = await painter.toImageData(512);
      await writeToFile(picData!, qrImgPath);
      return qrImgPath;
    } else
      return ""; // invalid qr code
  }

  Future<void> saveQrImgToGallery(BuildContext context) async {
    String path = await createQrImg(qrcodeUrl);

    final success = await GallerySaver.saveImage(path);

    context.showFlashBar(
        barType: success! ? FlashBarType.success : FlashBarType.error,
        icon: success
            ? const Icon(Icons.check_circle_rounded)
            : const Icon(Icons.error_outline_rounded),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.white,
        content: Text(
            success ? 'QR 코드 이미지를 갤러리에 저장했습니다' : 'QR 코드 이미지 저장에 실패했습니다',
            style: TextStyle(fontSize: 14, color: kDefaultFontColor)));
  }
}
