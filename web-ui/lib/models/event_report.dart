class EventReport {
  final String eventName;
  final int joinCount;
  final int likeCount;
  final int livePostCount;
  final int deadPostCount;
  final int commentCount;
  final int exposeCount;
  final int followerSum;
  final int followerAvg;
  final int costSum;
  final List<int> costPerReward;

  EventReport(
      {required this.eventName,
      required this.joinCount,
      required this.likeCount,
      required this.livePostCount,
      required this.deadPostCount,
      required this.commentCount,
      required this.exposeCount,
      required this.followerSum,
      required this.followerAvg,
      required this.costSum,
      required this.costPerReward});
}
