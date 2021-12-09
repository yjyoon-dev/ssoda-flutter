import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event_rank.dart';
import 'package:number_display/number_display.dart';
import 'package:url_launcher/url_launcher.dart';

class FirstRankingTile extends StatelessWidget {
  final EventRank event;
  const FirstRankingTile({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberDisplay = createDisplay();
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
        child: Container(
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: kShadowColor,
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: Offset(3, 3), // changes position of shadow
                ),
              ],
              color: kScaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(12)),
          child: Material(
            color: Colors.white.withOpacity(0.0),
            child: InkWell(
              onTap: () {
                launch('$eventJoinUrl/${event.storeId}/${event.eventId}');
              },
              highlightColor: kShadowColor,
              overlayColor: MaterialStateProperty.all<Color>(kShadowColor),
              borderRadius: BorderRadius.circular(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Container(
                            height: size.height * 0.075,
                            width: size.height * 0.075,
                            decoration: BoxDecoration(
                                color: kShadowColor,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        '$s3Url${event.storeLogo}'),
                                    fit: BoxFit.cover))),
                        SizedBox(height: kDefaultPadding / 2),
                        Text(event.storeName,
                            style:
                                TextStyle(color: kLiteFontColor, fontSize: 12)),
                        SizedBox(height: kDefaultPadding / 7.5),
                        Text(event.eventTitle,
                            style: TextStyle(
                                color: kDefaultFontColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                        SizedBox(height: kDefaultPadding / 2),
                        Container(
                          height: 15,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(children: [
                                Icon(
                                  Icons.attach_money_rounded,
                                  size: 14,
                                  color: Colors.blueGrey,
                                ),
                                Text(
                                  '${numberDisplay(event.guestPrice)}원',
                                  style: TextStyle(
                                      color: kLiteFontColor, fontSize: 12),
                                ),
                              ]),
                              VerticalDivider(
                                width: kDefaultPadding,
                                color: kShadowColor.withOpacity(0.6),
                              ),
                              Row(children: [
                                Icon(
                                  Icons.group_rounded,
                                  size: 14,
                                  color: Colors.blueGrey,
                                ),
                                SizedBox(width: kDefaultPadding / 3),
                                Text('${numberDisplay(event.joinCount)}명',
                                    style: TextStyle(
                                        color: kLiteFontColor, fontSize: 12)),
                              ]),
                              VerticalDivider(
                                width: kDefaultPadding,
                                color: kShadowColor.withOpacity(0.6),
                              ),
                              Row(children: [
                                Icon(
                                  Icons.favorite_rounded,
                                  size: 14,
                                  color: Colors.blueGrey,
                                ),
                                SizedBox(width: kDefaultPadding / 3),
                                Text('${numberDisplay(event.likeCount)}개',
                                    style: TextStyle(
                                        color: kLiteFontColor, fontSize: 12)),
                              ]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage('$s3Url${event.eventImage}'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  kScaffoldBackgroundColor.withOpacity(0.25),
                  BlendMode.luminosity)),
        ));
  }
}
