import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hashchecker_web/constants.dart';

import 'empty.dart';
import 'event_list_tile.dart';

class EventList extends StatelessWidget {
  final size;
  final storeId;
  final eventList;
  final selectedStatusFilter;
  final statusStringMap;
  final statusFilterString;
  final statusColorMap;
  const EventList(
      {Key? key,
      required this.size,
      required this.storeId,
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
        : Column(children: [
            Column(
              children: [
                SizedBox(height: kDefaultPadding),
                AnimationLimiter(
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
                              storeId: storeId,
                              eventListItem: eventList[index],
                              statusStringMap: statusStringMap,
                              statusColorMap: statusColorMap)
                          : Container(),
                    ),
                  )),
                )
              ],
            ),
          ]);
  }
}
