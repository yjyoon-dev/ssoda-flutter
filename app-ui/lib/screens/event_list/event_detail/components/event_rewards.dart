import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event.dart';

class EventRewards extends StatelessWidget {
  const EventRewards({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('이벤트 상품',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: kDefaultFontColor)),
      SizedBox(height: kDefaultPadding),
      SizedBox(
        height: 150,
        child: ListView.separated(
          itemBuilder: (context, index) => GestureDetector(
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      content: Stack(children: [
                        ClipRRect(
                          child: Stack(
                            children: [
                              Image.network(
                                  '$s3Url${event.rewardList[index]!.imgPath}',
                                  fit: BoxFit.cover),
                              Positioned(
                                bottom: 0.0,
                                left: 0.0,
                                right: 0.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(150, 0, 0, 0),
                                        Color.fromARGB(0, 0, 0, 0)
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0),
                                  child: Text(
                                    '${event.rewardList[index]!.name}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            ],
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                '$s3Url${event.rewardList[index]!.imgPath}',
                fit: BoxFit.cover,
                width: 130,
              ),
            ),
          ),
          itemCount: event.rewardList.length,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(3, 6, 3, 6),
          separatorBuilder: (context, index) => SizedBox(width: 12),
        ),
      )
    ]);
  }
}
