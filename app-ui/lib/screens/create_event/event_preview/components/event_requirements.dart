import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/models/requires.dart';

class EventRequirements extends StatelessWidget {
  const EventRequirements({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('추가 조건',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: kDefaultFontColor)),
      SizedBox(height: kDefaultPadding),
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
              event.requireList.length,
              (index) => event.requireList[index]
                  ? Text(
                      '• ${requireSingleLineStringList[index]}\n',
                      style: TextStyle(color: kDefaultFontColor),
                    )
                  : Container()))
    ]);
  }
}
