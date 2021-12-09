import 'package:flutter/material.dart';

enum RewardCategory { DRINK, FOOD, COUPON }

class RewardCategoryTile {
  String name;
  IconData icon;
  RewardCategory category;

  String get getName => name;
  IconData get getIcon => icon;
  RewardCategory get getCategory => category;

  RewardCategoryTile(
      {required this.name, required this.icon, required this.category});
}

List<RewardCategoryTile> categoryTileList = [
  RewardCategoryTile(
      name: "음료",
      icon: Icons.local_cafe_outlined,
      category: RewardCategory.DRINK),
  RewardCategoryTile(
      name: "음식", icon: Icons.fastfood_outlined, category: RewardCategory.FOOD),
  RewardCategoryTile(
      name: "쿠폰",
      icon: Icons.confirmation_num_outlined,
      category: RewardCategory.COUPON)
];
