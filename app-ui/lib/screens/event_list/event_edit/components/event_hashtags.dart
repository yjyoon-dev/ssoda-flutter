import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

class EventHashtagsEdit extends StatefulWidget {
  final event;
  const EventHashtagsEdit({Key? key, required this.event}) : super(key: key);

  @override
  _EventHashtagsEditState createState() => _EventHashtagsEditState();
}

class _EventHashtagsEditState extends State<EventHashtagsEdit> {
  late TextEditingController _hashtagController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 7.0,
        runSpacing: -5,
        children: List.generate(
          widget.event.hashtagList.length + 1,
          (index) => index == widget.event.hashtagList.length
              ? CircleAvatar(
                  backgroundColor: kThemeColor,
                  radius: 16,
                  child: IconButton(
                      padding: const EdgeInsets.all(0),
                      highlightColor: Colors.transparent,
                      icon: Icon(Icons.add, size: 20),
                      color: Colors.white,
                      onPressed: () {
                        if (widget.event.hashtagList.length == 10) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('해시태그는 최대 10개까지만 등록할 수 있습니다!'),
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(milliseconds: 2500),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          );
                        } else
                          _showHashtagInputDialog(context);
                      }),
                )
              : Chip(
                  avatar: CircleAvatar(
                      radius: 12,
                      child: Icon(
                        Icons.tag,
                        color: Colors.white,
                        size: 16,
                      ),
                      backgroundColor: kDefaultFontColor.withOpacity(0.85)),
                  onDeleted: () {
                    setState(() {
                      widget.event.hashtagList.removeAt(index);
                    });
                  },
                  deleteIconColor: kLiteFontColor,
                  label: Text(
                    '${widget.event.hashtagList[index]}',
                    style: TextStyle(fontSize: 13.3),
                  ),
                  labelPadding: const EdgeInsets.fromLTRB(4.3, 1.2, 0, 1.2),
                  elevation: 5.0,
                  shadowColor: kShadowColor,
                  backgroundColor: kScaffoldBackgroundColor,
                ),
        ));
  }

  Future<void> _showHashtagInputDialog(BuildContext context) async {
    _hashtagController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          String? errMsg;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                title: Center(
                  child: Text(
                    '해시태그 추가하기',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                content: IntrinsicHeight(
                  child: Column(
                    children: [
                      TextField(
                        autofocus: true,
                        controller: _hashtagController,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                          hintText: '우리가게',
                          prefixIcon: Icon(Icons.tag),
                        ),
                        onSubmitted: (_) {
                          setState(() {
                            errMsg = _checkHashtag(context);
                          });
                          if (errMsg == null) Navigator.pop(context);
                        },
                      ),
                      SizedBox(height: kDefaultPadding / 5),
                      if (errMsg != null)
                        Text(
                          errMsg!,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        )
                    ],
                  ),
                ),
                actions: [
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            errMsg = _checkHashtag(context);
                          });
                          if (errMsg == null) Navigator.pop(context);
                        },
                        child: Text(
                          '추가',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  )
                ],
                contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)));
          });
        });
  }

  String? _checkHashtag(BuildContext context) {
    final validChar = RegExp(r'^[a-zA-Z0-9ㄱ-ㅎㅏ-ㅣ가-힣]+$');

    if (_hashtagController.value.text.trim().isEmpty) return '해시태그를 입력해주세요';

    if (!validChar.hasMatch(_hashtagController.value.text.trim()))
      return '공백 및 특수문자는 사용할 수 없습니다';

    if (widget.event.hashtagList
            .indexOf(_hashtagController.value.text.trim()) !=
        -1) return '이미 추가한 해시태그입니다';

    if (_hashtagController.value.text.trim().length > 10)
      return '해시태그의 길이는 최대 10글자입니다';

    setState(() {
      widget.event.hashtagList.add(_hashtagController.value.text.trim());
    });
    return null;
  }
}
