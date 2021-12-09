import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

class InputHelp extends StatelessWidget {
  const InputHelp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            title: Center(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(
                  Icons.help_outline,
                  size: 22,
                  color: kDefaultFontColor,
                ),
                Text(' 단가와 수량',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: kDefaultFontColor),
                    textAlign: TextAlign.center),
                SizedBox(
                  width: 10,
                )
              ]),
            ),
            content: const Text(
                '추후 마케팅 성과 측정 및 이벤트 조기 종료를 파악하기 위해 입력하는 정보이며 이벤트에 참여하는 고객들에게는 공개되지 않습니다.',
                style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
            actions: [
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('확인')),
              )
            ],
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
      ),
      child: SizedBox(
        height: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.help_outline,
              size: 12,
              color: kLiteFontColor,
            ),
            Text(
              ' 단가와 수량은 왜 입력하나요?',
              style: TextStyle(fontSize: 12, color: kLiteFontColor),
            ),
          ],
        ),
      ),
    );
  }
}
