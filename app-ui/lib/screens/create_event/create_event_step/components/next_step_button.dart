import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/screens/create_event/event_preview/event_preview_screen.dart';
import 'package:hashchecker/constants.dart';

class NextStepButton extends StatelessWidget {
  final step;
  final maxStep;
  final plusStep;
  final Event event;
  const NextStepButton(
      {Key? key,
      required this.step,
      required this.maxStep,
      required this.plusStep,
      required this.event})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        child: Text(
          step == maxStep - 1 ? '이벤트 미리보기' : '다음 단계로',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          _onNextStepButtonPressed(context);
        },
        style: ButtonStyle(
            shadowColor: MaterialStateProperty.all<Color>(kShadowColor),
            backgroundColor: MaterialStateProperty.all<Color>(kThemeColor),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.0)))),
      ),
    );
  }

  void _onNextStepButtonPressed(BuildContext context) {
    if (!_checkStepValidation(context)) return;
    if (step == maxStep - 1) {
      _createPreview(context);
    } else {
      plusStep();
    }
  }

  bool _checkStepValidation(BuildContext context) {
    switch (step) {
      case 0:
        if (event.title == "") {
          _showValidationErrorFlashBar(context, '이벤트 제목을 입력해주세요!');
          return false;
        }
        break;
      case 1:
        if (event.rewardList.length == 1) {
          _showValidationErrorFlashBar(context, '이벤트 상품을 최소 1개 이상 등록해주세요!');
          return false;
        }
        break;
      case 2:
        if (event.hashtagList.isEmpty) {
          _showValidationErrorFlashBar(context, '필수 해시태그를 최소 1개 이상 등록해주세요!');
          return false;
        }
        break;
      case 3:
        if (event.period.finishDate != null &&
            event.period.startDate.isAfter(event.period.finishDate!)) {
          _showValidationErrorFlashBar(context, '종료 날짜가 시작 날짜보다 앞서있어요!');
          return false;
        }
        break;
      case 4:
        if (event.images.length == 1 && event.images.last == null) {
          _showValidationErrorFlashBar(context, '대표 이미지를 최소 1개 이상 등록해주세요!');
          return false;
        }
        break;
    }

    return true;
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

  void _createPreview(BuildContext context) {
    Event savingEvent = Event(
        title: event.title,
        rewardList: event.rewardList.where((reward) => reward != null).toList(),
        hashtagList: event.hashtagList,
        period: event.period,
        images: event.images.where((image) => image != null).toList(),
        requireList: event.requireList,
        template: event.template,
        rewardPolicy: event.rewardPolicy);

    Navigator.push(
        context, slidePageRouting(EventPreviewScreen(event: savingEvent)));
  }
}
