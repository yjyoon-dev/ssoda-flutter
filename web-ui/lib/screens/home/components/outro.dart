import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hashchecker_web/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Outro extends StatelessWidget {
  const Outro(
      {Key? key, required this.scrollController, required this.scrollOffset})
      : super(key: key);
  final scrollController;
  final scrollOffset;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return GestureDetector(
      onTap: () {
        scrollController.animateTo(size.height * 4 + kToolbarHeight,
            duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
      },
      child: scrollOffset >= size.height * 3.33
          ? Container(
              width: size.width,
              height: size.height,
              color: kDefaultFontColor,
              padding:
                  const EdgeInsets.fromLTRB(40, 40 + kToolbarHeight, 40, 40),
              child: size.height > size.width
                  ? AnimationLimiter(
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
                                  TextSpan(text: '사장님, 이제\n'),
                                  TextSpan(
                                      text: '쏘다',
                                      style: TextStyle(
                                          color: kLogoColor,
                                          fontWeight: FontWeight.w900)),
                                  TextSpan(text: '로 쏘세요'),
                                ]),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    height: 1.4,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                              ),
                              SizedBox(height: size.width * 0.25),
                              Container(
                                child: Image.asset(
                                  'assets/images/home/icon.png',
                                  width: size.width * 0.3,
                                  height: size.width * 0.3,
                                ),
                              ),
                              SizedBox(height: size.width * 0.1),
                              GestureDetector(
                                onTap: () async {
                                  await canLaunch(kGooglePlayStoreDownloadUrl)
                                      ? await launch(
                                          kGooglePlayStoreDownloadUrl)
                                      : throw '구글 플레이 스토어에 연결할 수 없습니다.';
                                },
                                child: Container(
                                  width: size.width * 0.4,
                                  child: Image.asset(
                                      'assets/images/home/google-play-badge.png'),
                                ),
                              ),
                              SizedBox(height: kDefaultPadding / 2),
                              GestureDetector(
                                  onTap: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                            title: Center(
                                              child: Text('쏘다',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                      color: kDefaultFontColor),
                                                  textAlign: TextAlign.center),
                                            ),
                                            content: Text(
                                                "iOS 버전은 출시 준비 중입니다.\n조금만 기다려주세요!",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: kDefaultFontColor,
                                                    height: 1.2)),
                                            contentPadding:
                                                const EdgeInsets.fromLTRB(
                                                    15, 15, 15, 5),
                                            actions: [
                                              Center(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('확인',
                                                      style: TextStyle(
                                                          fontSize: 13)),
                                                  style: ButtonStyle(
                                                      shadowColor:
                                                          MaterialStateProperty
                                                              .all<Color>(
                                                                  kShadowColor),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(
                                                                  kThemeColor)),
                                                ),
                                              )
                                            ],
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15))));
                                  },
                                  child: Container(
                                    width: size.width * 0.4,
                                    child: Image.asset(
                                        'assets/images/home/app-store-badge.png'),
                                  )),
                              SizedBox(height: size.width * 0.25),
                            ],
                          )))
                  : AnimationLimiter(
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
                                  TextSpan(text: '사장님, 이제\n'),
                                  TextSpan(
                                      text: '쏘다',
                                      style: TextStyle(
                                          color: kLogoColor,
                                          fontWeight: FontWeight.w900)),
                                  TextSpan(text: '로 쏘세요'),
                                ]),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    height: 1.4,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                              ),
                              SizedBox(height: size.height * 0.15),
                              IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Image.asset(
                                        'assets/images/home/icon.png',
                                        width: size.height * 0.3,
                                        height: size.height * 0.3,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            await canLaunch(
                                                    kGooglePlayStoreDownloadUrl)
                                                ? await launch(
                                                    kGooglePlayStoreDownloadUrl)
                                                : throw '구글 플레이 스토어에 연결할 수 없습니다.';
                                          },
                                          child: Container(
                                            height: size.height * 0.1,
                                            child: Image.asset(
                                                'assets/images/home/google-play-badge.png'),
                                          ),
                                        ),
                                        SizedBox(height: kDefaultPadding),
                                        GestureDetector(
                                            onTap: () async {
                                              await showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                          title: Center(
                                                            child: Text(
                                                                size.height
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        18,
                                                                    color:
                                                                        kDefaultFontColor),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center),
                                                          ),
                                                          content: Text(
                                                              "iOS 버전은 출시 준비 중입니다.\n조금만 기다려주세요!",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color:
                                                                      kDefaultFontColor)),
                                                          contentPadding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  15,
                                                                  15,
                                                                  15,
                                                                  5),
                                                          actions: [
                                                            Center(
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child: Text(
                                                                    '확인',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            13)),
                                                                style: ButtonStyle(
                                                                    shadowColor:
                                                                        MaterialStateProperty.all<Color>(
                                                                            kShadowColor),
                                                                    backgroundColor:
                                                                        MaterialStateProperty.all<Color>(
                                                                            kThemeColor)),
                                                              ),
                                                            )
                                                          ],
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15))));
                                            },
                                            child: Container(
                                              height: size.height * 0.1,
                                              child: Image.asset(
                                                  'assets/images/home/app-store-badge.png'),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: size.height * 0.15)
                            ],
                          ))),
            )
          : Container(
              width: size.width, height: size.height, color: kDefaultFontColor),
    );
  }
}
