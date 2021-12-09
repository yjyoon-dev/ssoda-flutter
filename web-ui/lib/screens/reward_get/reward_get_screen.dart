import 'package:flutter/material.dart';
import 'components/body.dart';

class RewardGetScreen extends StatelessWidget {
  final eventTitle;
  final rewardName;
  final rewardImage;
  final postId;
  final storeId;
  final url;
  const RewardGetScreen(
      {Key? key,
      required this.eventTitle,
      required this.rewardName,
      required this.rewardImage,
      required this.storeId,
      required this.postId,
      required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Body(
            size: size,
            eventTitle: eventTitle,
            rewardName: rewardName,
            rewardImage: rewardImage,
            postId: postId,
            storeId: storeId,
            url: url));
  }
}
