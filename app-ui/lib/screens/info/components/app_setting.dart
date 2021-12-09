import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSetting extends StatefulWidget {
  const AppSetting({Key? key}) : super(key: key);

  @override
  _AppSettingState createState() => _AppSettingState();
}

class _AppSettingState extends State<AppSetting> {
  bool _pushNotiEnabled = true;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0),
      child: InkWell(
        onTap: () {},
        child: SwitchListTile(
          activeColor: kThemeColor,
          value: _pushNotiEnabled,
          contentPadding: const EdgeInsets.all(5),
          title: Text('이벤트 참여 푸시 알림'),
          subtitle: Text(
            '고객이 이벤트에 참여 시 알림을 보내드려요',
            style: TextStyle(fontSize: 12),
          ),
          onChanged: (value) {
            setState(() {
              _pushNotiEnabled = value;
            });
            _updateSetting(_pushNotiEnabled);
          },
        ),
      ),
    );
  }

  void _updateSetting(bool opt) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('FCM_ENABLED', opt);

    Map<String, bool> data = {'allowed': opt};

    var dio = await authDio(context);

    final fcmSettingResponse =
        await dio.put(getApi(API.UPDATE_FIREBASE_SETTING), data: data);
  }
}
