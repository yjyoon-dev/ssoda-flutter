import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker_web/api.dart';
import 'package:hashchecker_web/constants.dart';
import 'package:hashchecker_web/models/store.dart';
import 'package:hashchecker_web/models/store_category.dart';

class StoreHeader extends StatelessWidget {
  final Store store;
  const StoreHeader({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(children: [
      Container(
        height: size.width / 3 * 2 + size.width * 0.1,
        color: kScaffoldBackgroundColor,
        child: Stack(children: [
          CarouselSlider(
            options: CarouselOptions(
                autoPlay: true,
                height: size.width / 3 * 2,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                aspectRatio: 4 / 3),
            items: store.images
                .map((item) => GestureDetector(
                      onTap: () async {
                        await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                content: Stack(children: [
                                  ClipRRect(
                                    child: Image.network(
                                      '$s3Url$item',
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  Positioned(
                                      right: 12,
                                      top: 12,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          Icons.close_rounded,
                                          color: Colors.white,
                                        ),
                                      ))
                                ]),
                                contentPadding: const EdgeInsets.all(0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))));
                      },
                      child: Container(
                        child: Center(
                            child: Stack(children: [
                          Image.network(
                            '$s3Url$item',
                            fit: BoxFit.cover,
                            width: size.width,
                          ),
                          Container(
                              decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                kScaffoldBackgroundColor,
                                Colors.transparent
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ))
                        ])),
                      ),
                    ))
                .toList(),
          ),
          Positioned(
              bottom: 0,
              right: size.width * 0.4,
              left: size.width * 0.4,
              child: GestureDetector(
                onTap: () async {
                  await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                          content: Stack(children: [
                            ClipRRect(
                              child: Image.network('$s3Url${store.logoImage}',
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            Positioned(
                                right: 12,
                                top: 12,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.close_rounded,
                                    color: kDefaultFontColor,
                                  ),
                                ))
                          ]),
                          contentPadding: const EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))));
                },
                child: Container(
                    height: size.width * 0.2,
                    width: size.width * 0.2,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 0.5,
                              spreadRadius: 0.5,
                              offset: Offset(0, 0),
                              color: kDefaultFontColor.withOpacity(0.2))
                        ],
                        color: kShadowColor,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage('$s3Url${store.logoImage}'),
                            fit: BoxFit.cover))),
              ))
        ]),
      ),
      SizedBox(height: kDefaultPadding * 1.2),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AutoSizeText(
            store.name,
            style: TextStyle(
                color: kDefaultFontColor,
                fontWeight: FontWeight.bold,
                fontSize: 20),
            maxLines: 1,
            minFontSize: 12,
          ),
          SizedBox(width: kDefaultPadding / 3),
          Icon(storeCategoryIconMap[store.category],
              size: 18, color: kDefaultFontColor.withOpacity(0.75)),
        ],
      ),
      SizedBox(height: kDefaultPadding / 2),
      Text(store.address.getFullAddress(),
          style: TextStyle(color: kLiteFontColor, fontSize: 14)),
    ]);
  }
}
