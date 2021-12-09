import 'package:flutter/material.dart';
import 'components/body.dart';

class CreateCompleteScreen extends StatelessWidget {
  final String templateImage;
  const CreateCompleteScreen({Key? key, required this.templateImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Body(templateImage: templateImage));
  }
}
