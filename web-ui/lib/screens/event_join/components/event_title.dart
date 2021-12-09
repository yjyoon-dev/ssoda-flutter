import 'package:flutter/material.dart';
import 'package:hashchecker_web/constants.dart';
import 'package:hashchecker_web/models/event.dart';
import 'package:auto_size_text/auto_size_text.dart';

class EventTitle extends StatelessWidget {
  const EventTitle({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AutoSizeText(event.title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 21,
              color: kDefaultFontColor),
          maxLines: 1,
          textAlign: TextAlign.center),
    );
  }
}
