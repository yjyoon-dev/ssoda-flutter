import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/reward.dart';
import 'package:hashchecker/models/event_edit_data.dart';
import 'package:hashchecker/screens/event_list/event_edit/reward_edit/reward_edit_screen.dart';
import 'package:provider/provider.dart';

class EventRewardEdit extends StatefulWidget {
  final event;

  const EventRewardEdit({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  _EventRewardEditState createState() => _EventRewardEditState();
}

class _EventRewardEditState extends State<EventRewardEdit> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 96,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: widget.event.rewardList.length,
            separatorBuilder: (context, index) => SizedBox(width: 8),
            itemBuilder: (context, index) => widget.event.rewardList[index] ==
                    null
                ? SizedBox(
                    width: 91,
                    child: ElevatedButton(
                      onPressed: () {
                        _navigateToDetailScreen(index);
                      },
                      child: Stack(children: [
                        Center(
                            child: Icon(
                          Icons.add,
                          size: 28,
                          color: kLiteFontColor,
                        )),
                      ]),
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(0),
                          side: MaterialStateProperty.all<BorderSide>(
                              BorderSide(color: kLiteFontColor)),
                          overlayColor:
                              MaterialStateProperty.all<Color>(kShadowColor),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              kScaffoldBackgroundColor),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)))),
                    ))
                : GestureDetector(
                    onTap: () {
                      _navigateToDetailScreen(index);
                      context
                          .read<EventEditData>()
                          .updatedRewardIds
                          .add(widget.event.rewardList[index].id!);
                    },
                    child: Container(
                      child: Stack(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: widget.event.rewardList[index]!.imgPath!
                                  .startsWith(kNewImagePrefix)
                              ? Image.file(
                                  File(widget.event.rewardList[index]!.imgPath!
                                      .substring(kNewImagePrefix.length)),
                                  fit: BoxFit.cover,
                                  width: 91,
                                  height: 96,
                                  color: Colors.black38,
                                  colorBlendMode: BlendMode.darken,
                                )
                              : Image.network(
                                  '$s3Url${widget.event.rewardList[index]!.imgPath}',
                                  fit: BoxFit.cover,
                                  width: 91,
                                  height: 96,
                                  color: Colors.black38,
                                  colorBlendMode: BlendMode.darken,
                                ),
                        ),
                        Center(
                          child: SizedBox(
                            width: 91,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${index + 1}단계',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                                Text(
                                  '수정하기',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                        if (widget.event.rewardList.last == null &&
                                widget.event.rewardList.length == index + 2 ||
                            widget.event.rewardList.length == index + 1)
                          Positioned(
                              right: 0,
                              top: 0,
                              child: GestureDetector(
                                onTap: () {
                                  if (widget.event.rewardList[index].id != null)
                                    context
                                        .read<EventEditData>()
                                        .deletedRewardIds
                                        .add(widget.event.rewardList[index].id);
                                  setState(() {
                                    if (widget.event.rewardList.last == null)
                                      widget.event.rewardList.removeLast();
                                    widget.event.rewardList[index] = null;
                                  });
                                },
                                child: Icon(
                                  Icons.cancel_rounded,
                                  color: Colors.white.withOpacity(0.8),
                                  size: 20,
                                ),
                              ))
                      ]),
                    ),
                  )));
  }

  _navigateToDetailScreen(int index) async {
    final Reward? result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RewardEditScreen(
                reward: widget.event.rewardList[index],
                level: index + 1,
                prevCount: index > 0
                    ? widget.event.rewardList[index - 1].count
                    : null)));

    if (result != null) {
      setState(() {
        widget.event.rewardList[index] = result;
        if (widget.event.rewardList.last != null &&
            widget.event.rewardList.length < MAX_REWARD_COUNT)
          widget.event.rewardList.add(null);
      });
    }
  }
}
