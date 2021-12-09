import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/widgets/number_slider/number_slide_animation_widget.dart';

class DeltaData extends StatelessWidget {
  const DeltaData({Key? key, required this.value}) : super(key: key);

  final int value;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(
        value > 0
            ? Icons.arrow_drop_up
            : (value < 0 ? Icons.arrow_drop_down : Icons.remove),
        color:
            value > 0 ? Colors.green : (value < 0 ? Colors.red : Colors.grey),
        size: 32,
      ),
      NumberSlideAnimation(
          number: value.abs().toString(),
          duration: kDefaultNumberSliderDuration,
          curve: Curves.easeOut,
          textStyle: TextStyle(
              color: value > 0
                  ? Colors.green
                  : (value < 0 ? Colors.red : Colors.grey),
              fontSize: 18),
          format: NumberFormatMode.comma)
    ]);
  }
}
