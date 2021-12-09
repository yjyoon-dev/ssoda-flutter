import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/models/event_report_per_period.dart';
import 'package:hashchecker/models/event_report_total_sum.dart';
import 'package:hashchecker/screens/marketing_report/event_report/event_report_screen.dart';
import 'package:number_display/number_display.dart';
import 'package:hashchecker/models/event_report_item.dart';

class EventReportCard extends StatelessWidget {
  const EventReportCard({
    Key? key,
    required this.eventReportItem,
    required this.eventDayReport,
    required this.eventWeekReport,
    required this.eventMonthReport,
    required this.eventTotalReport,
    required this.numberDisplay,
  }) : super(key: key);

  final EventReportItem eventReportItem;
  final EventReportPerPeriod eventDayReport;
  final EventReportPerPeriod eventWeekReport;
  final EventReportPerPeriod eventMonthReport;
  final EventReportTotalSum eventTotalReport;
  final Display numberDisplay;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        margin: const EdgeInsets.only(bottom: kDefaultPadding),
        child: Card(
            color: kScaffoldBackgroundColor,
            shadowColor: kShadowColor,
            elevation: 12,
            child: OpenContainer<bool>(
                openColor: kScaffoldBackgroundColor,
                openElevation: 0,
                openShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                closedColor: kScaffoldBackgroundColor,
                closedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                closedElevation: 0,
                transitionType: ContainerTransitionType.fade,
                openBuilder: (context, _) => EventReportScreen(
                    eventReportItem: eventReportItem,
                    eventDayReport: eventDayReport,
                    eventWeekReport: eventWeekReport,
                    eventMonthReport: eventMonthReport,
                    eventTotalReport: eventTotalReport),
                closedBuilder: (context, openContainer) => InkWell(
                      highlightColor: kShadowColor,
                      overlayColor:
                          MaterialStateProperty.all<Color>(kShadowColor),
                      onTap: openContainer,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                            child: Stack(
                              children: [
                                Image.network(
                                    '$s3Url${eventReportItem.thumbnail}',
                                    fit: BoxFit.cover,
                                    width: size.width,
                                    height: size.width / 16 * 9),
                                Positioned(
                                    bottom: 15,
                                    right: 15,
                                    child: Container(
                                      padding:
                                          const EdgeInsets.fromLTRB(4, 1, 4, 2),
                                      width: 60,
                                      child: Center(
                                        child: Text(
                                          eventReportItem.status ==
                                                  EventStatus.PROCEEDING
                                              ? '진행 중'
                                              : '종료',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      color: eventReportItem.status ==
                                              EventStatus.PROCEEDING
                                          ? Colors.greenAccent.shade700
                                          : Colors.grey.shade600,
                                    ))
                              ],
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(15, 10, 15, 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AutoSizeText(eventReportItem.title,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: kDefaultFontColor),
                                      maxLines: 1,
                                      minFontSize: 12),
                                  SizedBox(height: kDefaultPadding),
                                  IntrinsicHeight(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(children: [
                                            Icon(
                                              Icons.attach_money_rounded,
                                              size: 20,
                                              color: Colors.blueGrey,
                                            ),
                                            Text(
                                              '${numberDisplay(eventReportItem.guestPrice) == "" ? '0' : numberDisplay(eventReportItem.guestPrice)}원',
                                              style: TextStyle(
                                                  color: kLiteFontColor,
                                                  fontSize: 12),
                                            ),
                                          ]),
                                        ),
                                        VerticalDivider(
                                          width: kDefaultPadding,
                                          color: kShadowColor.withOpacity(0.6),
                                        ),
                                        Expanded(
                                          child: Column(children: [
                                            Icon(
                                              Icons.group_rounded,
                                              size: 20,
                                              color: Colors.blueGrey,
                                            ),
                                            SizedBox(
                                                width: kDefaultPadding / 3),
                                            Text(
                                                '${numberDisplay(eventReportItem.joinCount)}명',
                                                style: TextStyle(
                                                    color: kLiteFontColor,
                                                    fontSize: 12)),
                                          ]),
                                        ),
                                        VerticalDivider(
                                          width: kDefaultPadding,
                                          color: kShadowColor.withOpacity(0.6),
                                        ),
                                        Expanded(
                                          child: Column(children: [
                                            Icon(
                                              Icons.favorite_rounded,
                                              size: 20,
                                              color: Colors.blueGrey,
                                            ),
                                            SizedBox(
                                                width: kDefaultPadding / 3),
                                            Text(
                                                '${numberDisplay(eventReportItem.likeCount)}개',
                                                style: TextStyle(
                                                    color: kLiteFontColor,
                                                    fontSize: 12)),
                                          ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: kDefaultPadding / 2),
                                  Wrap(
                                      direction: Axis.horizontal,
                                      spacing: 5.0,
                                      children: List.generate(
                                        eventReportItem.rewardNameList!.length,
                                        (rewardIndex) => Chip(
                                          label: Text(
                                            eventReportItem
                                                .rewardNameList![rewardIndex],
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: kDefaultFontColor),
                                          ),
                                          padding: const EdgeInsets.all(2),
                                          backgroundColor:
                                              kThemeColor.withOpacity(0.2),
                                        ),
                                      )),
                                ],
                              )),
                        ],
                      ),
                    )),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))));
  }
}
