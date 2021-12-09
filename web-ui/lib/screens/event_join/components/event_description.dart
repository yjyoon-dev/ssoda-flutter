import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker_web/constants.dart';
import 'package:hashchecker_web/models/event.dart';

class EventDescription extends StatelessWidget {
  const EventDescription({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AutoSizeText.rich(
        TextSpan(children: [
          TextSpan(text: 'SNS에 #해시태그와 함께 글 남기고\n'),
          TextSpan(
              text: _createRewardNameList(),
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: kDefaultFontColor)),
          TextSpan(text: ' 받아가세요!')
        ]),
        textAlign: TextAlign.center,
        maxLines: 3,
        minFontSize: 8,
        style: TextStyle(color: kDefaultFontColor, height: 1.4, fontSize: 13),
      ),
    );
  }

  String _createRewardNameList() {
    String rewardNameList = "";
    for (int i = 0; i < event.rewardList.length; i++) {
      rewardNameList += event.rewardList[i]!.name;
      if (i < event.rewardList.length - 1) rewardNameList += " / ";
    }
    return rewardNameList;
  }
}
