import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hashchecker_web/constants.dart';
import 'package:hashchecker_web/screens/event_join/components/event_join_with_url.dart';
import 'package:hashchecker_web/screens/event_join/components/loading.dart';
import 'package:hashchecker_web/screens/event_join/components/roulette.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'event_description.dart';
import 'header_with_images.dart';
import 'event_title.dart';
import 'event_rewards.dart';
import 'event_hashtags.dart';
import 'event_requirements.dart';
import 'event_period.dart';

class Body extends StatefulWidget {
  final storeId;
  final event;
  final eventId;
  const Body(
      {Key? key,
      required this.storeId,
      required this.event,
      required this.eventId})
      : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isLoading = false;
  int _rouletteValue = -1;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(label: widget.event.title));

    return LoadingOverlay(
        child: SingleChildScrollView(
            child: Column(
          children: [
            HeaderWithImages(storeId: widget.storeId, event: widget.event),
            SizedBox(height: kDefaultPadding / 4 * 3),
            EventTitle(event: widget.event),
            SizedBox(height: kDefaultPadding),
            EventDescription(event: widget.event),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EventJoinDivider(),
                    EventRewards(event: widget.event),
                    EventJoinDivider(),
                    EventHashtags(event: widget.event),
                    EventJoinDivider(),
                    EventPeriod(event: widget.event),
                    EventJoinDivider(),
                    EventJoinWithUrl(
                        event: widget.event,
                        eventId: widget.eventId,
                        storeId: widget.storeId,
                        loading: _loading,
                        roulette: _roulette)
                  ]),
            ),
          ],
        )),
        isLoading: _isLoading || _rouletteValue != -1,
        color: Colors.black,
        opacity: 0.8,
        progressIndicator: _rouletteValue != -1
            ? Roulette(
                rouletteValue: _rouletteValue,
                rewardList: widget.event.rewardList)
            : Loading());
  }

  void _loading(bool opt) {
    setState(() {
      _isLoading = opt;
    });
  }

  void _roulette(int value) {
    setState(() {
      _rouletteValue = value;
    });
  }
}

class EventJoinDivider extends StatelessWidget {
  const EventJoinDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
        height: kDefaultPadding * 2, color: kShadowColor, thickness: 1.2);
  }
}
