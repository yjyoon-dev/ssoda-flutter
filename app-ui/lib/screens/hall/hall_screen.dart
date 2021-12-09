import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/selected_store.dart';
import 'package:hashchecker/models/store.dart';
import 'package:hashchecker/models/store_list_item.dart';
import 'package:hashchecker/screens/easter_egg/easter_egg_screen.dart';
import 'package:hashchecker/screens/event_list/event_list_screen.dart';
import 'package:hashchecker/screens/hall/components/store_select.dart';
import 'package:hashchecker/screens/info/info_screen.dart';
import 'package:hashchecker/screens/marketing_report/store_report/store_report_screen.dart';
import 'package:hashchecker/screens/ranking/ranking_screen.dart';
import 'package:hashchecker/widgets/pandabar/pandabar.dart';
import 'package:provider/provider.dart';

enum TabPage { EVENT, REPORT, RANKING, INFO }

class HallScreen extends StatefulWidget {
  const HallScreen({Key? key}) : super(key: key);

  @override
  _HallScreenState createState() => _HallScreenState();
}

class _HallScreenState extends State<HallScreen> {
  late Future<List<StoreListItem>> storeList;
  late int currentStoreIndexOnList;
  late int selectedStoreId;
  TabPage currentPage = TabPage.EVENT;

  final pageMap = {
    TabPage.EVENT: EventListScreen(),
    TabPage.REPORT: StoreReportScreen(),
    TabPage.RANKING: RankingScreen(),
    TabPage.INFO: InfoScreen(),
  };

  @override
  void initState() {
    super.initState();
    storeList = _fetchStoreListData();
  }

  @override
  Widget build(BuildContext context) {
    selectedStoreId = context.read<SelectedStore>().id!;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kScaffoldBackgroundColor,
        shadowColor: kShadowColor,
        elevation: 1,
        title: GestureDetector(
          onLongPress: () {
            Navigator.push(context, slidePageRouting(EasterEggScreen()));
          },
          child: Container(
            padding: const EdgeInsets.only(left: 1),
            child: Image.asset('assets/images/appbar_logo.png'),
            height: kToolbarHeight * 0.75,
          ),
        ),
        actions: [
          FutureBuilder<List<StoreListItem>>(
              future: storeList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return StoreSelect(
                      selectedStoreId: selectedStoreId,
                      storeList: snapshot.data!);
                } else if (snapshot.hasError) {
                  return buildErrorPage();
                }

                return Container(
                    height: kToolbarHeight * 0.5,
                    width: kToolbarHeight * 0.5,
                    decoration: BoxDecoration(
                      color: kShadowColor,
                      shape: BoxShape.circle,
                    ));
              }),
          SizedBox(width: kDefaultPadding / 3)
        ],
      ),
      bottomNavigationBar: PandaBar(
        backgroundColor: Colors.white,
        buttonData: [
          PandaBarButtonData(
              id: TabPage.EVENT, icon: Icons.grid_view_rounded, title: '이벤트'),
          PandaBarButtonData(
              id: TabPage.REPORT,
              icon: Icons.description_rounded,
              title: '보고서'),
          PandaBarButtonData(
              id: TabPage.RANKING, icon: Icons.star_rounded, title: '랭킹'),
          PandaBarButtonData(
              id: TabPage.INFO,
              icon: Icons.account_circle_rounded,
              title: 'MY'),
        ],
        onChange: (id) {
          setState(() {
            currentPage = id;
          });
        },
      ),
      body: PageTransitionSwitcher(
        transitionBuilder: (
          Widget child,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: pageMap[currentPage],
      ),
    );
  }

  Future<List<StoreListItem>> _fetchStoreListData() async {
    var dio = await authDio(context);

    final getStoreListResponse = await dio.get(getApi(API.GET_USER_STORES));

    final fetchedStoreList = getStoreListResponse.data;

    List<StoreListItem> storeList = List.generate(fetchedStoreList.length,
        (index) => StoreListItem.fromJson(fetchedStoreList[index]));

    final selectedStoreIndex =
        storeList.indexWhere((element) => element.id == selectedStoreId);

    final currentStoreListItem = StoreListItem(
        id: storeList[selectedStoreIndex].id,
        name: storeList[selectedStoreIndex].name,
        logo: storeList[selectedStoreIndex].logo);

    storeList.removeAt(selectedStoreIndex);

    storeList.insert(0, currentStoreListItem);
    return storeList;
  }
}
