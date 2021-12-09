import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/user.dart';
import 'package:hashchecker/screens/info/oss/oss_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class AppInfo extends StatelessWidget {
  const AppInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Material(
          color: Colors.white.withOpacity(0),
          child: InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('오픈소스 라이센스'),
                contentPadding: const EdgeInsets.all(5),
                onTap: () {
                  Navigator.push(context, slidePageRouting(OssScreen()));
                },
                trailing:
                    Icon(Icons.navigate_next_rounded, color: kLiteFontColor),
              ))),
      Material(
          color: Colors.white.withOpacity(0),
          child: InkWell(
              onTap: () {},
              child: ListTile(
                  title: Text('현재 버전 2.0.0'),
                  contentPadding: const EdgeInsets.all(5),
                  onTap: () async => await canLaunch(
                          kGooglePlayStoreDownloadUrl)
                      ? await launch(kGooglePlayStoreDownloadUrl)
                      : throw 'Could not launch $kGooglePlayStoreDownloadUrl'))),
    ]);
  }
}
