import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker_web/api.dart';
import 'package:hashchecker_web/constants.dart';

class DoneButton extends StatelessWidget {
  const DoneButton({Key? key, required this.url, required this.postId})
      : super(key: key);

  final url;
  final postId;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info_outline, size: 16, color: Colors.black45),
              AutoSizeText(
                ' 가게 사장님께 본 화면을 보여드리고 상품을 받아가세요!',
                style: TextStyle(color: Colors.black45, fontSize: 12),
                minFontSize: 4,
                maxLines: 1,
              )
            ],
          ),
          SizedBox(height: kDefaultPadding),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: TextButton(
              child: Text(
                '클릭하여 상품 수령 완료하기',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                await _completeEventJoin();
                Navigator.pop(context);
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(kThemeColor),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27)))),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _completeEventJoin() async {
    var dio = Dio();

    final joinCompleteResponse = await dio.put(
        getApi(API.JOIN_EVENT_COMPLETE, suffix: '/$postId'),
        data: {'url': url});

    print(joinCompleteResponse.data);
  }
}
