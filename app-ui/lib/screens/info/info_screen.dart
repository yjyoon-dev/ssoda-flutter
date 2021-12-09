import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/selected_store.dart';
import 'package:hashchecker/models/store.dart';
import 'package:hashchecker/models/user.dart';
import 'package:hashchecker/screens/info/components/app_info.dart';
import 'package:hashchecker/screens/info/components/app_setting.dart';
import 'package:hashchecker/screens/info/components/user_info.dart';
import 'package:provider/provider.dart';

import 'components/store_info.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late Future<User> user;
  late Future<Store> store;

  @override
  void initState() {
    super.initState();
    user = _fetchUserData();
    store = _fetchStoreData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: kScaffoldBackgroundColor,
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '내 계정',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: kDefaultFontColor),
            ),
            SizedBox(height: kDefaultPadding / 1.5),
            FutureBuilder<User>(
                future: user,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return UserInfo(user: snapshot.data!);
                  } else if (snapshot.hasError) {
                    return buildErrorPage();
                  }

                  return Center(child: const CircularProgressIndicator());
                }),
            SizedBox(height: kDefaultPadding * 2),
            Text(
              '내 가게',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: kDefaultFontColor),
            ),
            SizedBox(height: kDefaultPadding / 1.5),
            FutureBuilder<Store>(
                future: store,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return StoreInfo(store: snapshot.data!);
                  } else if (snapshot.hasError) {
                    return buildErrorPage();
                  }

                  return Center(child: const CircularProgressIndicator());
                }),
            SizedBox(height: kDefaultPadding * 2),
            Text(
              '앱 설정',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: kDefaultFontColor),
            ),
            AppSetting(),
            SizedBox(height: kDefaultPadding * 2),
            Text(
              '앱 정보',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: kDefaultFontColor),
            ),
            AppInfo(),
            SizedBox(height: 45)
          ],
        ),
      ),
    );
  }

  Future<User> _fetchUserData() async {
    var dio = await authDio(context);

    final getUserResponse = await dio.get(getApi(API.GET_USER_INFO));

    final User fetchedUser = User.fromJson(getUserResponse.data);

    return fetchedUser;
  }

  Future<Store> _fetchStoreData() async {
    var dio = await authDio(context);

    final storeId = context.read<SelectedStore>().id;

    final getStoreResponse =
        await dio.get(getApi(API.GET_STORE, suffix: '/$storeId'));

    final fetchedStore = getStoreResponse.data;

    return Store.fromJson(fetchedStore);
  }
}
