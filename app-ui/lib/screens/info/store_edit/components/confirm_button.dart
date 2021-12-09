import 'package:dio/dio.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/selected_store.dart';
import 'package:hashchecker/models/store.dart';
import 'package:hashchecker/screens/hall/hall_screen.dart';
import 'package:provider/provider.dart';

class ConfirmButton extends StatelessWidget {
  final Store store;
  final List<String> newImages;
  final List<String> deletedImagePaths;
  const ConfirmButton(
      {Key? key,
      required this.store,
      required this.newImages,
      required this.deletedImagePaths})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          if (_checkStoreValidation(context)) {
            _showUpdateStoreDialog(context);
          }
        },
        child: Text(
          '수정하기',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        style: ButtonStyle(
            shadowColor: MaterialStateProperty.all<Color>(kShadowColor),
            backgroundColor: MaterialStateProperty.all<Color>(kThemeColor),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.0)))),
      ),
    );
  }

  bool _checkStoreValidation(BuildContext context) {
    if (store.name.trim() == "") {
      _showValidationErrorFlashBar(context, '가게 이름을 입력해주세요!');
      return false;
    }
    if (store.images.length == 0) {
      _showValidationErrorFlashBar(context, '가게 이미지를 최소 1개 등록해주세요!');
      return false;
    }

    if (store.description.trim() == "") {
      _showValidationErrorFlashBar(context, '가게 소개를 입력해주세요!');
      return false;
    }
    return true;
  }

  void _showValidationErrorFlashBar(BuildContext context, String message) {
    context.showFlashBar(
        barType: FlashBarType.error,
        icon: const Icon(Icons.error_outline_rounded),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.white,
        content: Text(message,
            style: TextStyle(fontSize: 14, color: kDefaultFontColor)));
  }

  Future<void> _updateStore(BuildContext context) async {
    var dio = await authDio(context);

    dio.options.contentType = 'multipart/form-data';

    var storeData = FormData.fromMap({
      'name': store.name.trim(),
      'category': store.category.index,
      'description': store.description.trim(),
      if (newImages.length > 0)
        'newImages': List.generate(newImages.length,
            (index) => MultipartFile.fromFileSync(newImages[index])),
      if (deletedImagePaths.length > 0)
        'deleteImagePaths': List.generate(
            deletedImagePaths.length, (index) => deletedImagePaths[index]),
      if (store.logoImage.startsWith(kNewImagePrefix))
        'logoImage': await MultipartFile.fromFile(
            store.logoImage.substring(kNewImagePrefix.length)),
      'city': store.address.city,
      'country': store.address.country,
      'town': store.address.town,
      'road': store.address.road,
      'buildingCode': store.address.building,
      'zipCode': store.address.zipCode,
      'latitude': store.address.latitude,
      'longitude': store.address.longitude
    });

    final storeId = context.read<SelectedStore>().id;

    final createStoreResponse = await dio
        .put(getApi(API.UPDATE_STORE, suffix: '/$storeId'), data: storeData);
  }

  Future<void> _showUpdateStoreDialog(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Center(
              child: Text('우리가게 등록',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: kDefaultFontColor),
                  textAlign: TextAlign.center),
            ),
            content: IntrinsicHeight(
              child: Column(children: [
                Text("이대로 수정하시겠습니까?",
                    style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
              ]),
            ),
            contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
            actions: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await showProgressDialog(
                            context, _updateStore(context));
                        Navigator.of(context).pop();
                        await _showDoneDialog(context);
                      },
                      child: Text('예',
                          style: TextStyle(color: Colors.white, fontSize: 13)),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(kThemeColor)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('아니오',
                          style: TextStyle(color: kThemeColor, fontSize: 13)),
                      style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all<Color>(
                              kThemeColor.withOpacity(0.2))),
                    ),
                  ],
                ),
              )
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))));
  }

  Future<void> _showDoneDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Center(
              child: Text('완료',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: kDefaultFontColor),
                  textAlign: TextAlign.center),
            ),
            content: Text("가게 정보가 수정되었습니다",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
            contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
            actions: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        slidePageRouting(HallScreen()),
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
  }
}
