import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hashchecker_web/constants.dart';
import 'package:hashchecker_web/models/event.dart';

class EventHashtags extends StatelessWidget {
  const EventHashtags({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('필수 해시태그',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: kDefaultFontColor)),
          ElevatedButton(
            child: Text(
              '전체 복사',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              _copyAllHashtagsToClipboard(context);
            },
            style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.fromLTRB(17, 8, 17, 8)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.black.withOpacity(0.8)),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(27)))),
          ),
        ],
      ),
      SizedBox(height: kDefaultPadding),
      Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8.0,
          children: List.generate(
              event.hashtagList.length,
              (index) => GestureDetector(
                    onTap: () {
                      Clipboard.setData(new ClipboardData(
                              text: '#${event.hashtagList[index]}'))
                          .then((_) {
                        _showCopiedFlashBar(context,
                            '#${event.hashtagList[index]} 을(를) 복사했습니다.');
                      });
                    },
                    child: Chip(
                      avatar: CircleAvatar(
                        radius: 14,
                        child: Icon(
                          Icons.tag,
                          color: Colors.white,
                          size: 18,
                        ),
                        backgroundColor: kDefaultFontColor.withOpacity(0.85),
                      ),
                      label: Text(event.hashtagList[index]),
                      labelPadding: const EdgeInsets.fromLTRB(6, 2, 5, 2),
                      elevation: 9.0,
                      shadowColor: kShadowColor.withOpacity(0.6),
                      backgroundColor: kScaffoldBackgroundColor,
                    ),
                  )))
    ]);
  }

  void _copyAllHashtagsToClipboard(BuildContext context) {
    String hashtags = "";
    for (int i = 0; i < event.hashtagList.length; i++)
      hashtags += '#${event.hashtagList[i]} ';

    Clipboard.setData(new ClipboardData(text: hashtags)).then((_) {
      _showCopiedFlashBar(context, '모든 해시태그가 클립보드에 복사되었습니다.');
    });
  }

  void _showCopiedFlashBar(BuildContext context, String message) {
    context.showFlashBar(
        barType: FlashBarType.success,
        icon: const Icon(Icons.check_circle_rounded),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.white,
        content: Text(message,
            style: TextStyle(fontSize: 14, color: kDefaultFontColor)));
  }
}
