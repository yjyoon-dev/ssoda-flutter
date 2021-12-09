import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

class MessageField extends StatelessWidget {
  const MessageField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.check, color: Colors.greenAccent.shade700),
              SizedBox(width: kDefaultPadding / 3),
              Text(
                '이벤트가 등록되었습니다 ',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kDefaultFontColor),
              ),
            ]),
            SizedBox(height: kDefaultPadding),
            InkWell(
              onTap: () {
                _showHelpDialog(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.help_outline, size: 16, color: kLiteFontColor),
                  Text(
                    ' 이벤트 템플릿은 어떻게 사용하나요?',
                    style: TextStyle(color: kLiteFontColor, fontSize: 12),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showHelpDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Center(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(
                  Icons.help_outline,
                  size: 22,
                  color: kDefaultFontColor,
                ),
                Text('  이벤트 템플릿',
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
            content: Text(
                "이벤트 템플릿 이미지 저장 버튼을 통해 생성된 이벤트의 템플릿 이미지를 스마트폰 앨범에 저장할 수 있습니다. 이를 인쇄한 후 매장의 적절한 곳에 비치하여 고객들의 이벤트 참여를 유도할 수 있습니다.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
            contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
            actions: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('확인', style: TextStyle(fontSize: 13)),
                  style: ButtonStyle(
                      shadowColor:
                          MaterialStateProperty.all<Color>(kShadowColor),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kThemeColor)),
                ),
              )
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))));
  }
}
