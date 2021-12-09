import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:hashchecker/models/oss.dart';

const kThemeColor = Color(0xFF29a7e1);
const kScaffoldBackgroundColor = Color(0xFFfcfeff);
final kShadowColor = Color(0xFF90abb7).withOpacity(0.3);
const kDefaultFontColor = Color(0xFF001924);
const kLiteFontColor = Color(0xFF849197);
const kLogoColor = Color(0xFF2ca6e0);
const kDefaultPadding = 15.0;
const kDefaultNumberSliderDuration = Duration(seconds: 1);
const kAppUrlScheme = 'com.rocketdan.ssoda';
const kNewImagePrefix = 'HASHCHECKER_NEW_IMAGE';
const kRewardPolicyRandom = 'RANDOM';
const kRewardPolicyFollow = 'FOLLOW';
const kGooglePlayStoreDownloadUrl =
    'https://play.google.com/store/apps/details?id=com.rocketdan.ssoda';

final List<OSSTile> ossList = [
  OSSTile(
      name: 'Flutter',
      link: 'https://github.com/flutter/flutter',
      copyright: 'Copyright 2014 The Flutter Authors.',
      license: OSLicense(type: OSLicenseType.BSD3CLAUSE)),
  OSSTile(
      name: 'Image Picker',
      link:
          'https://github.com/flutter/plugins/tree/master/packages/image_picker/image_picker',
      copyright: 'Copyright 2013 The Flutter Authors.',
      license: OSLicense(type: OSLicenseType.APACHE2)),
  OSSTile(
      name: 'Carousel Slider',
      link: 'https://github.com/serenader2014/flutter_carousel_slider',
      copyright: 'Copyright 2017 serenader.',
      license: OSLicense(type: OSLicenseType.MIT)),
  OSSTile(
      name: 'FL Chart',
      link: 'https://github.com/imaNNeoFighT/fl_chart',
      copyright: 'Copyright 2019 Iman Khoshabi.',
      license: OSLicense(type: OSLicenseType.BSD3CLAUSE)),
  OSSTile(
      name: 'Number Display',
      link: 'https://github.com/entronad/number_display',
      copyright: 'Copyright 2019 LIN Chen.',
      license: OSLicense(type: OSLicenseType.MIT)),
  OSSTile(
      name: 'http',
      link: 'https://github.com/dart-lang/http',
      copyright: 'Copyright 2014 The Dart project authors.',
      license: OSLicense(type: OSLicenseType.BSD3CLAUSE)),
  OSSTile(
      name: 'Animated Text Kit',
      link: 'https://github.com/aagarwal1012/Animated-Text-Kit',
      copyright: 'Copyright 2018 Ayush Agarwal.',
      license: OSLicense(type: OSLicenseType.MIT)),
  OSSTile(
      name: 'intl',
      link: 'https://github.com/dart-lang/intl',
      copyright: 'Copyright 2013 The Dart project authors.',
      license: OSLicense(type: OSLicenseType.BSD3CLAUSE)),
  OSSTile(
      name: 'Provider',
      link: 'https://github.com/rrousselGit/provider',
      copyright: 'Copyright 2019 Remi Rousselet.',
      license: OSLicense(type: OSLicenseType.MIT)),
  OSSTile(
      name: 'QR Flutter',
      link: 'https://github.com/theyakka/qr.flutter',
      copyright: 'Copyright 2020 Luke Freeman.',
      license: OSLicense(type: OSLicenseType.BSD3CLAUSE)),
  OSSTile(
      name: 'Path Provider',
      link:
          'https://github.com/flutter/plugins/tree/master/packages/path_provider/path_provider',
      copyright: 'Copyright 2013 The Flutter Authors.',
      license: OSLicense(type: OSLicenseType.BSD3CLAUSE)),
  OSSTile(
      name: 'Gallery Saver',
      link: 'https://github.com/CarnegieTechnologies/gallery_saver',
      copyright: 'Copyright 2019 Carnegie Technologie.',
      license: OSLicense(type: OSLicenseType.APACHE2)),
  OSSTile(
      name: 'Dio',
      link: 'https://github.com/flutterchina/dio',
      copyright: 'Copyright 2018 wendux',
      license: OSLicense(type: OSLicenseType.MIT)),
  OSSTile(
      name: 'Animations',
      link: 'https://github.com/flutter/packages',
      copyright: 'Copyright 2013 The Flutter Authors',
      license: OSLicense(type: OSLicenseType.BSD3CLAUSE)),
  OSSTile(
      name: 'Flutter Staggered Animations',
      link: 'https://github.com/mobiten/flutter_staggered_animations',
      copyright: 'Copyright 2019 mobiten.',
      license: OSLicense(type: OSLicenseType.MIT)),
  OSSTile(
      name: 'Modal Bottom Sheet',
      link: 'https://github.com/jamesblasco/modal_bottom_sheet',
      copyright: 'Copyright 2020 Jaime Blasco.',
      license: OSLicense(type: OSLicenseType.MIT)),
  OSSTile(
      name: 'Syncfusion Flutter Datepicker',
      link: 'https://github.com/syncfusion/flutter-examples',
      copyright: 'Copyright 2001 Syncfusion.',
      license: OSLicense(type: OSLicenseType.SYNCFUSION)),
  OSSTile(
      name: 'Flutter Native Splash',
      link: 'https://github.com/jonbhanson/flutter_native_splash',
      copyright: 'Copyright 2019 Mark O\'Sullivan.',
      license: OSLicense(type: OSLicenseType.MIT)),
  OSSTile(
      name: 'Simple Animations',
      link: 'https://github.com/felixblaschke/simple_animations',
      copyright: 'Copyright 2019 Felix Blaschke.',
      license: OSLicense(type: OSLicenseType.MIT)),
  OSSTile(
      name: 'Introduction Screen',
      link: 'https://github.com/pyozer/introduction_screen',
      copyright: 'Copyright 2019 Jean-Charles Moussé.',
      license: OSLicense(type: OSLicenseType.MIT)),
  OSSTile(
      name: 'Flutter Web Auth',
      link: 'https://github.com/LinusU/flutter_web_auth',
      copyright: 'Copyright 2019 Linus Unnebäck',
      license: OSLicense(type: OSLicenseType.MIT)),
  OSSTile(
      name: 'Flutter Secure Storage',
      link: 'https://github.com/mogol/flutter_secure_storage',
      copyright: 'Copyright 2017 German Saprykin.',
      license: OSLicense(type: OSLicenseType.BSD3CLAUSE)),
  OSSTile(
      name: 'Flutter InAppWebview',
      link: 'https://github.com/pichillilorenzo/flutter_inappwebview',
      copyright: 'Copyright 2018 Lorenzo Pichilli.',
      license: OSLicense(type: OSLicenseType.APACHE2)),
  OSSTile(
      name: 'Flutter Geocoding',
      link: 'https://github.com/baseflow/flutter-geocoding',
      copyright: 'Copyright 2018 Baseflow.',
      license: OSLicense(type: OSLicenseType.MIT)),
  OSSTile(
      name: 'Flash',
      link: 'https://github.com/sososdk/flash',
      copyright: 'Copyright 2019 sososdk.',
      license: OSLicense(type: OSLicenseType.APACHE2)),
  OSSTile(
      name: 'Shared Preferences',
      link:
          'https://github.com/flutter/plugins/tree/master/packages/shared_preferences/shared_preferences',
      copyright: 'Copyright 2013 The Flutter Authors.',
      license: OSLicense(type: OSLicenseType.BSD3CLAUSE)),
  OSSTile(
      name: 'Screenshot',
      link: 'https://github.com/SachinGanesh/screenshot',
      copyright: 'Copyright 2018 Sachin Ganesh.',
      license: OSLicense(type: OSLicenseType.MIT)),
  OSSTile(
      name: 'Flutter Image Cropper',
      link: 'https://github.com/hnvn/flutter_image_cropper',
      copyright: 'Copyright 2013 The Dart project authors.',
      license: OSLicense(type: OSLicenseType.BSD3CLAUSE)),
  OSSTile(
      name: 'Future Progress Dialog',
      link: 'https://github.com/donguseo/future_progress_dialog',
      copyright: 'Copyright 2020 donguseo.',
      license: OSLicense(type: OSLicenseType.MIT)),
  OSSTile(
      name: 'URL Launcher',
      link:
          'https://github.com/flutter/plugins/tree/master/packages/url_launcher/url_launcher',
      copyright: 'Copyright 2013 The Flutter Authors.',
      license: OSLicense(type: OSLicenseType.BSD3CLAUSE)),
  OSSTile(
      name: 'Firebase Messaging',
      link:
          'https://github.com/FirebaseExtended/flutterfire/tree/master/packages/firebase_messaging/firebase_messaging',
      copyright: 'Copyright 2017 The Chromium Authors.',
      license: OSLicense(type: OSLicenseType.BSD3CLAUSE)),
  OSSTile(
      name: 'Firebase Core',
      link:
          'https://github.com/FirebaseExtended/flutterfire/tree/master/packages/firebase_core/firebase_core',
      copyright: 'Copyright 2017 The Chromium Authors.',
      license: OSLicense(type: OSLicenseType.BSD3CLAUSE)),
  OSSTile(
      name: 'Flutter Local Notifications',
      link: 'https://github.com/MaikuB/flutter_local_notifications',
      copyright: 'Copyright 2018 Michael Bui.',
      license: OSLicense(type: OSLicenseType.BSD3CLAUSE)),
  OSSTile(
      name: 'Flutter Holo Date Picker',
      link: 'https://github.com/kfiross/flutter_holo_date_picker',
      copyright: 'Copyright 2020 Kfir Matityahu.',
      license: OSLicense(type: OSLicenseType.MIT)),
  OSSTile(
      name: 'Kpostal',
      link: 'https://github.com/tykann/kpostal',
      copyright: 'Copyright 2021 Taeyoon Kang.',
      license: OSLicense(type: OSLicenseType.MIT)),
  OSSTile(
      name: 'Pandabar',
      link: 'https://github.com/kemalturk/panda-bar',
      copyright: 'Copyright 2020 Kemal Türk.',
      license: OSLicense(type: OSLicenseType.MIT)),
  OSSTile(
      name: 'Number Slide Animation',
      link: 'https://github.com/kiesman99/number_slide_animation',
      copyright: 'Copyright 2021 Justin Vietz.',
      license: OSLicense(type: OSLicenseType.MIT)),
  OSSTile(
      name: 'Flutter OTP Text Field',
      link: 'https://github.com/david-legend/otp_textfield',
      copyright: 'Copyright 2020 David Cobbina.',
      license: OSLicense(type: OSLicenseType.BSD3CLAUSE))
];

Route slidePageRouting(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.fastOutSlowIn;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Future<void> showProgressDialog(
    BuildContext context, Future<dynamic> future) async {
  await showDialog(
      context: context, builder: (context) => FutureProgressDialog(future));
}

Widget buildErrorPage({String? message}) {
  return Center(
    child: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Icon(Icons.wifi_off_rounded, color: kDefaultFontColor),
          SizedBox(height: kDefaultPadding),
          Text(message ?? '정보를 가져올 수 없습니다.\n인터넷 연결 상태를 확인해주세요.',
              textAlign: TextAlign.center,
              style: TextStyle(height: 1.2, color: kLiteFontColor))
        ])),
  );
}
