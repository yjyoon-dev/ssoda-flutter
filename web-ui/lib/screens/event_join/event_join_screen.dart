import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker_web/api.dart';
import 'package:hashchecker_web/constants.dart';
import 'package:hashchecker_web/models/event.dart';
import 'package:hashchecker_web/models/reward.dart';
import 'components/body.dart';

class EventJoinScreen extends StatefulWidget {
  final storeId;
  final eventId;
  const EventJoinScreen(
      {Key? key, required this.storeId, required this.eventId})
      : super(key: key);

  @override
  _EventJoinScreenState createState() => _EventJoinScreenState();
}

class _EventJoinScreenState extends State<EventJoinScreen> {
  late Future<Event> event;
  @override
  void initState() {
    super.initState();
    event = _fetchEventData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<Event>(
            future: event,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Body(
                    storeId: widget.storeId,
                    event: snapshot.data!,
                    eventId: widget.eventId);
              } else if (snapshot.hasError) {
                return buildErrorPage(
                    message: '존재하지 않는 이벤트이거나\n네트워크에 연결할 수 없습니다.');
              }

              return Center(child: const CircularProgressIndicator());
            }));
  }

  Future<List<Reward>> _fetchRewardListData() async {
    var dio = Dio();

    final getRewardListResponse = await dio.get(
        getApi(API.GET_REWARD_OF_EVENT, suffix: '/${widget.eventId}/rewards'));

    final fetchedRewardList = getRewardListResponse.data;

    List<Reward> rewardList = List.generate(fetchedRewardList.length,
        (index) => Reward.fromJson(fetchedRewardList[index]));

    rewardList.sort((a, b) => a.level.compareTo(b.level));

    return rewardList;
  }

  Future<Event> _fetchEventData() async {
    List<Reward> _rewardList = await _fetchRewardListData();

    var dio = Dio();

    final getEventResponse =
        await dio.get(getApi(API.GET_EVENT, suffix: '/${widget.eventId}'));

    final fetchedEvent = getEventResponse.data;

    Event event = Event.fromJson(fetchedEvent);
    event.rewardList = _rewardList;

    return event;
  }
}
