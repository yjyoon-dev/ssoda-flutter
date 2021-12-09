import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flash/flash.dart';
import 'package:hashchecker_web/api.dart';
import 'package:hashchecker_web/constants.dart';
import 'package:hashchecker_web/models/event.dart';
import 'package:hashchecker_web/models/fcm.dart';
import 'package:hashchecker_web/models/join_result.dart';
import 'package:hashchecker_web/models/reward.dart';
import 'package:hashchecker_web/screens/reward_get/reward_get_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class EventJoinWithUrl extends StatefulWidget {
  final Event event;
  final eventId;
  final storeId;
  final loading;
  final roulette;
  const EventJoinWithUrl(
      {Key? key,
      required this.event,
      required this.eventId,
      required this.storeId,
      required this.loading,
      required this.roulette})
      : super(key: key);

  @override
  _EventJoinWithUrlState createState() => _EventJoinWithUrlState();
}

class _EventJoinWithUrlState extends State<EventJoinWithUrl> {
  final _urlController = TextEditingController();
  bool _urlEnabled = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('이벤트 참여하기',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            SizedBox(width: kDefaultPadding / 2),
            GestureDetector(
                onTap: () async {
                  final _instagramUrl = 'https://www.instagram.com';
                  await canLaunch(_instagramUrl)
                      ? await launch(_instagramUrl)
                      : throw 'Could not launch $_instagramUrl';
                },
                child: Container(
                    width: 30,
                    height: 30,
                    child: Image.asset('assets/images/instagram.png'))),
            SizedBox(width: kDefaultPadding / 2),
            GestureDetector(
                onTap: () async {
                  final _naverBlogUrl = 'https://blog.naver.com';
                  await canLaunch(_naverBlogUrl)
                      ? await launch(_naverBlogUrl)
                      : throw 'Could not launch $_naverBlogUrl';
                },
                child: Container(
                    width: 30,
                    height: 30,
                    child: Image.asset('assets/images/naverblog.png'))),
          ],
        ),
        SizedBox(height: kDefaultPadding),
        TextField(
          enabled: _urlEnabled && widget.event.status == EventStatus.PROCEEDING,
          controller: _urlController,
          textInputAction: TextInputAction.go,
          onSubmitted: (_) {
            if (isValidUrl())
              sendUrlToGetReward();
            else
              _showValidationErrorFlashBar(context, '올바른 게시글 URL이 아닙니다.');
          },
          style: TextStyle(fontSize: 14),
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.link),
              hintText: widget.event.status == EventStatus.PROCEEDING
                  ? 'SNS 게시글 URL을 붙여넣기 해주세요!'
                  : '',
              contentPadding: const EdgeInsets.all(8),
              isDense: true),
        ),
        SizedBox(height: kDefaultPadding / 3),
        SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: ElevatedButton(
                onPressed:
                    _urlEnabled && widget.event.status == EventStatus.PROCEEDING
                        ? () {
                            if (isValidUrl())
                              sendUrlToGetReward();
                            else
                              _showValidationErrorFlashBar(
                                  context, '올바른 SNS URL이 아닙니다.');
                          }
                        : null,
                child: Text(widget.event.status == EventStatus.PROCEEDING
                    ? 'URL 업로드하고 이벤트 참여하기'
                    : '현재 진행 중인 이벤트가 아닙니다'))),
        SizedBox(height: kDefaultPadding),
        Row(
          children: [
            Icon(
              Icons.help_outline,
              color: Colors.black54,
              size: 16,
            ),
            Text(' 참여 방법',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black54)),
          ],
        ),
        SizedBox(height: kDefaultPadding / 3),
        RichText(
            text: TextSpan(children: [
          TextSpan(text: '1. 조건에 맞춰 SNS에 게시글을 작성\n'),
          TextSpan(text: '2. 작성한 '),
          TextSpan(
              text: '게시글의 링크', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '를 복사-붙여넣기하여 업로드\n'),
          TextSpan(text: '3. 게시글 검사 후 이벤트 상품 즉시 지급!\n'),
        ], style: TextStyle(color: Colors.black54, fontSize: 13))),
      ],
    );
  }

  Future<void> sendUrlToGetReward() async {
    setState(() {
      _urlEnabled = false;
    });

    widget.loading(true);

    Map<String, dynamic> urlJson = {'url': _urlController.value.text.trim()};

    var dio = Dio();

    dio.options.contentType = 'application/json';
    dio.options.headers['Access-Control-Allow-Origin'] = '*';

    dio.interceptors.add(InterceptorsWrapper(onError: (error, handler) async {
      widget.loading(false);
      if (error.response?.statusCode == 406) {
        final String errMsg = error.response?.data['message'];
        if (errMsg == "It's different from the previous event.")
          _showValidationErrorFlashBar(context, '이미 다른 이벤트에 참여한 게시글입니다.');
        else if (errMsg == "Post is private")
          _showValidationErrorFlashBar(context, '참여한 SNS 계정이 비공개 계정입니다.');
        else if (errMsg == "Post is deleted")
          _showValidationErrorFlashBar(context, '참여한 SNS 게시글이 삭제되었습니다.');
        else if (errMsg == "Post is different hashtag")
          _showValidationErrorFlashBar(context, '작성한 포스트의 해시태그가 일치하지 않습니다.');
        else if (errMsg == "Post is already rewarded")
          _showValidationErrorFlashBar(
              context, '이미 같은 게시글로 해당 이벤트에 참여한 내역이 있습니다.');
        else
          _showValidationErrorFlashBar(context, '알 수 없는 오류가 발생하였습니다. [406]');
      } else {
        _showValidationErrorFlashBar(
            context, '알 수 없는 오류가 발생하였습니다. [${error.response?.statusCode}]');
      }
    }));

    final eventJoinResponse = await dio.post(
        getApi(API.GET_REWARD, suffix: '/${widget.eventId}'),
        data: urlJson);

    JoinResult result = JoinResult.fromJson(eventJoinResponse.data);

    FCMessage fcMessage =
        createEventJoinNotification(widget.event.title, result.reward.name);

    var fcmDio = Dio();

    try {
      final pushNotificationResponse = await fcmDio.post(
          getApi(API.PUSH_NOTIFICATION, suffix: '/${widget.storeId}'),
          data: {
            'title': fcMessage.title,
            'body': fcMessage.body,
            'image': fcMessage.image,
            'data': {}
          });
    } catch (e) {} finally {
      widget.loading(false);

      if (widget.event.rewardList.length > 1) {
        widget.roulette(result.reward.id);
        await Future.delayed(Duration(seconds: 6));
      }

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => RewardGetScreen(
                  eventTitle: widget.event.title,
                  rewardName: result.reward.name,
                  rewardImage: result.reward.imgPath,
                  url: _urlController.value.text.trim(),
                  storeId: widget.storeId,
                  postId: result.postId)));
    }
  }

  void _showValidationErrorFlashBar(BuildContext context, String message) {
    context.showFlashBar(
        barType: FlashBarType.error,
        icon: const Icon(Icons.error_outline_rounded),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.white,
        content: Text(message,
            style: TextStyle(fontSize: 14, color: kDefaultFontColor)));
  }

  bool isValidUrl() {
    final String url = _urlController.value.text.trim();
    if (url == "") return false;
    if (!url.startsWith(instagramPostUrlPrefix) &&
        !url.startsWith(naverBlogPostUrlPrefix) &&
        !url.startsWith(mobileNaverBlogPostUrlPrefix)) return false;
    return true;
  }
}
