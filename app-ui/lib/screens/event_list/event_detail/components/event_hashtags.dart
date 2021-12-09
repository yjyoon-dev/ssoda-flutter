import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event.dart';

class EventHashtags extends StatelessWidget {
  const EventHashtags({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('필수 해시태그',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: kDefaultFontColor)),
      SizedBox(height: kDefaultPadding),
      Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8.0,
          children: List.generate(
              event.hashtagList.length,
              (index) => Chip(
                    avatar: CircleAvatar(
                      radius: 14,
                      child: Icon(
                        Icons.tag,
                        color: Colors.white,
                        size: 18,
                      ),
                      backgroundColor: kDefaultFontColor.withOpacity(0.85),
                    ),
                    label: Text(event.hashtagList[index]),
                    labelPadding: const EdgeInsets.fromLTRB(6, 2, 5, 2),
                    elevation: 9.0,
                    shadowColor: kShadowColor,
                    backgroundColor: kScaffoldBackgroundColor,
                  )))
    ]);
  }
}
