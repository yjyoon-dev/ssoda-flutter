import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/store.dart';

class StoreName extends StatefulWidget {
  final Store store;
  const StoreName({Key? key, required this.store}) : super(key: key);

  @override
  _StoreNameState createState() => _StoreNameState();
}

class _StoreNameState extends State<StoreName> {
  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.store.name);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.store_rounded, color: kLiteFontColor),
        SizedBox(width: kDefaultPadding),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: kShadowColor,

                    blurRadius: 4,
                    offset: Offset(2, 2), // changes position of shadow
                  ),
                ],
                color: kScaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(12)),
            child: TextField(
              style: TextStyle(fontSize: 14, color: kDefaultFontColor),
              cursorColor: kThemeColor,
              keyboardType: TextInputType.text,
              onChanged: (string) {
                widget.store.name = string;
              },
              controller: _titleController,
              decoration: InputDecoration(
                  counterText: "",
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kThemeColor, width: 1),
                      borderRadius: BorderRadius.circular(12)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: kScaffoldBackgroundColor, width: 0),
                      borderRadius: BorderRadius.circular(12)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  hintText: '가게명',
                  hintStyle: TextStyle(color: kLiteFontColor)),
              maxLength: 20,
            ),
          ),
        )
      ],
    );
  }
}
