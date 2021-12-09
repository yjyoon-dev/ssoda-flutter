import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/address.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/models/store.dart';
import 'package:hashchecker/models/store_category.dart';
import 'package:hashchecker/screens/create_store/create_store_screen.dart';
import 'package:hashchecker/widgets/pandabar/pandabar.dart';

enum TabPage { EVENT, REPORT, RANKING, INFO }

class CreateStoreIntroScreen extends StatefulWidget {
  const CreateStoreIntroScreen({Key? key}) : super(key: key);

  @override
  _CreateStoreIntroScreenState createState() => _CreateStoreIntroScreenState();
}

class _CreateStoreIntroScreenState extends State<CreateStoreIntroScreen> {
  final _eventSortDropdownItemList = ['최신 등록 순', '빠른 종료 순', '가나다 순'];
  final _statusFilterString = ['전체', '진행 중', '대기 중', '종료'];
  final _statusStringMap = {
    EventStatus.WAITING: '대기 중',
    EventStatus.PROCEEDING: '진행 중',
    EventStatus.ENDED: '종료'
  };
  final _statusColorMap = {
    EventStatus.WAITING: kLiteFontColor,
    EventStatus.PROCEEDING: kThemeColor,
    EventStatus.ENDED: kDefaultFontColor
  };
  String dropdownValue = '최신 등록 순';
  int _selectedStatusFilter = 0;

  Store store = Store(
      name: '우리가게 쏘다점',
      category: StoreCategory.RESTAURANT,
      address: Address(
          city: '서울시',
          country: '강남구',
          town: '역삼동',
          road: '테헤란로',
          building: '311',
          zipCode: '06151',
          latitude: null,
          longitude: null),
      description: "",
      images: ['assets/images/sample/store_image_sample.png'],
      logoImage: 'assets/images/sample/store_logo_sample.png');
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: kScaffoldBackgroundColor,
            shadowColor: kShadowColor,
            elevation: 1,
            title: Container(
              padding: const EdgeInsets.only(left: 1),
              child: Image.asset('assets/images/appbar_logo.png'),
              height: kToolbarHeight * 0.75,
            ),
            actions: [
              Container(
                  height: kToolbarHeight * 0.5,
                  width: kToolbarHeight * 0.5,
                  decoration: BoxDecoration(
                      color: kShadowColor,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('${store.logoImage}'),
                          fit: BoxFit.cover))),
              SizedBox(width: kDefaultPadding)
            ]),
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
            _showStoreCreateDialog();
          },
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: 0,
              expandedHeight: size.width / 3 * 2 * 1.525,
              backgroundColor: kScaffoldBackgroundColor,
              flexibleSpace: FlexibleSpaceBar(
                  background: Stack(children: [
                Column(children: [
                  Container(
                    height: size.width / 3 * 2 + size.width * 0.1,
                    color: kScaffoldBackgroundColor,
                    child: Stack(children: [
                      CarouselSlider(
                        options: CarouselOptions(
                            autoPlay: false,
                            height: size.width / 3 * 2,
                            viewportFraction: 1.0,
                            enlargeCenterPage: false,
                            aspectRatio: 4 / 3),
                        items: store.images
                            .map((item) => GestureDetector(
                                  onTap: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                            content: Stack(children: [
                                              ClipRRect(
                                                child: Image.asset(
                                                  '$item',
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              Positioned(
                                                  right: 12,
                                                  top: 12,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Icon(
                                                      Icons.close_rounded,
                                                      color: Colors.white,
                                                    ),
                                                  ))
                                            ]),
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15))));
                                  },
                                  child: Container(
                                    child: Center(
                                        child: Stack(children: [
                                      Image.asset(
                                        '$item',
                                        fit: BoxFit.cover,
                                        width: size.width,
                                      ),
                                      Container(
                                          decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            kScaffoldBackgroundColor,
                                            kScaffoldBackgroundColor
                                                .withOpacity(0)
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.center,
                                        ),
                                      ))
                                    ])),
                                  ),
                                ))
                            .toList(),
                      ),
                      Positioned(
                          bottom: 0,
                          right: size.width * 0.4,
                          left: size.width * 0.4,
                          child: GestureDetector(
                            onTap: () async {
                              await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                      content: Stack(children: [
                                        ClipRRect(
                                          child: Image.asset(
                                              '${store.logoImage}',
                                              fit: BoxFit.cover),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        Positioned(
                                            right: 12,
                                            top: 12,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Icon(
                                                Icons.close_rounded,
                                                color: kDefaultFontColor,
                                              ),
                                            ))
                                      ]),
                                      contentPadding: const EdgeInsets.all(0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))));
                            },
                            child: Container(
                                height: size.width * 0.2,
                                width: size.width * 0.2,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 0.5,
                                          spreadRadius: 0.5,
                                          offset: Offset(0, 0),
                                          color: kDefaultFontColor
                                              .withOpacity(0.2))
                                    ],
                                    color: kShadowColor,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage('${store.logoImage}'),
                                        fit: BoxFit.cover))),
                          ))
                    ]),
                  ),
                  SizedBox(height: kDefaultPadding * 1.2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        store.name,
                        style: TextStyle(
                            color: kDefaultFontColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        maxLines: 1,
                        minFontSize: 12,
                      ),
                      SizedBox(width: kDefaultPadding / 3),
                      Icon(storeCategoryIconMap[store.category],
                          size: 18, color: kDefaultFontColor.withOpacity(0.75)),
                    ],
                  ),
                  SizedBox(height: kDefaultPadding / 2),
                  Text(store.address.getFullAddress(),
                      style: TextStyle(color: kLiteFontColor, fontSize: 14)),
                ]),
                Material(
                  color: Colors.white.withOpacity(0),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context, slidePageRouting(CreateStoreScreen()));
                      },
                      overlayColor:
                          MaterialStateProperty.all<Color>(kShadowColor),
                      child: Container(
                          color: kShadowColor.withOpacity(0.4),
                          width: size.width,
                          height: size.height,
                          child: Center(
                            child: Stack(children: [
                              Positioned(
                                  left: 1.0,
                                  top: 1.0,
                                  child: Icon(Icons.add,
                                      color: kShadowColor.withOpacity(0.8),
                                      size: 72)),
                              Icon(Icons.add, color: Colors.white, size: 72),
                            ]),
                          ))),
                ),
              ])),
              floating: false,
              elevation: 0,
            ),
            SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                    minHeight: 100,
                    maxHeight: 100,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      color: kScaffoldBackgroundColor,
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '이벤트 목록',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: kDefaultFontColor),
                            ),
                            DropdownButton(
                                dropdownColor:
                                    kScaffoldBackgroundColor.withOpacity(0.9),
                                value: dropdownValue,
                                icon: const Icon(
                                  Icons.sort_rounded,
                                  color: kDefaultFontColor,
                                  size: 20,
                                ),
                                iconSize: 24,
                                elevation: 0,
                                style: TextStyle(
                                    color: kDefaultFontColor, fontSize: 13),
                                underline: Container(
                                  height: 0,
                                  color: kDefaultFontColor,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                },
                                items: _eventSortDropdownItemList
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: SizedBox(
                                        width: 85,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: kDefaultFontColor),
                                          textAlign: TextAlign.center,
                                        )),
                                  );
                                }).toList())
                          ],
                        ),
                        SizedBox(height: kDefaultPadding / 3),
                        Row(
                            children: List.generate(
                                _statusFilterString.length,
                                (index) => Container(
                                      height: 30,
                                      width: 60,
                                      margin: const EdgeInsets.only(right: 8),
                                      child: TextButton(
                                          onPressed: () {
                                            setState(() {
                                              _selectedStatusFilter = index;
                                            });
                                          },
                                          child: Text(
                                            _statusFilterString[index],
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: _selectedStatusFilter ==
                                                        index
                                                    ? kScaffoldBackgroundColor
                                                    : kThemeColor),
                                          ),
                                          style: ButtonStyle(
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsetsGeometry>(
                                                      EdgeInsets.all(0)),
                                              backgroundColor:
                                                  MaterialStateProperty.all<Color>(
                                                      _selectedStatusFilter == index
                                                          ? kThemeColor
                                                          : Colors.transparent),
                                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(27.0),
                                                      side: BorderSide(color: kThemeColor))))),
                                    ))),
                      ]),
                    ))),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => Container(
                          child: Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: kDefaultPadding),
                                  Icon(Icons.lightbulb_outline_rounded),
                                  SizedBox(height: kDefaultPadding),
                                  Text('가게를 등록하면 이벤트를 만들 수 있어요!')
                                ]),
                          ),
                        ),
                    childCount: 1))
          ],
        ));
  }

  void _showStoreCreateDialog() async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
            title: Center(
              child: Text('우리가게 등록',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: kDefaultFontColor),
                  textAlign: TextAlign.center),
            ),
            content: Text("서비스를 이용하시려면\n먼저 가게를 등록해야 해요!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
            contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
            actions: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(context)
                        .push(slidePageRouting(CreateStoreScreen()));
                  },
                  child: Text('등록하러 가기', style: TextStyle(fontSize: 13)),
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

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  // 2
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  // 3
  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
