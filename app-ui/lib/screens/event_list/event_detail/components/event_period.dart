import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event.dart';

class EventPeriod extends StatelessWidget {
  const EventPeriod({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('이벤트 기간',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: kDefaultFontColor)),
      SizedBox(height: kDefaultPadding),
      event.period.finishDate == null
          ? Text(
              ' ${event.period.startDate.toString().substring(0, 10)} ~ 상품 소진 시까지')
          : Text(
              ' ${event.period.startDate.toString().substring(0, 10)} ~ ${event.period.finishDate.toString().substring(0, 10)}')
    ]);
  }
}
