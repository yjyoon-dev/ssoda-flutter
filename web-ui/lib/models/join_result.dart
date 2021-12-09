import 'package:hashchecker_web/models/reward.dart';

class JoinResult {
  final int postId;
  final Reward reward;

  JoinResult({required this.postId, required this.reward});

  factory JoinResult.fromJson(Map<String, dynamic> json) {
    final Reward reward = Reward.fromJson(json['reward']);
    return JoinResult(postId: json['postId'], reward: reward);
  }
}
