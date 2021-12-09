import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event_rank.dart';
import 'package:number_display/number_display.dart';

import 'components/first_ranking_tile.dart';
import 'components/ranking_tile.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({Key? key}) : super(key: key);

  @override
  _RankingScreenState createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  late Future<List<EventRank>> eventRankList;
  final rankingSortDropdownItemList = [
    '참가자 순위',
    '객단가 순위',
    '좋아요 순위',
  ];

  String dropdownValue = '참가자 순위';

  @override
  void initState() {
    super.initState();
    eventRankList = _fetchEventRankListData(dropdownValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: FutureBuilder<List<EventRank>>(
          future: eventRankList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 75),
                  child: Column(
                    children: List.generate(
                      snapshot.data!.length,
                      (index) => index == 0
                          ? FirstRankingTile(event: snapshot.data![index])
                          : RankingTile(
                              event: snapshot.data![index], index: index),
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              buildErrorPage();
            }

            return Center(child: const CircularProgressIndicator());
          }),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        '이벤트 랭킹',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: kDefaultFontColor),
      ),
      backgroundColor: kScaffoldBackgroundColor,
      elevation: 6,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Center(
            child: DropdownButton(
                dropdownColor: kScaffoldBackgroundColor.withOpacity(0.9),
                value: dropdownValue,
                icon: const Icon(
                  Icons.format_list_numbered_rounded,
                  color: kDefaultFontColor,
                  size: 20,
                ),
                iconSize: 24,
                elevation: 0,
                style: TextStyle(
                  color: kDefaultFontColor,
                  fontSize: 13,
                ),
                underline: Container(
                  height: 0,
                  color: kDefaultFontColor,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                    eventRankList = _fetchEventRankListData(dropdownValue);
                  });
                },
                items: rankingSortDropdownItemList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: SizedBox(
                        width: 75,
                        child: Text(
                          value,
                          style:
                              TextStyle(fontSize: 13, color: kDefaultFontColor),
                          textAlign: TextAlign.center,
                        )),
                  );
                }).toList()),
          ),
        )
      ],
    );
  }

  Future<List<EventRank>> _fetchEventRankListData(String sort) async {
    Map<String, String> sortStringMap = {
      '참가자 순위': 'participate',
      '객단가 순위': 'guestprice',
      '좋아요 순위': 'react'
    };
    var dio = await authDio(context);
    final getEventRankList = await dio
        .get('$baseUrl/api/v1/rank?sort=${sortStringMap[sort]}&limit=30');
    final fetchedEventRankListData = getEventRankList.data;
    final List<EventRank> eventRankList = List.generate(
        fetchedEventRankListData.length,
        (index) => EventRank.fromJson(fetchedEventRankListData[index]));
    return eventRankList;
  }
}
