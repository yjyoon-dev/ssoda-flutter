import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

class StepProgressbar extends StatelessWidget {
  const StepProgressbar({
    Key? key,
    required this.maxStep,
    required int step,
    required this.context,
  })  : _step = step,
        super(key: key);

  final int maxStep;
  final int _step;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
      height: 3,
      color: kThemeColor,
      width: MediaQuery.of(context).size.width / maxStep * (_step + 1),
    );
  }
}
