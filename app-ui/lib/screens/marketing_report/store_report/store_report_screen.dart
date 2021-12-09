import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/models/event_report.dart';
import 'package:hashchecker/models/event_report_item.dart';
import 'package:hashchecker/models/event_report_per_period.dart';
import 'package:hashchecker/models/selected_store.dart';
import 'package:hashchecker/models/store_report.dart';
import 'package:hashchecker/models/store_report_overview.dart';
import 'package:hashchecker/models/event_report_total_sum.dart';
import 'package:hashchecker/screens/event_list/components/empty.dart';
import 'package:hashchecker/screens/marketing_report/store_report/components/event_report_card.dart';
import 'package:number_display/number_display.dart';
import 'package:provider/provider.dart';
import 'components/report_overview.dart';

class StoreReportScreen extends StatefulWidget {
  const StoreReportScreen({Key? key}) : super(key: key);

  @override
  _StoreReportScreenState createState() => _StoreReportScreenState();
}

class _StoreReportScreenState extends State<StoreReportScreen> {
  final eventSortDropdownItemList = [
    '최신 등록 순',
    '높은 객단가 순',
    '낮은 객단가 순',
    '높은 참가자 순',
    '낮은 참가자 순',
    '높은 좋아요 순',
    '낮은 좋아요 순'
  ];

  String dropdownValue = '최신 등록 순';

  final numberDisplay = createDisplay();

  late Future<StoreReportOverview> storeReportOverview;
  late Future<List<EventReport>> eventReportList;

  @override
  void initState() {
    super.initState();
    eventReportList = _fetchEventReportData();
    storeReportOverview = _fetchStoreReportData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '마케팅 성과',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: kDefaultFontColor),
              ),
              SizedBox(height: kDefaultPadding / 5 * 6),
              FutureBuilder<StoreReportOverview>(
                  future: storeReportOverview,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ReportOverview(
                          size: size, storeReportOverview: snapshot.data!);
                    } else if (snapshot.hasError) {
                      return buildErrorPage();
                    }

                    return Center(child: const CircularProgressIndicator());
                  }),
              SizedBox(height: kDefaultPadding * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '이벤트 별 보고서',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: kDefaultFontColor),
                  ),
                  DropdownButton(
                      dropdownColor: kScaffoldBackgroundColor.withOpacity(0.9),
                      value: dropdownValue,
                      icon: const Icon(
                        Icons.sort_rounded,
                        color: kDefaultFontColor,
                        size: 20,
                      ),
                      iconSize: 24,
                      elevation: 0,
                      style: TextStyle(
                        color: kDefaultFontColor,
                        fontSize: 13,
                      ),
                      underline: Container(
                        height: 0,
                        color: kDefaultFontColor,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                          eventReportList = _fetchEventReportData();
                        });
                      },
                      items: eventSortDropdownItemList.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: SizedBox(
                              width: 85,
                              child: Text(
                                value,
                                style: TextStyle(
                                    fontSize: 13, color: kDefaultFontColor),
                                textAlign: TextAlign.center,
                              )),
                        );
                      }).toList())
                ],
              ),
              SizedBox(height: kDefaultPadding / 3 * 1),
              FutureBuilder<List<EventReport>>(
                  future: eventReportList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return AnimationLimiter(
                          child: snapshot.data!.length == 0
                              ? Empty()
                              : Column(
                                  children:
                                      AnimationConfiguration.toStaggeredList(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          childAnimationBuilder: (widget) =>
                                              SlideAnimation(
                                                horizontalOffset: 100,
                                                child: FadeInAnimation(
                                                  child: widget,
                                                ),
                                              ),
                                          children: List.generate(
                                            snapshot.data!.length,
                                            (index) => EventReportCard(
                                                eventReportItem: snapshot
                                                    .data![index]
                                                    .eventReportItem,
                                                eventDayReport: snapshot
                                                    .data![index]
                                                    .eventDayReport,
                                                eventWeekReport: snapshot
                                                    .data![index]
                                                    .eventWeekReport,
                                                eventMonthReport: snapshot
                                                    .data![index]
                                                    .eventMonthReport,
                                                eventTotalReport: snapshot
                                                    .data![index]
                                                    .eventTotalReport,
                                                numberDisplay: numberDisplay),
                                          )),
                                ));
                    } else if (snapshot.hasError) {
                      return buildErrorPage();
                    }

                    return Center(child: const CircularProgressIndicator());
                  }),
              SizedBox(height: 70)
            ],
          ),
        ),
      ),
    );
  }

  Future<List<EventReport>> _fetchEventReportData() async {
    final storeId = context.read<SelectedStore>().id;
    var dio = await authDio(context);

    final getStoreResponse =
        await dio.get(getApi(API.GET_STORE, suffix: '/$storeId'));

    var eventIdsFromJson = getStoreResponse.data['eventIds'];
    final List<int> eventIdList = eventIdsFromJson.cast<int>();

    List<EventReport> eventReportList = [];

    for (int i = 0; i < eventIdList.length; i++) {
      final getEventReportResponse = await dio
          .get(getApi(API.GET_REPORT_OF_EVENT, suffix: '/${eventIdList[i]}'));
      final fetchedEventReportData = getEventReportResponse.data;

      final EventReportItem reportItem =
          EventReportItem.fromJson(fetchedEventReportData['event']);

      if (reportItem.status == EventStatus.WAITING) continue;

      final EventReportPerPeriod dayReport = EventReportPerPeriod.fromJson(
          fetchedEventReportData['report']['day']);
      final EventReportPerPeriod weekReport = EventReportPerPeriod.fromJson(
          fetchedEventReportData['report']['week']);
      final EventReportPerPeriod monthReport = EventReportPerPeriod.fromJson(
          fetchedEventReportData['report']['month']);
      final EventReportTotalSum totalReport = EventReportTotalSum.fromJson(
          fetchedEventReportData['report']['total']);

      // get rewardNameList of event
      final getRewardListResponse = await dio.get(getApi(
          API.GET_REWARD_OF_EVENT,
          suffix: '/${eventIdList[i]}/rewards'));
      final fetchedRewardListData = getRewardListResponse.data;

      final List<String> rewardNameList = List.generate(
          fetchedRewardListData.length,
          (index) => fetchedRewardListData[index]['name']);

      // set additional info of EventListItem
      reportItem.likeCount = totalReport.likeCount;
      reportItem.joinCount = totalReport.participateCount;
      reportItem.guestPrice =
          totalReport.expenditureCount / totalReport.exposureCount;
      reportItem.rewardNameList = rewardNameList;

      eventReportList.add(EventReport(
          eventReportItem: reportItem,
          eventDayReport: dayReport,
          eventWeekReport: weekReport,
          eventMonthReport: monthReport,
          eventTotalReport: totalReport));
    }

    if (dropdownValue == "최신 등록 순") {
      eventReportList = List.from(eventReportList.reversed);
    } else if (dropdownValue == "높은 객단가 순")
      eventReportList.sort((a, b) => b.eventReportItem.guestPrice!
          .compareTo(a.eventReportItem.guestPrice!));
    else if (dropdownValue == "낮은 객단가 순")
      eventReportList.sort((a, b) => a.eventReportItem.guestPrice!
          .compareTo(b.eventReportItem.guestPrice!));
    else if (dropdownValue == "높은 참가자 순")
      eventReportList.sort((a, b) =>
          b.eventReportItem.joinCount!.compareTo(a.eventReportItem.joinCount!));
    else if (dropdownValue == "낮은 참가자 순")
      eventReportList.sort((a, b) =>
          a.eventReportItem.joinCount!.compareTo(b.eventReportItem.joinCount!));
    else if (dropdownValue == "높은 좋아요 순")
      eventReportList.sort((a, b) =>
          b.eventReportItem.likeCount!.compareTo(a.eventReportItem.likeCount!));
    else if (dropdownValue == "낮은 좋아요 순")
      eventReportList.sort((a, b) =>
          a.eventReportItem.likeCount!.compareTo(b.eventReportItem.likeCount!));

    return eventReportList;
  }

  Future<StoreReportOverview> _fetchStoreReportData() async {
    final storeId = context.read<SelectedStore>().id;
    var dio = await authDio(context);
    final getStoreReportResponse =
        await dio.get(getApi(API.GET_REPORT_OF_STORE, suffix: '/$storeId'));
    final fetchedStoreReportData = getStoreReportResponse.data['report'];

    final StoreReport storeReport =
        StoreReport.fromJson(fetchedStoreReportData);

    final likeSum = storeReport.likeCount;
    final participateSum = storeReport.participateCount;
    final expenditureSum = storeReport.expenditureCount;
    final exposureSum = storeReport.exposureCount;
    final guestPrice = exposureSum == 0 ? 0.0 : expenditureSum / exposureSum;

    final StoreReportOverview storeReportOverview = StoreReportOverview(
        guestPrice: guestPrice, joinCount: participateSum, likeCount: likeSum);

    return storeReportOverview;
  }
}
