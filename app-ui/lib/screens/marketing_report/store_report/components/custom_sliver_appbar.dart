import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event_report_item.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    Key? key,
    required this.eventReportList,
    required this.size,
  }) : super(key: key);

  final List<EventReportItem> eventReportList;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 25, 20),
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.close)),
        )
      ],
      flexibleSpace: ClipRRect(
          child: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.fromLTRB(20, 10, 0, 15),
            title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.525,
                    child: AutoSizeText(
                      '우리가게 마케팅 보고서',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(height: kDefaultPadding / 4),
                  Text(
                    '${eventReportList.length}개의 이벤트가 진행 중',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7), fontSize: 10),
                  ),
                ]),
            background: Stack(children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/images/store1.jpg',
                    ),
                  ),
                ),
                height: size.height * 0.4,
              ),
              Container(
                height: size.height * 0.4,
                decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Colors.transparent.withOpacity(0.0),
                          Colors.black.withOpacity(0.7),
                        ],
                        stops: [
                          0.0,
                          1.0
                        ])),
              ),
              Positioned(
                  bottom: 15,
                  right: 15,
                  child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                offset: Offset(0, 0),
                                color: Colors.black54)
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/store_logo_sample.jpg'),
                              fit: BoxFit.cover))))
            ]),
          ),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(0))),
      backgroundColor: kDefaultFontColor.withOpacity(0.87),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(0))),
      expandedHeight: size.height * 0.3,
      pinned: true,
    );
  }
}
