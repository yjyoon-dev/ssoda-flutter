import 'event.dart';

class EventReportItem {
  final String eventName;
  final String thumbnail;
  final int guestPrice;
  final int joinCount;
  final int likeCount;
  final List<String> rewardNameList;
  final EventStatus status;

  EventReportItem(
      {required this.thumbnail,
      required this.status,
      required this.eventName,
      required this.guestPrice,
      required this.joinCount,
      required this.likeCount,
      required this.rewardNameList});
}
