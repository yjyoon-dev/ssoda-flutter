import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/address.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/models/event_list_item.dart';
import 'package:hashchecker/models/selected_store.dart';
import 'package:hashchecker/models/store.dart';
import 'package:hashchecker/models/store_category.dart';
import 'package:hashchecker/screens/event_list/components/event_list.dart';
import 'package:hashchecker/screens/event_list/components/store_header.dart';
import 'package:provider/provider.dart';
import 'components/empty.dart';
import 'components/event_list_tile.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({Key? key}) : super(key: key);

  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  late Future<Store> store;
  late Future<List<EventListItem>> eventList;
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

  @override
  void initState() {
    super.initState();
    store = _fetchStoreData();
    eventList = _fetchEventListData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          toolbarHeight: 0,
          expandedHeight: size.width / 3 * 2 * 1.525,
          backgroundColor: kScaffoldBackgroundColor,
          flexibleSpace: FlexibleSpaceBar(
              background: FutureBuilder<Store>(
                  future: store,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return StoreHeader(store: snapshot.data!);
                    } else if (snapshot.hasError) {
                      return buildErrorPage();
                    }

                    return Center(child: const CircularProgressIndicator());
                  })),
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
                                eventList = _fetchEventListData();
                              });
                            },
                            items:
                                _eventSortDropdownItemList.map((String value) {
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
                                            color:
                                                _selectedStatusFilter == index
                                                    ? kScaffoldBackgroundColor
                                                    : kThemeColor),
                                      ),
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all<
                                                  EdgeInsetsGeometry>(
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
                (context, index) => FutureBuilder<List<EventListItem>>(
                    future: eventList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return EventList(
                            size: size,
                            eventList: snapshot.data!,
                            selectedStatusFilter: _selectedStatusFilter,
                            statusStringMap: _statusStringMap,
                            statusFilterString: _statusFilterString,
                            statusColorMap: _statusColorMap);
                      } else if (snapshot.hasError) {
                        return buildErrorPage();
                      }

                      return Center(child: const CircularProgressIndicator());
                    }),
                childCount: 1))
      ],
    ));
  }

  Future<Store> _fetchStoreData() async {
    var dio = await authDio(context);

    final storeId = context.read<SelectedStore>().id;

    final getStoreResponse =
        await dio.get(getApi(API.GET_STORE, suffix: '/$storeId'));

    final fetchedStore = getStoreResponse.data;

    return Store.fromJson(fetchedStore);
  }

  Future<List<EventListItem>> _fetchEventListData() async {
    var dio = await authDio(context);

    final storeId = context.read<SelectedStore>().id;

    final getEventListResponse = await dio
        .get(getApi(API.GET_EVENTS_OF_STORE, suffix: '/$storeId/events'));

    final fetchedEventList = getEventListResponse.data;

    List<EventListItem> eventList = List.generate(fetchedEventList.length,
        (index) => EventListItem.fromJson(fetchedEventList[index]));

    if (dropdownValue == "최신 등록 순")
      eventList = List.from(eventList.reversed);
    else if (dropdownValue == "빠른 종료 순")
      eventList.sort((a, b) => a.finishDate.compareTo(b.finishDate));
    else if (dropdownValue == "가나다 순")
      eventList.sort((a, b) => a.title.compareTo(b.title));

    return eventList;
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
