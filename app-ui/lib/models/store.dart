import 'package:hashchecker/models/store_category.dart';
import 'address.dart';

class Store {
  String name;
  StoreCategory category;
  Address address;
  String description;
  List<String> images;
  String logoImage;

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
