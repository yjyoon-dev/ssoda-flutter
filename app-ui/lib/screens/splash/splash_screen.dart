import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import 'components/copyright.dart';
import 'components/logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      body: Container(
          padding: const EdgeInsets.all(10),
          color: kScaffoldBackgroundColor,
          child: Logo()),
    );
  }
}
