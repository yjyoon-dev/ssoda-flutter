import 'package:hashchecker_web/models/store_category.dart';
import 'address.dart';

class Store {
  final String name;
  final StoreCategory category;
  final Address address;
  final String description;
  final List<String> images;
  final String logoImage;

  Store(
      {required this.name,
      required this.category,
      required this.address,
      required this.description,
      required this.images,
      required this.logoImage});

  factory Store.fromJson(Map<String, dynamic> json) {
    var imagesFromJson = json['imagePaths'];

    List<String> imagesList = imagesFromJson.cast<String>();

    return Store(
        name: json['name'],
        category: StoreCategory.values[json['category']],
        address: Address.fromJson(json['address']),
        description: json['description'],
        images: imagesList,
        logoImage: json['logoImagePath']);
  }
}
