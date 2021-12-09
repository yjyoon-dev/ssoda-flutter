import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/store.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class StoreLogo extends StatefulWidget {
  final Store store;
  const StoreLogo({Key? key, required this.store}) : super(key: key);

  @override
  _StoreLogoState createState() => _StoreLogoState();
}

class _StoreLogoState extends State<StoreLogo> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _getImageFromGallery,
        child: Container(
            margin: const EdgeInsets.only(right: 20),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: widget.store.logoImage
                            .substring(0, kNewImagePrefix.length) ==
                        kNewImagePrefix
                    ? DecorationImage(
                        image: FileImage(File(widget.store.logoImage
                            .substring(kNewImagePrefix.length))),
                        fit: BoxFit.cover)
                    : DecorationImage(
                        image: NetworkImage('$s3Url${widget.store.logoImage}'),
                        fit: BoxFit.cover))));
  }

  void _getImageFromGallery() async {
    final ImagePicker _imagePicker = ImagePicker();
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    File? croppedFile;
    if (image != null) {
      croppedFile = await _cropImage(image.path);
    }
    if (croppedFile != null) {
      setState(() {
        widget.store.logoImage = '$kNewImagePrefix${croppedFile!.path}';
      });
    }
  }

  Future<File?> _cropImage(String imagePath) async {
    File? croppedFile = await ImageCropper.cropImage(
        cropStyle: CropStyle.circle,
        maxHeight: 400,
        maxWidth: 400,
        compressFormat: ImageCompressFormat.png,
        compressQuality: 75,
        sourcePath: imagePath,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: '사진 편집',
            toolbarColor: kScaffoldBackgroundColor,
            toolbarWidgetColor: kDefaultFontColor,
            activeControlsWidgetColor: kThemeColor,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
          title: '사진 편집',
          doneButtonTitle: '완료',
          cancelButtonTitle: '취소',
          aspectRatioLockEnabled: true,
        ));
    return croppedFile;
  }
}
