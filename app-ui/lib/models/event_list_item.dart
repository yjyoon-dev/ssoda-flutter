import 'event.dart';

class EventListItem {
  final int id;
  final String title;
  final String startDate;
  final String finishDate;
  final String thumbnail;
  final EventStatus status;

  EventListItem(
      {required this.id,
      required this.title,
      required this.startDate,
      required this.finishDate,
      required this.thumbnail,
      required this.status});

  factory EventListItem.fromJson(Map<String, dynamic> json) {
    return EventListItem(
        id: json['id'],
        title: json['title'],
        startDate: json['startDate'].toString().substring(0, 10),
        finishDate: json['finishDate'] == null
            ? '상품 소진 시까지'
            : json['finishDate'].toString().substring(0, 10),
        thumbnail: json['imagePaths'][0],
        status: EventStatus.values[json['status']]);
  }
}
