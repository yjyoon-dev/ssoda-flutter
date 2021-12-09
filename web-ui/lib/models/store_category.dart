import 'package:flutter/material.dart';

enum StoreCategory { RESTAURANT, CAFE, ETC }

Map<StoreCategory, IconData> storeCategoryIconMap = {
  StoreCategory.RESTAURANT: Icons.restaurant_rounded,
  StoreCategory.CAFE: Icons.local_cafe_rounded,
  StoreCategory.ETC: Icons.pending_rounded
};

class StoreCategoryTile {
  final String name;
  final StoreCategory category;
  final IconData icon;

  StoreCategoryTile(this.name, this.category, this.icon);
}

List<StoreCategoryTile> storeCategoryList = [
  StoreCategoryTile('식당', StoreCategory.RESTAURANT, Icons.restaurant_rounded),
  StoreCategoryTile('카페', StoreCategory.CAFE, Icons.local_cafe_rounded),
  StoreCategoryTile('기타', StoreCategory.ETC, Icons.pending_rounded),
];
