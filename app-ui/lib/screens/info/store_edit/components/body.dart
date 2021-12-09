import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/store.dart';

import 'confirm_button.dart';
import 'store_category.dart';
import 'store_description.dart';
import 'store_image.dart';
import 'store_location.dart';
import 'store_logo.dart';
import 'store_name.dart';

class Body extends StatelessWidget {
  final Store store;
  final List<String> newImages;
  final List<String> deletedImagePaths;
  const Body(
      {Key? key,
      required this.store,
      required this.newImages,
      required this.deletedImagePaths})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  StoreLogo(store: store),
                  SizedBox(height: kDefaultPadding * 1.5),
                  StoreName(store: store),
                  SizedBox(height: kDefaultPadding),
                  StoreCate(store: store),
                  SizedBox(height: kDefaultPadding),
                  StoreImage(
                      store: store,
                      newImages: newImages,
                      deletedImagePaths: deletedImagePaths),
                  SizedBox(height: kDefaultPadding),
                  StoreLocation(store: store),
                  SizedBox(height: kDefaultPadding),
                  StoreDescription(store: store),
                ],
              ),
            ),
          ),
          ConfirmButton(
              store: store,
              newImages: newImages,
              deletedImagePaths: deletedImagePaths),
        ],
      ),
    );
  }
}
