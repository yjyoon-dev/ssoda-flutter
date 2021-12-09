import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/store_report_overview.dart';
import 'package:number_display/number_display.dart';

class ReportOverview extends StatelessWidget {
  const ReportOverview({
    Key? key,
    required this.size,
    required this.storeReportOverview,
  }) : super(key: key);

  final Size size;
  final StoreReportOverview storeReportOverview;

  @override
  Widget build(BuildContext context) {
    final numberDisplay = createDisplay(
        length: 4,
        roundingType: RoundingType.ceil,
        units: ['K', 'M', 'G', 'T', 'P']);

    final _overviewBoxDecoration = BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: kShadowColor.withOpacity(0.25),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(1, 5), // changes position of shadow
          ),
        ],
        color: kScaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20));

    return AnimationLimiter(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 500),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: null,
              verticalOffset: -50,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 6),
                height: 135,
                width: size.width * 0.26,
                decoration: _overviewBoxDecoration,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.attach_money_rounded,
                        size: 28, color: kDefaultFontColor),
                    SizedBox(height: kDefaultPadding / 5),
                    AutoSizeText(
                      '평균 객단가',
                      minFontSize: 10,
                      maxLines: 1,
                      style: TextStyle(color: kDefaultFontColor),
                    ),
                    Divider(
                      height: 7,
                      color: kShadowColor.withOpacity(0.5),
                    ),
                    AutoSizeText.rich(
                      TextSpan(children: [
                        TextSpan(
                            text: numberDisplay(
                                        storeReportOverview.guestPrice) ==
                                    ""
                                ? '0'
                                : numberDisplay(storeReportOverview.guestPrice),
                            style: TextStyle(
                                color: kThemeColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                        TextSpan(text: ' 원')
                      ]),
                      maxLines: 1,
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 6),
                height: 135,
                width: size.width * 0.26,
                decoration: _overviewBoxDecoration,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.group_rounded,
                        size: 28, color: kDefaultFontColor),
                    SizedBox(height: kDefaultPadding / 5),
                    AutoSizeText(
                      '누적 참여자',
                      minFontSize: 10,
                      maxLines: 1,
                      style: TextStyle(color: kDefaultFontColor),
                    ),
                    Divider(
                      height: 7,
                      color: kShadowColor.withOpacity(0.5),
                    ),
                    AutoSizeText.rich(
                      TextSpan(children: [
                        TextSpan(
                            text: numberDisplay(storeReportOverview.joinCount),
                            style: TextStyle(
                                color: kThemeColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                        TextSpan(text: ' 명')
                      ]),
                      maxLines: 1,
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 6),
                height: 135,
                width: size.width * 0.26,
                decoration: _overviewBoxDecoration,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite_rounded,
                        size: 28, color: kDefaultFontColor),
                    SizedBox(height: kDefaultPadding / 5),
                    AutoSizeText(
                      '누적 좋아요',
                      minFontSize: 10,
                      maxLines: 1,
                      style: TextStyle(color: kDefaultFontColor),
                    ),
                    Divider(
                      height: 7,
                      color: kShadowColor.withOpacity(0.5),
                    ),
                    AutoSizeText.rich(
                      TextSpan(children: [
                        TextSpan(
                            text: numberDisplay(storeReportOverview.likeCount),
                            style: TextStyle(
                                color: kThemeColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                        TextSpan(text: ' 개')
                      ]),
                      maxLines: 1,
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
