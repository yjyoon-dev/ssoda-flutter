import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

class StepCount extends StatelessWidget {
  const StepCount({
    Key? key,
    required int step,
    required this.maxStep,
  })  : _step = step,
        super(key: key);

  final int _step;
  final int maxStep;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
      child: Text(
        '${_step + 1} / $maxStep',
        style: TextStyle(color: kLiteFontColor),
      ),
    );
  }
}
