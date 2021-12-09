import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event_rank.dart';
import 'package:number_display/number_display.dart';
import 'package:url_launcher/url_launcher.dart';

class RankingTile extends StatelessWidget {
  const RankingTile({Key? key, required this.event, required this.index})
      : super(key: key);

  final EventRank event;
  final int index;
  @override
  Widget build(BuildContext context) {
    final numberDisplay = createDisplay();
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Container(
        height: size.height * 0.12,
        margin: const EdgeInsets.fromLTRB(20, 15, 20, 15),
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
            child: Stack(
              children: [
                Positioned(
                    left: 0,
                    child: Container(
                      child: Stack(
                        children: [
                          Container(
                              height: size.height * 0.12,
                              width: size.width * 0.37,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          '$s3Url${event.eventImage}'),
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                          kScaffoldBackgroundColor
                                              .withOpacity(0.25),
                                          BlendMode.luminosity)),
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(12)))),
                          Container(
                              height: size.height * 0.12,
                              width: size.width * 0.371,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    kScaffoldBackgroundColor,
                                    kScaffoldBackgroundColor.withOpacity(0)
                                  ],
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                ),
                              )),
                        ],
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 15, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: size.height * 0.075,
                          width: size.height * 0.075,
                          decoration: BoxDecoration(
                              color: kShadowColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 8,
                                    offset: Offset(0, 0),
                                    color: kDefaultFontColor.withOpacity(0.2))
                              ],
                              image: DecorationImage(
                                  image:
                                      NetworkImage('$s3Url${event.storeLogo}'),
                                  fit: BoxFit.cover))),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(event.storeName,
                              style: TextStyle(
                                  color: kLiteFontColor, fontSize: 10)),
                          SizedBox(height: kDefaultPadding / 7.5),
                          Text(event.eventTitle,
                              style: TextStyle(
                                  color: kDefaultFontColor,
                                  fontWeight: FontWeight.bold)),
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
                                    size: 12,
                                    color: Colors.blueGrey,
                                  ),
                                  Text(
                                    '${numberDisplay(event.guestPrice)}원',
                                    style: TextStyle(
                                        color: kLiteFontColor, fontSize: 10),
                                  ),
                                ]),
                                VerticalDivider(
                                  width: kDefaultPadding,
                                  color: kShadowColor.withOpacity(0.6),
                                ),
                                Row(children: [
                                  Icon(
                                    Icons.group_rounded,
                                    size: 12,
                                    color: Colors.blueGrey,
                                  ),
                                  SizedBox(width: kDefaultPadding / 3),
                                  Text('${numberDisplay(event.joinCount)}명',
                                      style: TextStyle(
                                          color: kLiteFontColor, fontSize: 10)),
                                ]),
                                VerticalDivider(
                                  width: kDefaultPadding,
                                  color: kShadowColor.withOpacity(0.6),
                                ),
                                Row(children: [
                                  Icon(
                                    Icons.favorite_rounded,
                                    size: 12,
                                    color: Colors.blueGrey,
                                  ),
                                  SizedBox(width: kDefaultPadding / 3),
                                  Text('${numberDisplay(event.likeCount)}개',
                                      style: TextStyle(
                                          color: kLiteFontColor, fontSize: 10)),
                                ]),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
