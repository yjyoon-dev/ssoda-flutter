import 'package:flutter/material.dart';
import 'package:hashchecker_web/constants.dart';
import 'package:hashchecker_web/models/frouter.dart';
import 'package:hashchecker_web/screens/home/home_screen.dart';
import 'package:hashchecker_web/screens/store_event/store_event_screen.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  FRouter.setupRouter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '쏘다 - SNS 해시태그 이벤트 마케팅 매니저',
      onGenerateRoute: FRouter.router.generator,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: _createMaterialColor(kThemeColor),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: kScaffoldBackgroundColor,
          accentColor: kShadowColor),
      home: HomeScreen(),
    );
  }

  MaterialColor _createMaterialColor(Color color) {
    List<double> strengths = [.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}
