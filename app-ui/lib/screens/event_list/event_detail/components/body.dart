import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/models/selected_store.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

import 'event_description.dart';
import 'header_with_images.dart';
import 'event_title.dart';
import 'event_rewards.dart';
import 'event_hashtags.dart';
import 'event_requirements.dart';
import 'event_period.dart';
import 'action_button.dart';
import 'join_qr_code.dart';

class Body extends StatefulWidget {
  final Event event;
  final int eventId;
  const Body({Key? key, required this.event, required this.eventId})
      : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    final storeId = context.read<SelectedStore>().id;

    return SingleChildScrollView(
        child: Column(
      children: [
        Screenshot(
          controller: screenshotController,
          child: Container(
            color: kScaffoldBackgroundColor,
            child: Column(
              children: [
                HeaderWithImages(
                    storeId: storeId,
                    eventId: widget.eventId,
                    event: widget.event),
                SizedBox(height: kDefaultPadding / 4 * 3),
                EventTitle(event: widget.event),
                SizedBox(height: kDefaultPadding),
                EventDescription(event: widget.event),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(height: kDefaultPadding * 2, color: kShadowColor),
                      EventRewards(event: widget.event),
                      Divider(height: kDefaultPadding * 2, color: kShadowColor),
                      EventHashtags(event: widget.event),
                      Divider(height: kDefaultPadding * 2, color: kShadowColor),
                      EventPeriod(event: widget.event),
                      Divider(height: kDefaultPadding * 2, color: kShadowColor),
                      JoinQrCode(storeId: storeId),
                      Divider(height: kDefaultPadding, color: kShadowColor),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: ActionButton(screenshotController: screenshotController),
        )
      ],
    ));
  }
}
