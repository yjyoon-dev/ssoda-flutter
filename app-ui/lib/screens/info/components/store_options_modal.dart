import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/selected_store.dart';
import 'package:hashchecker/screens/create_store/create_store_screen.dart';
import 'package:hashchecker/screens/hall/hall_screen.dart';
import 'package:hashchecker/screens/info/store_edit/store_edit_screen.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'qr_save_button.dart';

class StoreOptionsModal extends StatelessWidget {
  final storeId;
  const StoreOptionsModal({Key? key, required this.storeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
              title: Text('가게 QR 코드 확인',
                  style: TextStyle(
                      color: kDefaultFontColor.withOpacity(0.8), fontSize: 15)),
              leading: Icon(Icons.qr_code_2_rounded,
                  color: kDefaultFontColor.withOpacity(0.8)),
              onTap: () {
                Navigator.pop(context);
                _showStoreQrCodeDialog(context);
              }),
          ListTile(
              title: Text('가게 정보 수정',
                  style: TextStyle(
                      color: kDefaultFontColor.withOpacity(0.8), fontSize: 15)),
              leading: Icon(Icons.edit_rounded,
                  color: kDefaultFontColor.withOpacity(0.8)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, slidePageRouting(StoreEditScreen()));
              }),
          ListTile(
            title: Text('가게 삭제',
                style: TextStyle(color: Colors.red, fontSize: 15)),
            leading: Icon(Icons.delete_rounded, color: Colors.red),
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      title: Center(
                        child: Text('가게 삭제',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: kDefaultFontColor),
                            textAlign: TextAlign.center),
                      ),
                      content: IntrinsicHeight(
                        child: Column(children: [
                          Text("가게 삭제 시 모든 이벤트와 정보와 마케팅",
                              style: TextStyle(
                                  fontSize: 14, color: kDefaultFontColor)),
                          Text("보고서가 삭제되며 복구할 수 없습니다.",
                              style: TextStyle(
                                  fontSize: 14, color: kDefaultFontColor)),
                          Text("그래도 삭제하시겠습니까?",
                              style: TextStyle(
                                  fontSize: 14, color: kDefaultFontColor)),
                        ]),
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                      actions: [
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  await _deleteStore(context);
                                  Navigator.of(context).pop();
                                  await _showStoreDeleteCompleteDialog(context);
                                },
                                child: Text('예',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 13)),
                                style: ButtonStyle(
                                    overlayColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red.withOpacity(0.2))),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child:
                                    Text('아니오', style: TextStyle(fontSize: 13)),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red)),
                              ),
                            ],
                          ),
                        )
                      ],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))));
            },
          )
        ],
      ),
    ));
  }

  void _showStoreQrCodeDialog(context) {
    final qrcodeUrl = '$eventJoinUrl/$storeId';
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Center(
              child: Text('가게 이벤트 참여 QR 코드',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: kDefaultFontColor),
                  textAlign: TextAlign.center),
            ),
            content: IntrinsicHeight(
              child: Column(
                children: [
                  SizedBox(
                      child: QrImage(
                        data: qrcodeUrl,
                        version: QrVersions.auto,
                      ),
                      height: 150,
                      width: 150),
                  QrSaveButton(qrcodeUrl: qrcodeUrl)
                ],
              ),
            ),
            contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
            actions: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('닫기', style: TextStyle(fontSize: 13)),
                  style: ButtonStyle(
                      shadowColor:
                          MaterialStateProperty.all<Color>(kShadowColor),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kThemeColor)),
                ),
              )
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))));
  }

  Future<void> _deleteStore(BuildContext context) async {
    final storeId = context.read<SelectedStore>().id;

    var dio = await authDio(context);

    final deleteStoreResponse =
        await dio.delete(getApi(API.DELETE_STORE, suffix: '/$storeId'));

    final getUserStoreListResponse = await dio.get(getApi(API.GET_USER_STORES));

    final storeList = getUserStoreListResponse.data;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (storeList.length == 0) {
      prefs.remove('selectedStore');
      context.read<SelectedStore>().id = null;
    } else {
      final newSelectedStoreId = storeList.last['id'];
      prefs.setInt('selectedStore', newSelectedStoreId);
      context.read<SelectedStore>().id = newSelectedStoreId;
    }
  }

  Future<void> _showStoreDeleteCompleteDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Center(
              child: Text('가게 삭제',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: kDefaultFontColor),
                  textAlign: TextAlign.center),
            ),
            content: Text("가게 삭제가 완료되었습니다",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
            contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
            actions: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Widget nextWidget;
                    if (context.read<SelectedStore>().id == null)
                      nextWidget = CreateStoreScreen();
                    else
                      nextWidget = HallScreen();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => nextWidget),
                        (Route<dynamic> route) => false);
                  },
                  child: Text('확인', style: TextStyle(fontSize: 13)),
                  style: ButtonStyle(
                      shadowColor:
                          MaterialStateProperty.all<Color>(kShadowColor),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kThemeColor)),
                ),
              )
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))));
    Navigator.pop(context);
  }
}
