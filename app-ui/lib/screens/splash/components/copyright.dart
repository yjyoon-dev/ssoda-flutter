import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

class Copyright extends StatelessWidget {
  const Copyright({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      'Copyright ⓒ 2021 Rocketdan All rights reserved.',
      style: TextStyle(fontSize: 8, color: kThemeColor),
      maxLines: 1,
    );
  }
}
