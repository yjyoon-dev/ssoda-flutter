import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/models/event_edit_data.dart';
import 'package:hashchecker/screens/event_list/event_detail/event_detail_screen.dart';
import 'package:hashchecker/screens/event_list/event_edit/event_edit_modal.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import 'event_options_modal.dart';

class EventListTile extends StatelessWidget {
  const EventListTile({
    Key? key,
    required this.eventListItem,
    required this.size,
    required Map<EventStatus, String> statusStringMap,
    required Map<EventStatus, Color> statusColorMap,
  })  : _statusStringMap = statusStringMap,
        _statusColorMap = statusColorMap,
        super(key: key);

  final eventListItem;
  final Size size;
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
          openBuilder: (context, _) => EventDetailScreen(
              eventId: eventListItem.id, eventStatus: eventListItem.status),
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
                            onLongPress: () => showMaterialModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                expand: false,
                                context: context,
                                builder: (context) => EventOptionsModal(
                                    eventId: eventListItem.id,
                                    eventStatus: eventListItem.status,
                                    isAlreadyInPreview: false)),
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
                                              VerticalDivider(
                                                  width: 0,
                                                  color: kShadowColor
                                                      .withOpacity(0.6)),
                                              GestureDetector(
                                                onTap: () {
                                                  if (eventListItem.status !=
                                                      EventStatus.ENDED)
                                                    showBarModalBottomSheet(
                                                      expand: true,
                                                      context: context,
                                                      builder: (context) => Provider(
                                                          create: (_) =>
                                                              EventEditData(),
                                                          child: EventEditModal(
                                                              eventId:
                                                                  eventListItem
                                                                      .id)),
                                                    );
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          8, 4, 8, 4),
                                                  child: Icon(
                                                      Icons.edit_rounded,
                                                      color: eventListItem
                                                                  .status !=
                                                              EventStatus.ENDED
                                                          ? Colors.blueGrey
                                                          : kShadowColor,
                                                      size: 18),
                                                ),
                                              ),
                                              VerticalDivider(
                                                  width: 0,
                                                  color: kShadowColor
                                                      .withOpacity(0.6)),
                                              GestureDetector(
                                                onTap: () =>
                                                    showMaterialModalBottomSheet(
                                                        backgroundColor: Colors
                                                            .transparent,
                                                        expand: false,
                                                        context: context,
                                                        builder: (context) =>
                                                            EventOptionsModal(
                                                                eventId:
                                                                    eventListItem
                                                                        .id,
                                                                eventStatus:
                                                                    eventListItem
                                                                        .status,
                                                                isAlreadyInPreview:
                                                                    false)),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          8, 4, 0, 4),
                                                  child: Icon(
                                                      Icons.more_vert_rounded,
                                                      color: Colors.blueGrey,
                                                      size: 18),
                                                ),
                                              )
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
                                blurRadius: 6,
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
