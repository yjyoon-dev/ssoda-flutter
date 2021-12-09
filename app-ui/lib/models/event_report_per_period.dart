class EventReportPerPeriod {
  final List<int> exposureCount;
  final List<int> participateCount;
  final List<int> publicPostCount;
  final List<int> privatePostCount;
  final List<int> deletedPostCount;
  final List<int> likeCount;
  final List<int> commentCount;
  final List<int> expenditureCount;
  final List<int> levelExpenditure;

  EventReportPerPeriod(
      {required this.exposureCount,
      required this.participateCount,
      required this.publicPostCount,
      required this.privatePostCount,
      required this.deletedPostCount,
      required this.likeCount,
      required this.commentCount,
      required this.expenditureCount,
      required this.levelExpenditure});

  factory EventReportPerPeriod.fromJson(Map<String, dynamic> json) {
    var exposureCountFromJson = json['exposure_count'];
    var participateCountFromJson = json['participate_count'];
    var publicPostCountFromJson = json['public_post_count'];
    var privatePostCountFromJson = json['private_post_count'];
    var deletedPostCountFromJson = json['deleted_post_count'];
    var likeCountFromJson = json['like_count'];
    var commentCountFromJson = json['comment_count'];
    var expenditureCountFromJson = json['expenditure_count'];
    var levelExpenditureFromJson = json['level_expenditure'];

    List<int> exposureCount = exposureCountFromJson.cast<int>();
    List<int> participateCount = participateCountFromJson.cast<int>();
    List<int> publicPostCount = publicPostCountFromJson.cast<int>();
    List<int> privatePostCount = privatePostCountFromJson.cast<int>();
    List<int> deletedPostCount = deletedPostCountFromJson.cast<int>();
    List<int> likeCount = likeCountFromJson.cast<int>();
    List<int> commentCount = commentCountFromJson.cast<int>();
    List<int> expenditureCount = expenditureCountFromJson.cast<int>();
    List<int> levelExpenditure = levelExpenditureFromJson.cast<int>();

    return EventReportPerPeriod(
        exposureCount: exposureCount,
        participateCount: participateCount,
        publicPostCount: publicPostCount,
        privatePostCount: privatePostCount,
        deletedPostCount: deletedPostCount,
        likeCount: likeCount,
        commentCount: commentCount,
        expenditureCount: expenditureCount,
        levelExpenditure: levelExpenditure);
  }
}
