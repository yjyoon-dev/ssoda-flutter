import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/selected_store.dart';
import 'package:hashchecker/models/store.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';

class StoreEditScreen extends StatefulWidget {
  const StoreEditScreen({Key? key}) : super(key: key);

  @override
  _StoreEditScreenState createState() => _StoreEditScreenState();
}

class _StoreEditScreenState extends State<StoreEditScreen> {
  late Future<Store> store;
  final List<String> newImages = [];
  final List<String> deletedImagePaths = [];

  @override
  void initState() {
    super.initState();
    store = _fetchStoreData();
  }

  Future<Store> _fetchStoreData() async {
    var dio = await authDio(context);

    final storeId = context.read<SelectedStore>().id;

    final getStoreResponse =
        await dio.get(getApi(API.GET_STORE, suffix: '/$storeId'));

    final fetchedStore = getStoreResponse.data;

    return Store.fromJson(fetchedStore);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kScaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            '가게 정보 수정',
            style: TextStyle(
                color: kDefaultFontColor, fontWeight: FontWeight.bold),
          )),
      body: WillPopScope(
        onWillPop: () async {
          bool shouldClose = true;
          await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                  title: Center(
                    child: Text('가게 정보 수정',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: kDefaultFontColor),
                        textAlign: TextAlign.center),
                  ),
                  content: IntrinsicHeight(
                    child: Column(children: [
                      Text("저장되지 않은 내용이 있습니다.",
                          style: TextStyle(
                              fontSize: 14, color: kDefaultFontColor)),
                      SizedBox(height: kDefaultPadding / 5),
                      Text("그래도 나가시겠습니까?",
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
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('예',
                                style: TextStyle(
                                    color: kThemeColor, fontSize: 13)),
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all<Color>(
                                    kThemeColor.withOpacity(0.2))),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              shouldClose = false;
                              Navigator.of(context).pop();
                            },
                            child: Text('아니오', style: TextStyle(fontSize: 13)),
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
          return shouldClose;
        },
        child: FutureBuilder<Store>(
            future: store,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Body(
                    store: snapshot.data!,
                    newImages: newImages,
                    deletedImagePaths: deletedImagePaths);
              } else if (snapshot.hasError) {
                return buildErrorPage();
              }

              return Center(child: const CircularProgressIndicator());
            }),
      ),
    );
  }
}
