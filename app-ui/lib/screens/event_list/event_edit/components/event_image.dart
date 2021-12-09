import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event_edit_data.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EventImageEdit extends StatefulWidget {
  final event;

  const EventImageEdit({Key? key, required this.event}) : super(key: key);

  @override
  _EventImageEditState createState() => _EventImageEditState();
}

class _EventImageEditState extends State<EventImageEdit> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.22,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        initialPage: 0,
        autoPlay: false,
        viewportFraction: 0.66,
      ),
      items: List.generate(
          widget.event.images.length,
          (index) => widget.event.images[index] == null
              ? Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextButton(
                    onPressed: () {
                      _getImageFromGallery(context, index);
                    },
                    child: Center(
                        child: Icon(
                      Icons.add,
                      color: kLiteFontColor,
                      size: 40,
                    )),
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0))),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            kScaffoldBackgroundColor),
                        overlayColor:
                            MaterialStateProperty.all<Color>(kShadowColor),
                        side: MaterialStateProperty.all<BorderSide>(
                            BorderSide(color: kLiteFontColor))),
                  ),
                )
              : Stack(children: [
                  ClipRRect(
                    child: widget.event.images[index]!
                            .startsWith(kNewImagePrefix)
                        ? Image.file(
                            File(widget.event.images[index]!
                                .substring(kNewImagePrefix.length)),
                            fit: BoxFit.cover)
                        : Image.network('$s3Url${widget.event.images[index]}',
                            fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  if (widget.event.images[index]!
                          .substring(0, kNewImagePrefix.length) !=
                      kNewImagePrefix)
                    Positioned(
                        right: 10,
                        top: 10,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              context
                                  .read<EventEditData>()
                                  .deletedImagePaths
                                  .add(widget.event.images[index]!);
                              widget.event.images.removeAt(index);
                              if (widget.event.images.length == 2 &&
                                  widget.event.images.last != null)
                                widget.event.images.add(null);
                            });
                          },
                          child: Icon(Icons.cancel_rounded,
                              size: 28, color: Colors.white.withOpacity(0.9)),
                        ))
                ])).cast<Widget>().toList(),
    ));
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
        widget.event.images[index] = '$kNewImagePrefix${croppedFile!.path}';
        context.read<EventEditData>().newImages.add(croppedFile.path);
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
