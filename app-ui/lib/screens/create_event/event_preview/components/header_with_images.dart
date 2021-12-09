import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event.dart';
import 'dart:io';

import 'package:hashchecker/models/selected_store.dart';
import 'package:provider/provider.dart';

class HeaderWithImages extends StatefulWidget {
  const HeaderWithImages({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  _HeaderWithImagesState createState() => _HeaderWithImagesState();
}

class _HeaderWithImagesState extends State<HeaderWithImages> {
  late Future<String> storeLogo;
  @override
  void initState() {
    super.initState();
    storeLogo = _fetchStoreLogoData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.width / 4 * 3,
      child: Stack(children: [
        Container(
            color: kLiteFontColor,
            child: CarouselSlider(
              options: CarouselOptions(
                  aspectRatio: 4 / 3,
                  autoPlay: true,
                  height: size.width / 4 * 3 - 15,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false),
              items: widget.event.images
                  .map((item) => GestureDetector(
                        onTap: () async {
                          await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                  content: Stack(children: [
                                    ClipRRect(
                                      child: Image.file(File(item!),
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
                                            color: Colors.white,
                                          ),
                                        ))
                                  ]),
                                  contentPadding: const EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15))));
                        },
                        child: Container(
                          child: Center(
                              child: Image.file(
                            File(item!),
                            fit: BoxFit.cover,
                            width: size.width,
                          )),
                        ),
                      ))
                  .toList(),
            )),
        Positioned(
            bottom: 14,
            right: 0,
            left: 0,
            child: Container(
              height: size.width * 0.14 - 15,
              decoration: BoxDecoration(
                color: kScaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            )),
        Positioned(
            bottom: 0,
            right: size.width * 0.36,
            left: size.width * 0.36,
            child: FutureBuilder<String>(
                future: storeLogo,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GestureDetector(
                      onTap: () async {
                        await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                content: Stack(children: [
                                  ClipRRect(
                                    child: Image.network(
                                        '$s3Url${snapshot.data}',
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
                          height: size.width * 0.28,
                          width: size.width * 0.28,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 25,
                                    offset: Offset(0, 5),
                                    color: kDefaultFontColor.withOpacity(0.2))
                              ],
                              color: kShadowColor,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage('$s3Url${snapshot.data}'),
                                  fit: BoxFit.cover))),
                    );
                  } else if (snapshot.hasError) {
                    return buildErrorPage();
                  }

                  return Container(
                      height: size.width * 0.28,
                      width: size.width * 0.28,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 25,
                              offset: Offset(0, 5),
                              color: kDefaultFontColor.withOpacity(0.2))
                        ],
                        color: kShadowColor,
                        shape: BoxShape.circle,
                      ));
                }))
      ]),
    );
  }

  Future<String> _fetchStoreLogoData() async {
    final storeId = context.read<SelectedStore>().id;

    var dio = await authDio(context);

    final getStoreResponse =
        await dio.get(getApi(API.GET_STORE, suffix: '/$storeId'));

    final fetchedStoreLogo = getStoreResponse.data['logoImagePath'];

    return fetchedStoreLogo;
  }
}
