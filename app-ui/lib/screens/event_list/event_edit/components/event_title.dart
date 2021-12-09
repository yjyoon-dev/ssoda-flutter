import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

class EventTitleEdit extends StatelessWidget {
  final eventTitleController;
  const EventTitleEdit({Key? key, required this.eventTitleController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
          controller: eventTitleController,
          style: TextStyle(
            color: kDefaultFontColor,
            fontSize: 15,
          ),
          decoration: InputDecoration(
              hintText: '이벤트 제목을 입력해주세요',
              hintStyle: TextStyle(
                  color: kLiteFontColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
          maxLength: 20),
    );
  }
}
