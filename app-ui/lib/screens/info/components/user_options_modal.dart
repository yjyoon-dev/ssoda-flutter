import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/selected_store.dart';
import 'package:hashchecker/screens/create_store/create_store_screen.dart';
import 'package:hashchecker/screens/hall/hall_screen.dart';
import 'package:hashchecker/screens/info/store_edit/store_edit_screen.dart';
import 'package:hashchecker/screens/sign_in/sign_in_screen.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'qr_save_button.dart';

class UserOptionsModal extends StatelessWidget {
  const UserOptionsModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
              title: Text('로그아웃',
                  style: TextStyle(
                      color: kDefaultFontColor.withOpacity(0.8), fontSize: 15)),
              leading: Icon(Icons.logout_rounded,
                  color: kDefaultFontColor.withOpacity(0.8)),
              onTap: () async {
                await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                        title: Center(
                          child: Text('로그아웃',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: kDefaultFontColor),
                              textAlign: TextAlign.center),
                        ),
                        content: IntrinsicHeight(
                          child: Column(children: [
                            Text("로그아웃 하시겠습니까?",
                                style: TextStyle(
                                    fontSize: 14, color: kDefaultFontColor))
                          ]),
                        ),
                        contentPadding:
                            const EdgeInsets.fromLTRB(15, 15, 15, 5),
                        actions: [
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    await _logout(context);
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignInScreen()),
                                        (Route<dynamic> route) => false);
                                  },
                                  child: Text('예',
                                      style: TextStyle(
                                          color: kThemeColor, fontSize: 13)),
                                  style: ButtonStyle(
                                      overlayColor:
                                          MaterialStateProperty.all<Color>(
                                              kThemeColor.withOpacity(0.2))),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('아니오',
                                      style: TextStyle(fontSize: 13)),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              kThemeColor)),
                                ),
                              ],
                            ),
                          )
                        ],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))));
              }),
          ListTile(
              title: Text('회원 탈퇴',
                  style: TextStyle(color: Colors.red, fontSize: 15)),
              leading: Icon(Icons.person_remove_rounded, color: Colors.red),
              onTap: () async {
                await _deleteUser(context);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                    (Route<dynamic> route) => false);
              })
        ],
      ),
    ));
  }

  Future<void> _logout(BuildContext context) async {
    final storage = new FlutterSecureStorage();
    await storage.deleteAll();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('selectedStore');
  }

  Future<void> _deleteUser(BuildContext context) async {
    var dio = await authDio(context);

    final deleteUserResponse = await dio.delete(getApi(API.DELETE_USER));

    final storage = new FlutterSecureStorage();
    await storage.deleteAll();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('selectedStore');

    context.read<SelectedStore>().id = null;
  }
}
