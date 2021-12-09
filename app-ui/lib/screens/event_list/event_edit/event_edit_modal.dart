import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/models/reward.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'components/body.dart';

class EventEditModal extends StatefulWidget {
  final int eventId;
  const EventEditModal({Key? key, required this.eventId}) : super(key: key);

  @override
  _EventEditModalState createState() => _EventEditModalState();
}

class _EventEditModalState extends State<EventEditModal> {
  late Future<Event> event;
  late TextEditingController _eventTitleController;
  DateRangePickerController _startDatePickerController =
      DateRangePickerController();
  DateRangePickerController _finishDatePickerController =
      DateRangePickerController();

  Future<List<Reward?>> _fetchRewardListData() async {
    var dio = await authDio(context);

    final getRewardListResponse = await dio.get(
        getApi(API.GET_REWARD_OF_EVENT, suffix: '/${widget.eventId}/rewards'));

    final fetchedRewardList = getRewardListResponse.data;

    List<Reward?> rewardList = List.generate(fetchedRewardList.length,
        (index) => Reward.fromJson(fetchedRewardList[index]));

    rewardList.sort((a, b) => a!.level.compareTo(b!.level));

    if (rewardList.length < MAX_REWARD_COUNT) rewardList.add(null);
    return rewardList;
  }

  Future<Event> _fetchEventData() async {
    List<Reward?> _rewardList = await _fetchRewardListData();

    var dio = await authDio(context);

    final getEventResponse =
        await dio.get(getApi(API.GET_EVENT, suffix: '/${widget.eventId}'));

    final fetchedEvent = getEventResponse.data;

    Event event = Event.fromJson(fetchedEvent);
    event.rewardList = _rewardList;

    if (event.images.length < 3) event.images.add(null);
    _eventTitleController = TextEditingController(text: event.title);
    _startDatePickerController.selectedDate = event.period.startDate;
    _finishDatePickerController.selectedDate = event.period.finishDate;

    return event;
  }

  @override
  void initState() {
    super.initState();
    event = _fetchEventData();
  }

  @override
  void dispose() {
    _eventTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: WillPopScope(
        onWillPop: () async {
          bool shouldClose = true;
          await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                  title: Center(
                    child: Text('이벤트 수정',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: kDefaultFontColor),
                        textAlign: TextAlign.center),
                  ),
                  content: IntrinsicHeight(
                    child: Column(children: [
                      Text("저장되지 않은 내용이 있습니다.",
                          style: TextStyle(
                              fontSize: 14, color: kDefaultFontColor)),
                      SizedBox(height: kDefaultPadding / 5),
                      Text("그래도 나가시겠습니까?",
                          style: TextStyle(
                              fontSize: 14, color: kDefaultFontColor)),
                    ]),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                  actions: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('예',
                                style: TextStyle(
                                    color: kThemeColor, fontSize: 13)),
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all<Color>(
                                    kThemeColor.withOpacity(0.2))),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              shouldClose = false;
                              Navigator.of(context).pop();
                            },
                            child: Text('아니오', style: TextStyle(fontSize: 13)),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        kThemeColor)),
                          ),
                        ],
                      ),
                    )
                  ],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))));
          return shouldClose;
        },
        child: FutureBuilder<Event>(
            future: event,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Body(
                    eventId: widget.eventId,
                    event: snapshot.data!,
                    eventTitleController: _eventTitleController,
                    startDatePickerController: _startDatePickerController,
                    finishDatePickerController: _finishDatePickerController);
              } else if (snapshot.hasError) {
                return buildErrorPage();
              }

              return Center(child: const CircularProgressIndicator());
            }),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kScaffoldBackgroundColor,
      elevation: 1,
      title: Text(
        '이벤트 수정',
        style: TextStyle(
            color: kDefaultFontColor,
            fontSize: 19,
            fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }
}
