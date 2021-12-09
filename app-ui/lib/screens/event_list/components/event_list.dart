import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event_list_item.dart';

import 'empty.dart';
import 'event_list_tile.dart';

class EventList extends StatelessWidget {
  final size;
  final List<EventListItem> eventList;
  final selectedStatusFilter;
  final statusStringMap;
  final statusFilterString;
  final statusColorMap;
  const EventList(
      {Key? key,
      required this.size,
      required this.eventList,
      required this.selectedStatusFilter,
      required this.statusStringMap,
      required this.statusFilterString,
      required this.statusColorMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return eventList.isEmpty
        ? Empty()
        : Container(
            margin: const EdgeInsets.only(bottom: 90),
            child: AnimationLimiter(
              child: Column(
                  children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 500),
                      childAnimationBuilder: (widget) => SlideAnimation(
                            horizontalOffset: 75,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                      children: List.generate(
                        eventList.length,
                        (index) => (selectedStatusFilter == 0 ||
                                statusStringMap[eventList[index].status] ==
                                    statusFilterString[selectedStatusFilter])
                            ? EventListTile(
                                size: size,
                                eventListItem: eventList[index],
                                statusStringMap: statusStringMap,
                                statusColorMap: statusColorMap)
                            : Container(),
                      ))),
            ),
          );
  }
}
