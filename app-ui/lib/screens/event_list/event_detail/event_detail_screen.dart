import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/models/reward.dart';
import 'package:hashchecker/screens/event_list/components/event_options_modal.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'components/body.dart';

class EventDetailScreen extends StatefulWidget {
  final eventId;
  final eventStatus;
  const EventDetailScreen(
      {Key? key, required this.eventId, required this.eventStatus})
      : super(key: key);

  @override
  _EventDetailScreenState createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen>
    with TickerProviderStateMixin {
  late Future<Event> event;
  late AnimationController _colorAnimationController;
  late Animation _colorTween, _iconColorTween;

  @override
  void initState() {
    _colorAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _colorTween = ColorTween(begin: Colors.transparent, end: Colors.white)
        .animate(_colorAnimationController);
    _iconColorTween = ColorTween(begin: Colors.white, end: kDefaultFontColor)
        .animate(_colorAnimationController);
    ;
    super.initState();

    event = _fetchEventData();
  }

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      _colorAnimationController.animateTo(scrollInfo.metrics.pixels / 130);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
        body: NotificationListener<ScrollNotification>(
      onNotification: _scrollListener,
      child: Container(
        height: double.infinity,
        child: Stack(children: [
          FutureBuilder<Event>(
              future: event,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Body(event: snapshot.data!, eventId: widget.eventId),
                  );
                } else if (snapshot.hasError) {
                  return buildErrorPage();
                }

                return Center(child: const CircularProgressIndicator());
              }),
          Container(
            height: statusBarHeight + kToolbarHeight,
            child: AnimatedBuilder(
              animation: _colorAnimationController,
              builder: (context, build) => AppBar(
                elevation: 0,
                backgroundColor: _colorTween.value,
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new_rounded),
                    color: _iconColorTween.value),
                actions: [
                  IconButton(
                      onPressed: () => showMaterialModalBottomSheet(
                          backgroundColor: _colorTween.value,
                          expand: false,
                          context: context,
                          builder: (context) => EventOptionsModal(
                              eventId: widget.eventId,
                              eventStatus: widget.eventStatus,
                              isAlreadyInPreview: true)),
                      icon: Icon(Icons.more_vert_rounded,
                          color: _iconColorTween.value))
                ],
              ),
            ),
          )
        ]),
      ),
    ));
  }

  Future<List<Reward>> _fetchRewardListData() async {
    var dio = await authDio(context);

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

    var dio = await authDio(context);

    final getEventResponse =
        await dio.get(getApi(API.GET_EVENT, suffix: '/${widget.eventId}'));

    final fetchedEvent = getEventResponse.data;

    Event event = Event.fromJson(fetchedEvent);
    event.rewardList = _rewardList;

    return event;
  }
}
