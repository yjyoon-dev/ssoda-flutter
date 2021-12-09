import 'package:flutter/material.dart';
import 'package:hashchecker_web/constants.dart';

import 'done_button.dart';
import 'header_with_reward.dart';
import 'message_field.dart';

class Body extends StatelessWidget {
  final eventTitle;
  final rewardName;
  final rewardImage;
  final postId;
  final storeId;
  final url;
  const Body(
      {Key? key,
      required this.size,
      required this.eventTitle,
      required this.rewardName,
      required this.rewardImage,
      required this.storeId,
      required this.postId,
      required this.url})
      : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      HeaderWithReward(storeId: storeId, rewardImagePath: rewardImage),
      SizedBox(height: kDefaultPadding),
      MessageField(eventTitle: eventTitle, rewardName: rewardName),
      DoneButton(url: url, postId: postId)
    ]);
  }
}
