import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:introduction_screen/introduction_screen.dart';

const bodyStyle = TextStyle(fontSize: 18.0, height: 1.2);

const pageDecoration = const PageDecoration(
  titleTextStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
  bodyTextStyle: bodyStyle,
  descriptionPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
  pageColor: kScaffoldBackgroundColor,
  imagePadding: const EdgeInsets.fromLTRB(8.0, 64.0, 8.0, 8.0),
);

final introPageList = [
  PageViewModel(
    title: "환영합니다!",
    body: "SSODA는 사업주들을 위한 SNS 해시태그 이벤트 마케팅 매니저입니다.",
    image: Image.asset('assets/images/on_boarding/festivate.png'),
    decoration: pageDecoration,
  ),
  PageViewModel(
    title: "쉽고 간편한 이벤트 관리",
    body: "SNS 해시태그 이벤트를 이제는 SSODA에서 템플릿을 통해 쉽게 등록하고 관리해보세요.",
    image: Image.asset('assets/images/on_boarding/drag.png'),
    decoration: pageDecoration,
  ),
  PageViewModel(
    title: "이벤트 참여 체크 자동화",
    body: "이제 고객들의 SNS 이벤트 참여 게시물을 일일이 확인하실 필요 없어요. SSODA가 알아서 전부 체크해드릴게요.",
    image: Image.asset('assets/images/on_boarding/done_checking.png'),
    decoration: pageDecoration,
  ),
  PageViewModel(
    title: "마케팅 효과를 한 눈에",
    body: "그동안 SNS 이벤트 마케팅 효과를 알 수 없어 답답하셨죠? 이제는 SSODA가 한 눈에 보기 쉽게 정리해드릴게요.",
    image: Image.asset('assets/images/on_boarding/all_the_data.png'),
    decoration: pageDecoration,
  )
];
