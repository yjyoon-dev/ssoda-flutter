import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event_report_item.dart';
import 'package:hashchecker/models/event_report_per_period.dart';
import 'package:hashchecker/models/event_report_total_sum.dart';

import 'components/daily_report.dart';
import 'components/monthly_report.dart';
import 'components/total_report.dart';
import 'components/weekly_report.dart';

class EventReportScreen extends StatefulWidget {
  const EventReportScreen(
      {Key? key,
      required this.eventReportItem,
      required this.eventDayReport,
      required this.eventWeekReport,
      required this.eventMonthReport,
      required this.eventTotalReport})
      : super(key: key);

  final EventReportItem eventReportItem;
  final EventReportPerPeriod eventDayReport;
  final EventReportPerPeriod eventWeekReport;
  final EventReportPerPeriod eventMonthReport;
  final EventReportTotalSum eventTotalReport;

  @override
  _EventReportScreenState createState() => _EventReportScreenState();
}

class _EventReportScreenState extends State<EventReportScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: DefaultTabController(
      length: 4,
      child: NestedScrollView(
          headerSliverBuilder: (context, ext) => [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 25, 20),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.close)),
                    )
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.fromLTRB(20, 10, 0, 15),
                    title: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            widget.eventReportItem.title,
                            style: TextStyle(color: Colors.white, fontSize: 14),
                            maxLines: 1,
                          ),
                          AutoSizeText(
                            '마케팅 성과 보고서',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            maxLines: 1,
                          )
                        ]),
                    background: Stack(children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              '$s3Url${widget.eventReportItem.thumbnail}',
                            ),
                          ),
                        ),
                        height: size.height * 0.4,
                      ),
                      Container(
                        height: size.height * 0.4,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            gradient: LinearGradient(
                                begin: FractionalOffset.center,
                                end: FractionalOffset.bottomCenter,
                                colors: [
                                  Colors.transparent.withOpacity(0.0),
                                  Colors.black.withOpacity(0.7),
                                ],
                                stops: [
                                  0.0,
                                  1.0
                                ])),
                      )
                    ]),
                  ),
                  backgroundColor: kDefaultFontColor.withOpacity(0.87),
                  foregroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0))),
                  expandedHeight: size.height * 0.3,
                  pinned: true,
                ),
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      indicatorColor: kDefaultFontColor,
                      labelColor: kDefaultFontColor,
                      unselectedLabelColor: kLiteFontColor.withOpacity(0.8),
                      tabs: [
                        Tab(text: "일 별"),
                        Tab(text: "주 별"),
                        Tab(text: "월 별"),
                        Tab(text: "종 합"),
                      ],
                    ),
                  ),
                  pinned: true,
                )
              ],
          body: TabBarView(
            children: [
              DailyReport(
                  eventReport: widget.eventDayReport,
                  eventRewardCount:
                      widget.eventReportItem.rewardNameList!.length),
              WeeklyReport(
                  eventReport: widget.eventWeekReport,
                  eventRewardCount:
                      widget.eventReportItem.rewardNameList!.length),
              MonthlyReport(
                  eventReport: widget.eventMonthReport,
                  eventRewardCount:
                      widget.eventReportItem.rewardNameList!.length),
              TotalReport(
                  eventReport: widget.eventTotalReport,
                  eventRewardCount:
                      widget.eventReportItem.rewardNameList!.length)
            ],
          )),
    ));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _tabBar,
      decoration: BoxDecoration(color: kScaffoldBackgroundColor, boxShadow: [
        BoxShadow(
            color: kShadowColor,
            offset: Offset(0.0, 1.0),
            blurRadius: 1.0,
            spreadRadius: 0.7),
      ]),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
