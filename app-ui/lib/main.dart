import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/fcm.dart';
import 'package:hashchecker/models/selected_store.dart';
import 'package:hashchecker/screens/hall/hall_screen.dart';
import 'package:hashchecker/screens/on_boarding/on_boarding_screen.dart';
import 'package:hashchecker/screens/sign_in/sign_in_screen.dart';
import 'package:hashchecker/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'screens/create_store/components/intro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark));
  runApp(Provider(create: (_) => SelectedStore(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(context),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(home: SplashScreen());
        } else if (snapshot.hasError) {
          return MaterialApp(
              home: Scaffold(
                  body: buildErrorPage(
                      message: '앱을 실행할 수 없습니다.\n네트워크 연결 상태를 확인해주세요!')));
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'SSODA',
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('ko'),
            ],
            locale: const Locale('ko'),
            theme: ThemeData(
                primarySwatch: _createMaterialColor(kThemeColor),
                visualDensity: VisualDensity.adaptivePlatformDensity,
                scaffoldBackgroundColor: kScaffoldBackgroundColor,
                accentColor: kShadowColor.withOpacity(0.01)),
            home: snapshot.data,
            builder: (context, child) => MediaQuery(
                child: child!,
                data: MediaQuery.of(context).copyWith(
                    textScaleFactor: MediaQuery.of(context)
                        .textScaleFactor
                        .clamp(0.95, 1.05))),
          );
        }
      },
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

class Init {
  Init._();
  static final instance = Init._();

  Future<Widget?> initialize(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 1500));
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // FCM setting
    fcmSetting();

    // on first launching
    final checkFirst = prefs.getBool('checkFirst');
    if (checkFirst == null) return OnBoardingScreen();

    final storage = new FlutterSecureStorage();

    final accessToken = await storage.read(key: 'ACCESS_TOKEN');
    final refreshToken = await storage.read(key: 'REFRESH_TOKEN');

    // on not login yet
    if (accessToken == null || refreshToken == null) return SignInScreen();

    // firebase token update
    final isFCMEnabled = await prefs.getBool('FCM_ENABLED');
    if (isFCMEnabled == null || isFCMEnabled) {
      String? firebaseToken = await FirebaseMessaging.instance.getToken();

      if (firebaseToken != null) {
        var dio = await authDio(context);
        final firebaseTokenUpdateResponse = await dio.put(
            getApi(API.UPDATE_FIREBASE_TOKEN),
            data: {'pushToken': firebaseToken});
      }
    }

    // on empty store
    final selectedStore = prefs.getInt('selectedStore');
    if (selectedStore == null) return CreateStoreIntroScreen();

    context.read<SelectedStore>().id = selectedStore;

    // on default
    return HallScreen();
  }
}
