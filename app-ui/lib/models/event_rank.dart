class EventRank {
  final int storeId;
  final String storeName;
  final String storeLogo;
  final int eventId;
  final String eventTitle;
  final String eventImage;
  final double guestPrice;
  final int joinCount;
  final int likeCount;

  EventRank(
      {required this.storeId,
      required this.storeName,
      required this.storeLogo,
      required this.eventId,
      required this.eventTitle,
      required this.eventImage,
      required this.guestPrice,
      required this.joinCount,
      required this.likeCount});

  factory EventRank.fromJson(Map<String, dynamic> json) {
    return EventRank(
        storeId: json['storeId'],
        storeName: json['storeName'],
        storeLogo: json['storeLogoImagePath'],
        eventId: json['eventId'],
        eventTitle: json['eventTitle'],
        eventImage: json['eventImagePath'],
        guestPrice: json['guestPrice'],
        joinCount: json['participateCount'],
        likeCount: json['reactCount']);
  }
}
