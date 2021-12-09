import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/oss.dart';
import 'package:hashchecker/screens/info/oss/components/oss_list.dart';

class OssScreen extends StatelessWidget {
  const OssScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('오픈소스 라이선스', style: TextStyle(color: kDefaultFontColor)),
          centerTitle: true,
          elevation: 0,
          backgroundColor: kScaffoldBackgroundColor,
          iconTheme: IconThemeData(color: kDefaultFontColor),
        ),
        body: Container(
            child: ListView.builder(
                itemCount: ossList.length,
                itemBuilder: (context, index) => OssList(index: index))));
  }
}
