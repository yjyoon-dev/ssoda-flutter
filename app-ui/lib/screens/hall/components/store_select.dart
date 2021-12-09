import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/selected_store.dart';
import 'package:hashchecker/models/store_list_item.dart';
import 'package:hashchecker/screens/create_store/create_store_screen.dart';
import 'package:hashchecker/screens/hall/hall_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class StoreSelect extends StatefulWidget {
  final selectedStoreId;
  final List<StoreListItem> storeList;
  const StoreSelect({
    Key? key,
    required this.selectedStoreId,
    required this.storeList,
  }) : super(key: key);

  @override
  _StoreSelectState createState() => _StoreSelectState();
}

class _StoreSelectState extends State<StoreSelect> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) {
        if (value as int == -1) {
          Navigator.push(context, slidePageRouting(CreateStoreScreen()));
        } else {
          _setSelectedStore(value);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HallScreen()),
              (Route<dynamic> route) => false);
        }
      },
      icon: Container(
          height: kToolbarHeight * 0.55,
          width: kToolbarHeight * 0.55,
          decoration: BoxDecoration(
              color: kShadowColor,
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(
                      '$s3Url${widget.storeList[widget.storeList.indexWhere((element) => element.id == widget.selectedStoreId)].logo}'),
                  fit: BoxFit.cover))),
      itemBuilder: (context) {
        final List<PopupMenuEntry<Object>> storeSelectionList = List.generate(
            widget.storeList.length,
            (index) => PopupMenuItem(
                value: widget.storeList[index].id,
                child: Row(
                  children: [
                    Container(
                        height: kToolbarHeight * 0.5,
                        width: kToolbarHeight * 0.5,
                        decoration: BoxDecoration(
                            color: kShadowColor,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    '$s3Url${widget.storeList[index].logo}'),
                                fit: BoxFit.contain))),
                    SizedBox(width: kDefaultPadding),
                    Text(
                      widget.storeList[index].name,
                      style: TextStyle(color: kDefaultFontColor, fontSize: 14),
                    )
                  ],
                )));
        storeSelectionList.add(PopupMenuDivider());
        storeSelectionList.add(PopupMenuItem(
            value: -1,
            child: Row(
              children: [
                Container(
                  height: kToolbarHeight * 0.5,
                  width: kToolbarHeight * 0.5,
                  child: Icon(Icons.add, color: kLiteFontColor),
                ),
                SizedBox(width: kDefaultPadding),
                Text(
                  '가게 추가하기',
                  style: TextStyle(color: kLiteFontColor, fontSize: 14),
                )
              ],
            )));
        return storeSelectionList;
      },
    );
  }

  Future<void> _setSelectedStore(int storeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('selectedStore', storeId);

    context.read<SelectedStore>().id = storeId;
  }
}
