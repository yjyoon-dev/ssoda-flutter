import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/store_category.dart';

class StoreCate extends StatelessWidget {
  final setCategory;
  final category;
  const StoreCate({Key? key, required this.setCategory, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      child: Row(children: [
        Icon(Icons.local_offer_rounded, color: kLiteFontColor),
        SizedBox(width: kDefaultPadding),
        Row(
            children: List.generate(
                storeCategoryList.length,
                (index) => Container(
                    margin: const EdgeInsets.only(right: 7),
                    child: GestureDetector(
                      onTap: () {
                        setCategory(storeCategoryList[index].category);
                      },
                      child: Chip(
                        label: Text(
                          storeCategoryList[index].name,
                          style: TextStyle(
                              color:
                                  storeCategoryList[index].category == category
                                      ? kThemeColor
                                      : kLiteFontColor),
                        ),
                        avatar: CircleAvatar(
                            radius: 14,
                            child: Icon(
                              storeCategoryList[index].icon,
                              color: Colors.white,
                              size: 14,
                            ),
                            backgroundColor:
                                storeCategoryList[index].category == category
                                    ? kThemeColor
                                    : kLiteFontColor),
                        backgroundColor: kScaffoldBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 5.0,
                        shadowColor:
                            storeCategoryList[index].category == category
                                ? kThemeColor.withOpacity(0.3)
                                : kShadowColor,
                      ),
                    ))))
      ]),
    );
  }
}
