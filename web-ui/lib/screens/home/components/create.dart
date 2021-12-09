import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hashchecker_web/constants.dart';
import 'package:hashchecker_web/screens/home/components/animation.dart';

class Create extends StatelessWidget {
  const Create(
      {Key? key, required this.scrollController, required this.scrollOffset})
      : super(key: key);
  final scrollController;
  final scrollOffset;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
        onTap: () {
          scrollController.animateTo(size.height * 1 + kToolbarHeight,
              duration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn);
        },
        child: scrollOffset >= size.height * 0.33
            ? Container(
                width: size.width,
                height: size.height,
                color: kThemeColor.withOpacity(0.033),
                padding:
                    const EdgeInsets.fromLTRB(20, 20 + kToolbarHeight, 20, 20),
                child: AnimationLimiter(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 750),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      verticalOffset: 75,
                      child: FadeInAnimation(
                        child: widget,
                      ),
                    ),
                    children: [
                      AutoSizeText.rich(
                        TextSpan(children: [
                          TextSpan(text: '막막했던 '),
                          TextSpan(
                              text: '이벤트 만들기\n',
                              style: TextStyle(
                                  color: Colors.greenAccent.shade700,
                                  fontWeight: FontWeight.w800)),
                          TextSpan(
                              text: '쏘다',
                              style: TextStyle(
                                  color: kThemeColor,
                                  fontWeight: FontWeight.w900)),
                          TextSpan(text: '로 손쉽게 등록하세요!'),
                        ]),
                        style: TextStyle(
                            color: kDefaultFontColor,
                            fontSize: 24,
                            height: 1.2,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                      SizedBox(height: kDefaultPadding),
                      Column(
                        children: [
                          AutoSizeText(
                            '이벤트 정보를 입력하면 이벤트 템플릿이 생성되고',
                            style:
                                TextStyle(color: kLiteFontColor, fontSize: 12),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                          AutoSizeText(
                            '이벤트 참여 웹페이지의 QR 코드가 발급됩니다',
                            style:
                                TextStyle(color: kLiteFontColor, fontSize: 12),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                        ],
                      ),
                      SizedBox(height: kDefaultPadding),
                      ImageAnimation(maxImgNum: 4, section: 'create')
                    ],
                  ),
                )),
              )
            : Container(
                width: size.width,
                height: size.height,
                color: kThemeColor.withOpacity(0.033)));
  }
}
