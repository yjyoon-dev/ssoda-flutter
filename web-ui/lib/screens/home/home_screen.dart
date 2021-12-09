import 'package:flutter/material.dart';
import 'package:hashchecker_web/constants.dart';
import 'package:hashchecker_web/screens/home/components/intro.dart';

import 'components/create.dart';
import 'components/join.dart';
import 'components/outro.dart';
import 'components/report.dart';
import 'components/footer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  var _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_checkOffset(_scrollController.offset))
        setState(() {
          _scrollOffset = _scrollController.offset;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leadingWidth: 90,
        leading: GestureDetector(
          onTap: () {
            _scrollController.animateTo(0,
                duration: Duration(milliseconds: 1500),
                curve: Curves.fastOutSlowIn);
          },
          child: Container(
            margin: const EdgeInsets.only(left: 15),
            width: size.width * 2.5 / 7,
            child: Image.asset('assets/images/appbar_logo.png'),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            width: 110,
            child: TextButton(
              onPressed: () {
                _scrollController.animateTo(size.height * 4 + kToolbarHeight,
                    duration: Duration(milliseconds: 1500),
                    curve: Curves.fastOutSlowIn);
              },
              child: Text('다운로드', style: TextStyle(color: Colors.white)),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(kThemeColor),
                  overlayColor:
                      MaterialStateProperty.all<Color>(Colors.white30),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32))),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(horizontal: 15))),
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(children: [
        Intro(scrollController: _scrollController),
        Create(
            scrollController: _scrollController, scrollOffset: _scrollOffset),
        Join(scrollController: _scrollController, scrollOffset: _scrollOffset),
        Report(
            scrollController: _scrollController, scrollOffset: _scrollOffset),
        Outro(scrollController: _scrollController, scrollOffset: _scrollOffset),
        Footer()
      ], controller: _scrollController),
    );
  }

  bool _checkOffset(double offset) {
    double height = MediaQuery.of(context).size.height;

    final List<double> offsetList = [
      0,
      height * 0.33,
      height * 1.33,
      height * 2.33,
      height * 3.33
    ];
    return offsetList[0] <= offset &&
            offset <= offsetList[0] + height * 0.075 ||
        offsetList[1] <= offset && offset <= offsetList[1] + height * 0.075 ||
        offsetList[2] <= offset && offset <= offsetList[2] + height * 0.075 ||
        offsetList[3] <= offset && offset <= offsetList[3] + height * 0.075 ||
        offsetList[4] <= offset && offset <= offsetList[4] + height * 0.075;
  }
}
