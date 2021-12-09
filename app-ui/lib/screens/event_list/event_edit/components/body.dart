import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/reward.dart';

import 'event_hashtags.dart';
import 'event_image.dart';
import 'event_period.dart';
import 'event_reward.dart';
import 'event_title.dart';
import 'confirm_button.dart';

class Body extends StatelessWidget {
  final eventId;
  final event;
  final eventTitleController;
  final startDatePickerController;
  final finishDatePickerController;
  Body(
      {Key? key,
      required this.eventId,
      required this.event,
      required this.eventTitleController,
      required this.startDatePickerController,
      required this.finishDatePickerController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Section(text: '대표 이미지'),
            SizedBox(height: kDefaultPadding),
            EventImageEdit(
              event: event,
            ),
            SizedBox(height: kDefaultPadding * 2),
            Section(text: '이벤트 제목'),
            SizedBox(height: kDefaultPadding * 1.5),
            EventTitleEdit(eventTitleController: eventTitleController),
            SizedBox(height: kDefaultPadding),
            Section(text: '이벤트 상품'),
            SizedBox(height: kDefaultPadding),
            EventRewardEdit(event: event),
            SizedBox(height: kDefaultPadding * 2.5),
            Section(text: '필수 해시태그'),
            SizedBox(height: kDefaultPadding / 3),
            EventHashtagsEdit(event: event),
            SizedBox(height: kDefaultPadding * 2),
            Section(text: '이벤트 기간'),
            SizedBox(height: kDefaultPadding / 2.5),
            EventPeriodEdit(
                event: event,
                startDatePickerController: startDatePickerController,
                finishDatePickerController: finishDatePickerController),
            SizedBox(height: kDefaultPadding),
            ConfirmButton(
                eventId: eventId,
                event: event,
                eventTitleController: eventTitleController,
                startDatePickerController: startDatePickerController,
                finishDatePickerController: finishDatePickerController)
          ],
        )),
      ),
    ));
  }
}

class Section extends StatelessWidget {
  final text;
  const Section({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: kDefaultFontColor, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
