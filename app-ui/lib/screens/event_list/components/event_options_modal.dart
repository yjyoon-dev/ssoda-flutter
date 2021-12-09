import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/models/event_edit_data.dart';
import 'package:hashchecker/models/event_report.dart';
import 'package:hashchecker/models/event_report_item.dart';
import 'package:hashchecker/models/event_report_total_sum.dart';
import 'package:hashchecker/models/event_report_per_period.dart';
import 'package:hashchecker/screens/event_list/event_detail/event_detail_screen.dart';
import 'package:hashchecker/screens/event_list/event_edit/event_edit_modal.dart';
import 'package:hashchecker/screens/hall/hall_screen.dart';
import 'package:hashchecker/screens/marketing_report/event_report/event_report_screen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class EventOptionsModal extends StatelessWidget {
  final int eventId;
  final EventStatus eventStatus;
  final bool isAlreadyInPreview;
  EventOptionsModal(
      {Key? key,
      required this.eventId,
      required this.eventStatus,
      required this.isAlreadyInPreview})
      : super(key: key);

  EventReport? eventReport;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (!isAlreadyInPreview)
            ListTile(
                title: Text('이벤트 미리보기',
                    style: TextStyle(
                        color: kDefaultFontColor.withOpacity(0.8),
                        fontSize: 15)),
                leading: Icon(Icons.description_rounded,
                    color: kDefaultFontColor.withOpacity(0.8)),
                onTap: () => Navigator.push(
                    context,
                    slidePageRouting(EventDetailScreen(
                        eventId: eventId, eventStatus: eventStatus)))),
          ListTile(
            enabled: _isEnableToEdit(),
            title: Text('이벤트 편집',
                style: TextStyle(
                    color: _isEnableToEdit()
                        ? kDefaultFontColor.withOpacity(0.8)
                        : kLiteFontColor.withOpacity(0.5),
                    fontSize: 15)),
            leading: Icon(Icons.edit_rounded,
                color: _isEnableToEdit()
                    ? kDefaultFontColor.withOpacity(0.8)
                    : kLiteFontColor.withOpacity(0.5)),
            onTap: () => showBarModalBottomSheet(
              expand: true,
              context: context,
              builder: (context) => Provider(
                  create: (_) => EventEditData(),
                  child: EventEditModal(eventId: eventId)),
            ),
          ),
          ListTile(
              title: Text('마케팅 보고서',
                  style: TextStyle(
                      color: kDefaultFontColor.withOpacity(0.8), fontSize: 15)),
              leading: Icon(Icons.assessment_rounded,
                  color: kDefaultFontColor.withOpacity(0.8)),
              onTap: () async {
                await showProgressDialog(context, _loadEventReport(context));
                Navigator.pop(context);
                if (eventReport != null)
                  Navigator.of(context).push(slidePageRouting(EventReportScreen(
                      eventReportItem: eventReport!.eventReportItem,
                      eventDayReport: eventReport!.eventDayReport,
                      eventWeekReport: eventReport!.eventWeekReport,
                      eventMonthReport: eventReport!.eventMonthReport,
                      eventTotalReport: eventReport!.eventTotalReport)));
              }),
          ListTile(
            enabled: _isEnableToStop(),
            title: Text('이벤트 중지',
                style: TextStyle(
                    color: _isEnableToStop()
                        ? kDefaultFontColor.withOpacity(0.8)
                        : kLiteFontColor.withOpacity(0.5),
                    fontSize: 15)),
            leading: Icon(Icons.stop_rounded,
                color: _isEnableToStop()
                    ? kDefaultFontColor.withOpacity(0.8)
                    : kLiteFontColor.withOpacity(0.5)),
            onTap: () => _showEventStopDialog(context),
          ),
          ListTile(
            enabled: _isEnableToDelete(),
            title: Text('이벤트 삭제',
                style: TextStyle(
                    color: _isEnableToDelete()
                        ? Colors.red
                        : kLiteFontColor.withOpacity(0.5),
                    fontSize: 15)),
            leading: Icon(Icons.delete_rounded,
                color: _isEnableToDelete()
                    ? Colors.red
                    : kLiteFontColor.withOpacity(0.5)),
            onTap: () => _showEventDeleteDialog(context),
          )
        ],
      ),
    ));
  }

  bool _isEnableToStop() {
    return eventStatus == EventStatus.PROCEEDING;
  }

  bool _isEnableToDelete() {
    return eventStatus == EventStatus.ENDED;
  }

  bool _isEnableToEdit() {
    return eventStatus != EventStatus.ENDED;
  }

  void _showEventDeleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Center(
              child: Text('이벤트 삭제',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: kDefaultFontColor),
                  textAlign: TextAlign.center),
            ),
            content: IntrinsicHeight(
              child: Column(children: [
                Text("이벤트 삭제 시 이벤트가",
                    style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
                SizedBox(height: kDefaultPadding / 5),
                Text("즉시 종료되며 복구할 수 없습니다.",
                    style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
                SizedBox(height: kDefaultPadding / 5),
                Text("그래도 삭제하시겠습니까?",
                    style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
              ]),
            ),
            contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
            actions: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await _deleteEvent(context, eventId);
                        Navigator.of(context).pop();
                        await _showEventDeleteCompleteDialog(context);
                      },
                      child: Text('삭제', style: TextStyle(color: Colors.red)),
                      style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all<Color>(
                              Colors.red.withOpacity(0.1))),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('취소'),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red)),
                    ),
                  ],
                ),
              )
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))));
  }

  Future<void> _showEventDeleteCompleteDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Center(
              child: Text('이벤트 삭제',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: kDefaultFontColor),
                  textAlign: TextAlign.center),
            ),
            content: Text("이벤트 삭제가 완료되었습니다",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
            contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
            actions: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HallScreen(),
                        ),
                        (Route<dynamic> route) => false);
                  },
                  child: Text('확인', style: TextStyle(fontSize: 13)),
                  style: ButtonStyle(
                      shadowColor:
                          MaterialStateProperty.all<Color>(kShadowColor),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kThemeColor)),
                ),
              )
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))));
    Navigator.pop(context);
  }

  void _showEventStopDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Center(
              child: Text('이벤트 중지',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: kDefaultFontColor),
                  textAlign: TextAlign.center),
            ),
            content: IntrinsicHeight(
              child: Column(children: [
                Text("이벤트를 중지하면 고객들이 더 이상",
                    style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
                SizedBox(height: kDefaultPadding / 5),
                Text("이벤트에 참여할 수 없게 됩니다.",
                    style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
                SizedBox(height: kDefaultPadding / 5),
                Text("그래도 중지하시겠습니까?",
                    style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
              ]),
            ),
            contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
            actions: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await _stopEvent(context, eventId);
                        Navigator.of(context).pop();
                        await _showEventStopCompleteDialog(context);
                      },
                      child: Text('중지',
                          style: TextStyle(color: Colors.redAccent.shade400)),
                      style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all<Color>(
                              Colors.redAccent.shade400.withOpacity(0.1))),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('취소'),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.redAccent.shade400)),
                    ),
                  ],
                ),
              )
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))));
  }

  Future<void> _stopEvent(BuildContext context, int eventId) async {
    var dio = await authDio(context);
    final eventStopResponse = await dio.put(
        getApi(API.STOP_EVENT, suffix: '/$eventId/status'),
        data: {'status': EventStatus.ENDED.index});
    print(eventStopResponse.data);
  }

  Future<void> _deleteEvent(BuildContext context, int eventId) async {
    var dio = await authDio(context);
    final eventDeleteResponse =
        await dio.delete(getApi(API.DELETE_EVENT, suffix: '/$eventId'));
    print(eventDeleteResponse.data);
  }

  Future<void> _showEventStopCompleteDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Center(
              child: Text('이벤트 중지',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: kDefaultFontColor),
                  textAlign: TextAlign.center),
            ),
            content: Text("이벤트가 중지되었습니다.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
            contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
            actions: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HallScreen(),
                        ),
                        (Route<dynamic> route) => false);
                  },
                  child: Text('확인', style: TextStyle(fontSize: 13)),
                  style: ButtonStyle(
                      shadowColor:
                          MaterialStateProperty.all<Color>(kShadowColor),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kThemeColor)),
                ),
              )
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))));
    Navigator.pop(context);
  }

  Future<void> _loadEventReport(BuildContext context) async {
    var dio = await authDio(context);

    final getEventReportResponse =
        await dio.get(getApi(API.GET_REPORT_OF_EVENT, suffix: '/$eventId'));
    final fetchedEventReportData = getEventReportResponse.data;

    final EventReportItem reportItem =
        EventReportItem.fromJson(fetchedEventReportData['event']);
    final EventReportPerPeriod dayReport =
        EventReportPerPeriod.fromJson(fetchedEventReportData['report']['day']);
    final EventReportPerPeriod weekReport =
        EventReportPerPeriod.fromJson(fetchedEventReportData['report']['week']);
    final EventReportPerPeriod monthReport = EventReportPerPeriod.fromJson(
        fetchedEventReportData['report']['month']);
    final EventReportTotalSum totalReport =
        EventReportTotalSum.fromJson(fetchedEventReportData['report']['total']);

    final getRewardListResponse = await dio
        .get(getApi(API.GET_REWARD_OF_EVENT, suffix: '/$eventId/rewards'));
    final fetchedRewardListData = getRewardListResponse.data;

    final List<String> rewardNameList = List.generate(
        fetchedRewardListData.length,
        (index) => fetchedRewardListData[index]['name']);

    reportItem.rewardNameList = rewardNameList;

    eventReport = EventReport(
        eventReportItem: reportItem,
        eventDayReport: dayReport,
        eventWeekReport: weekReport,
        eventMonthReport: monthReport,
        eventTotalReport: totalReport);
  }
}
