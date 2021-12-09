import 'package:flutter/material.dart';
import 'package:hashchecker_web/constants.dart';

class Empty extends StatelessWidget {
  const Empty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        color: kScaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/empty.png'),
            Text(
              '해당 가게에 등록된 이벤트가 없습니다.',
              style: TextStyle(color: kLiteFontColor),
            )
          ],
        ));
  }
}
