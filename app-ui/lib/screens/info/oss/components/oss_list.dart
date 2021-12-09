import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/oss.dart';
import 'package:url_launcher/url_launcher.dart';

class OssList extends StatefulWidget {
  final index;
  const OssList({Key? key, required this.index}) : super(key: key);

  @override
  _OssListState createState() => _OssListState();
}

class _OssListState extends State<OssList> {
  late List<OSSTile> _ossList;

  @override
  void initState() {
    super.initState();
    _ossList = ossList;
    _ossList
        .sort((a, b) => a.name.toUpperCase().compareTo(b.name.toUpperCase()));
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      animationDuration: const Duration(milliseconds: 250),
      dividerColor: kDefaultFontColor,
      elevation: 0,
      expansionCallback: (item, status) {
        setState(() {
          _ossList[widget.index].isExpanded =
              !_ossList[widget.index].isExpanded;
        });
      },
      children: [
        ExpansionPanel(
          backgroundColor: kScaffoldBackgroundColor,
          headerBuilder: (context, isExpanded) => Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _ossList[widget.index].name,
                  style: TextStyle(
                      color: kDefaultFontColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: kDefaultPadding / 5),
                RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                        text: _ossList[widget.index].link,
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch(_ossList[widget.index].link);
                          })),
                SizedBox(height: kDefaultPadding / 10),
                Text(_ossList[widget.index].license.getLicenseName(),
                    style: TextStyle(
                        color: kLiteFontColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
                Text(
                  _ossList[widget.index].copyright,
                  style: TextStyle(color: kLiteFontColor, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade200,
            ),
            child: Text(_ossList[widget.index].license.getLicenseDescription(),
                style: TextStyle(fontSize: 12)),
          ),
          isExpanded: _ossList[widget.index].isExpanded,
        )
      ],
    );
  }
}
