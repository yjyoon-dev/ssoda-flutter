import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/reward.dart';
import 'package:hashchecker/screens/create_event/input_reward_info/input_reward_info_screen.dart';
import 'dart:io';

import 'step_help.dart';
import 'step_text.dart';

class EventReward extends StatefulWidget {
  final event;
  const EventReward({Key? key, required this.event}) : super(key: key);

  @override
  _EventRewardState createState() => _EventRewardState();
}

class _EventRewardState extends State<EventReward> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [StepText(step: 1), StepHelp(step: 1)]),
          SizedBox(height: kDefaultPadding),
          Column(
            children: [
              Container(
                  height: 116,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.event.rewardList.length,
                      padding: const EdgeInsets.fromLTRB(3, 6, 3, 6),
                      separatorBuilder: (context, index) => SizedBox(width: 12),
                      itemBuilder: (context, index) => widget
                                  .event.rewardList[index] ==
                              null
                          ? SizedBox(
                              width: 100,
                              child: ElevatedButton(
                                onPressed: () {
                                  _navigateToDetailScreen(index);
                                },
                                child: Stack(children: [
                                  Center(
                                      child: Icon(
                                    Icons.add,
                                    size: 45,
                                    color: kLiteFontColor,
                                  )),
                                ]),
                                style: ButtonStyle(
                                    elevation:
                                        MaterialStateProperty.all<double>(0),
                                    side: MaterialStateProperty.all<BorderSide>(
                                        BorderSide(color: kLiteFontColor)),
                                    overlayColor:
                                        MaterialStateProperty.all<Color>(
                                            kShadowColor),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            kScaffoldBackgroundColor),
                                    shape: MaterialStateProperty.all<
                                            OutlinedBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)))),
                              ))
                          : GestureDetector(
                              onTap: () {
                                _navigateToDetailScreen(index);
                              },
                              child: Container(
                                child: Stack(children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.file(
                                      File(widget
                                          .event.rewardList[index]!.imgPath),
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: 110,
                                      color: Colors.black38,
                                      colorBlendMode: BlendMode.darken,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${index + 1}단계',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          '등록 완료',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                  if (widget.event.rewardList.last == null &&
                                          widget.event.rewardList.length ==
                                              index + 2 ||
                                      widget.event.rewardList.length ==
                                          index + 1)
                                    Positioned(
                                        right: 0,
                                        top: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (widget
                                                      .event.rewardList.last ==
                                                  null)
                                                widget.event.rewardList
                                                    .removeLast();
                                              widget.event.rewardList[index] =
                                                  null;
                                            });
                                          },
                                          child: Icon(
                                            Icons.cancel_rounded,
                                            color:
                                                Colors.white.withOpacity(0.8),
                                          ),
                                        ))
                                ]),
                              ),
                            ))),
              SizedBox(height: kDefaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline, size: 16, color: kLiteFontColor),
                  Text(
                    ' 최대 $MAX_REWARD_COUNT단계까지 상품을 등록할 수 있어요!',
                    style: TextStyle(color: kLiteFontColor, fontSize: 12),
                  )
                ],
              )
            ],
          )
        ]);
  }

  _navigateToDetailScreen(int index) async {
    final Reward? result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InputRewardInfoScreen(
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
