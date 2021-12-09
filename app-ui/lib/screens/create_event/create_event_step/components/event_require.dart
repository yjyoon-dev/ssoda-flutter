import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/requires.dart';

import 'step_text.dart';

class EventRequire extends StatefulWidget {
  final event;
  const EventRequire({Key? key, required this.event}) : super(key: key);

  @override
  _EventRequireState createState() => _EventRequireState();
}

class _EventRequireState extends State<EventRequire> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [StepText(step: 5)]),
          SizedBox(height: kDefaultPadding),
          Container(
            child: Center(
              child: Wrap(
                  spacing: 11.0,
                  runSpacing: 11.0,
                  alignment: WrapAlignment.start,
                  children: List.generate(
                      requireStringList.length,
                      (index) => SizedBox(
                            width: size.width * 0.26,
                            height: size.width * 0.26 * 1.2,
                            child: TextButton(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(requireIconList[index],
                                        color: widget.event.requireList[index]
                                            ? kThemeColor
                                            : kLiteFontColor),
                                    SizedBox(height: kDefaultPadding / 3),
                                    Text(
                                      requireStringList[index],
                                      style: TextStyle(
                                          color: widget.event.requireList[index]
                                              ? kThemeColor
                                              : kLiteFontColor,
                                          fontSize: 13,
                                          fontWeight:
                                              widget.event.requireList[index]
                                                  ? FontWeight.bold
                                                  : FontWeight.normal),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  setState(() {
                                    widget.event.requireList[index] =
                                        !widget.event.requireList[index];
                                  });
                                },
                                style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all<Color>(
                                        widget.event.requireList[index]
                                            ? kLiteFontColor.withOpacity(0.2)
                                            : kThemeColor.withOpacity(0.2)),
                                    backgroundColor: MaterialStateProperty.all<Color>(
                                        kScaffoldBackgroundColor),
                                    shape: MaterialStateProperty.all<OutlinedBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            side: BorderSide(
                                                color: widget.event.requireList[index]
                                                    ? kThemeColor
                                                    : kLiteFontColor))))),
                          ))),
            ),
          )
        ]);
  }
}
