import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/screens/create_event/create_event_step/components/next_step_button.dart';

import 'event_hashtags.dart';
import 'event_image.dart';
import 'event_period.dart';
import 'event_require.dart';
import 'event_reward.dart';
import 'event_template.dart';
import 'event_title.dart';
import 'step_count.dart';
import 'step_progressbar.dart';

class Body extends StatelessWidget {
  final step;
  final prevStep;
  final maxStep;
  final plusStep;
  final event;
  const Body(
      {Key? key,
      required this.step,
      required this.prevStep,
      required this.maxStep,
      required this.plusStep,
      required this.event})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      StepProgressbar(context: context, step: step, maxStep: maxStep),
      StepCount(step: step, maxStep: maxStep),
      Expanded(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: PageTransitionSwitcher(
                    duration: const Duration(milliseconds: 300),
                    reverse: prevStep > step,
                    transitionBuilder: (
                      Widget child,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                    ) {
                      return SharedAxisTransition(
                        child: child,
                        fillColor: kScaffoldBackgroundColor,
                        animation: animation,
                        secondaryAnimation: secondaryAnimation,
                        transitionType: SharedAxisTransitionType.horizontal,
                      );
                    },
                    child: _getStepComponents(step))),
            SizedBox(height: kDefaultPadding),
            NextStepButton(
                step: step, maxStep: maxStep, plusStep: plusStep, event: event)
          ],
        ),
      ))
    ]);
  }

  Widget _getStepComponents(int step) {
    switch (step) {
      case 0:
        return EventTitle(event: event);
      case 1:
        return EventReward(event: event);
      case 2:
        return EventHashtags(event: event);
      case 3:
        return EventPeriod(event: event);
      case 4:
        return EventImage(event: event);
      case 5:
        return EventTemplate(event: event);
      default:
        return Container(child: Text('유효하지 않은 단계입니다.'));
    }
  }
}
