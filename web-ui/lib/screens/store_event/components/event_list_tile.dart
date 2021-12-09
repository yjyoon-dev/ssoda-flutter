import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker_web/api.dart';
import 'package:hashchecker_web/constants.dart';
import 'package:hashchecker_web/models/event.dart';
import 'package:hashchecker_web/screens/event_join/event_join_screen.dart';

class EventListTile extends StatelessWidget {
  const EventListTile({
    Key? key,
    required this.eventListItem,
    required this.size,
    required this.storeId,
    required Map<EventStatus, String> statusStringMap,
    required Map<EventStatus, Color> statusColorMap,
  })  : _statusStringMap = statusStringMap,
        _statusColorMap = statusColorMap,
        super(key: key);

  final eventListItem;
  final Size size;
  final storeId;
  final Map<EventStatus, String> _statusStringMap;
  final Map<EventStatus, Color> _statusColorMap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 144,
      child: OpenContainer<bool>(
          openColor: Colors.white.withOpacity(0),
          openElevation: 0,
          openShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          closedColor: Colors.white.withOpacity(0),
          closedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          closedElevation: 0,
          transitionType: ContainerTransitionType.fade,
          openBuilder: (context, _) =>
              EventJoinScreen(storeId: storeId, eventId: eventListItem.id),
          closedBuilder: (context, openContainer) => Stack(children: [
                Positioned(
                    bottom: 15,
                    right: 20,
                    child: Container(
                        width: size.width * 0.7,
                        height: 100,
                        child: Material(
                          color: Colors.white.withOpacity(0.0),
                          child: InkWell(
                            highlightColor: kShadowColor,
                            overlayColor:
                                MaterialStateProperty.all<Color>(kShadowColor),
                            borderRadius: BorderRadius.circular(12),
                            onTap: openContainer,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 15, 10),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: size.width * 0.20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        AutoSizeText(
                                          eventListItem.title,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: kDefaultFontColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          minFontSize: 8,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: kDefaultPadding / 3),
                                        Text(
                                            '${eventListItem.startDate} ~ ${eventListItem.finishDate}',
                                            style: TextStyle(
                                                color: kLiteFontColor,
                                                fontSize: 11)),
                                        SizedBox(height: kDefaultPadding),
                                        IntrinsicHeight(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 4, 8, 4),
                                                child: Text(
                                                    _statusStringMap[
                                                        eventListItem.status]!,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: _statusColorMap[
                                                            eventListItem
                                                                .status],
                                                        fontWeight: eventListItem
                                                                    .status ==
                                                                EventStatus
                                                                    .PROCEEDING
                                                            ? FontWeight.bold
                                                            : FontWeight
                                                                .normal)),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: kShadowColor,
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset:
                                    Offset(3, 3), // changes position of shadow
                              ),
                            ],
                            color: kScaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(12)))),
                Positioned(
                    top: 15,
                    left: 20,
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child: Image.network(
                          '$s3Url${eventListItem.thumbnail}',
                          width: size.width * 0.37,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: kShadowColor,
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset:
                                  Offset(-3, 3), // changes position of shadow
                            ),
                          ],
                          color: kScaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(12)),
                    )),
              ])),
    );
  }
}
