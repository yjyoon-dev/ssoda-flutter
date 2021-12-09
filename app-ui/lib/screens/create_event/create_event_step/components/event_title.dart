import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

import 'step_help.dart';
import 'step_text.dart';

class EventTitle extends StatefulWidget {
  final event;
  const EventTitle({Key? key, required this.event}) : super(key: key);

  @override
  _EventTitleState createState() => _EventTitleState();
}

class _EventTitleState extends State<EventTitle> {
  late TextEditingController _eventTitleController;

  @override
  void initState() {
    super.initState();
    _eventTitleController = TextEditingController(text: widget.event.title);
  }

  @override
  void dispose() {
    _eventTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [StepText(step: 0), StepHelp(step: 0)]),
          SizedBox(height: kDefaultPadding),
          TextField(
              controller: _eventTitleController,
              cursorColor: kThemeColor,
              onChanged: (_) {
                widget.event.title = _eventTitleController.value.text.trim();
              },
              maxLines: 1,
              maxLength: 25,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: kThemeColor),
              decoration: InputDecoration(
                  hintText: '우리가게 SNS 해시태그 이벤트',
                  hintStyle: TextStyle(color: kLiteFontColor)))
        ]);
  }
}
