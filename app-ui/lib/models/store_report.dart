class StoreReport {
  final int exposureCount;
  final int participateCount;
  final int publicPostCount;
  final int privatePostCount;
  final int deletedPostCount;
  final int likeCount;
  final int commentCount;
  final int expenditureCount;

  StoreReport({
    required this.exposureCount,
    required this.participateCount,
    required this.publicPostCount,
    required this.privatePostCount,
    required this.deletedPostCount,
    required this.likeCount,
    required this.commentCount,
    required this.expenditureCount,
  });

  factory StoreReport.fromJson(Map<String, dynamic> json) {
    return StoreReport(
        exposureCount: json['exposure_count'],
        participateCount: json['participate_count'],
        publicPostCount: json['public_post_count'],
        privatePostCount: json['private_post_count'],
        deletedPostCount: json['deleted_post_count'],
        likeCount: json['like_count'],
        commentCount: json['comment_count'],
        expenditureCount: json['expenditure_count']);
  }
}
