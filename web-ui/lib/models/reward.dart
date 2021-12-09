import 'reward_category.dart';

class Reward {
  final int id;
  final String name;
  final String imgPath;
  final int price;
  final int count;
  final int level;
  final RewardCategory category;

  Reward(
      {required this.id,
      required this.name,
      required this.imgPath,
      required this.price,
      required this.count,
      required this.level,
      required this.category});

  factory Reward.fromJson(Map<String, dynamic> json) {
    return Reward(
        id: json['id'],
        name: json['name'],
        imgPath: json['imagePath'],
        category: RewardCategory.values[json['category']],
        price: json['price'],
        count: json['count'],
        level: json['level']);
  }
}
