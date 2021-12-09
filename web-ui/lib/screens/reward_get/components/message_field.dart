import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker_web/constants.dart';

class MessageField extends StatelessWidget {
  final eventTitle;
  final rewardName;
  const MessageField(
      {Key? key, required this.eventTitle, required this.rewardName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '축하드립니다!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: kDefaultPadding),
            Divider(
              height: kDefaultPadding * 2,
            ),
            AutoSizeText.rich(
              TextSpan(children: [
                TextSpan(
                    text: eventTitle,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: '에서')
              ]),
              style: TextStyle(fontSize: 18),
              maxLines: 1,
            ),
            SizedBox(height: kDefaultPadding / 5),
            AutoSizeText.rich(
              TextSpan(children: [
                TextSpan(
                    text: rewardName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kThemeColor,
                        fontSize: 22)),
                TextSpan(text: ' 에 당첨되셨습니다.')
              ]),
              style: TextStyle(fontSize: 18),
              maxLines: 1,
            ),
            Divider(
              height: kDefaultPadding * 2,
            ),
          ],
        ),
      ),
    );
  }
}
