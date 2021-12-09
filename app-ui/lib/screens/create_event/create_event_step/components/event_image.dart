import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'step_help.dart';
import 'step_text.dart';

class EventImage extends StatefulWidget {
  final event;
  EventImage({Key? key, required this.event}) : super(key: key);

  @override
  _EventImageState createState() => _EventImageState();
}

class _EventImageState extends State<EventImage> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [StepText(step: 4), StepHelp(step: 4)]),
          SizedBox(height: kDefaultPadding),
          Column(
            children: [
              Container(
                  child: CarouselSlider(
                options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.25,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    initialPage: max(widget.event.images.length - 2, 0),
                    autoPlay: false,
                    viewportFraction: 0.75,
                    aspectRatio: 4 / 3),
                items: List.generate(
                    widget.event.images.length,
                    (index) => widget.event.images[index] == null
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: TextButton(
                              onPressed: () {
                                _getImageFromGallery(context, index);
                              },
                              child: Center(
                                  child: Icon(
                                Icons.add,
                                color: kLiteFontColor,
                                size: 50,
                              )),
                              style: ButtonStyle(
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.0))),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          kScaffoldBackgroundColor),
                                  overlayColor:
                                      MaterialStateProperty.all<Color>(
                                          kShadowColor),
                                  side: MaterialStateProperty.all<BorderSide>(
                                      BorderSide(color: kLiteFontColor))),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              _getImageFromGallery(context, index);
                            },
                            child: Stack(children: [
                              ClipRRect(
                                child: Image.file(
                                    File(widget.event.images[index]!),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              if (widget.event.images.last == null &&
                                      widget.event.images.length == index + 2 ||
                                  widget.event.images.length == index + 1)
                                Positioned(
                                    right: 10,
                                    top: 10,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (widget.event.images.last == null)
                                            widget.event.images.removeLast();
                                          widget.event.images[index] = null;
                                        });
                                      },
                                      child: Icon(Icons.cancel_rounded,
                                          size: 32,
                                          color: Colors.white.withOpacity(0.9)),
                                    ))
                            ]),
                          )).cast<Widget>().toList(),
              )),
              SizedBox(height: kDefaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline, size: 16, color: kLiteFontColor),
                  Text(
                    ' 좌우 슬라이드로 최대 3장까지 등록할 수 있어요!',
                    style: TextStyle(color: kLiteFontColor, fontSize: 12),
                  )
                ],
              )
            ],
          )
        ]);
  }

  Future _getImageFromGallery(BuildContext context, int index) async {
    final ImagePicker _imagePicker = ImagePicker();
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    File? croppedFile;
    if (image != null) {
      croppedFile = await _cropImage(image.path);
    }
    if (croppedFile != null) {
      setState(() {
        if (widget.event.images[index] == null &&
            widget.event.images.length < 3) widget.event.images.add(null);
        widget.event.images[index] = croppedFile!.path;
      });
    }
  }

  Future<File?> _cropImage(String imagePath) async {
    File? croppedFile = await ImageCropper.cropImage(
        maxHeight: 1280,
        maxWidth: 1280,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 75,
        sourcePath: imagePath,
        aspectRatioPresets: [CropAspectRatioPreset.ratio4x3],
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
