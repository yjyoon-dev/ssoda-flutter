import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

import 'done_button.dart';
import 'template_image.dart';
import 'message_field.dart';
import 'image_save_button.dart';

class Body extends StatelessWidget {
  const Body({Key? key, required this.templateImage}) : super(key: key);

  final String templateImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        TemplateImage(templateImage: templateImage),
        SizedBox(height: kDefaultPadding),
        ImageSaveButton(templateImage: templateImage),
        SizedBox(height: kDefaultPadding),
        MessageField(),
        DoneButton()
      ]),
    );
  }
}
