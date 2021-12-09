import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/widgets/holo_date_picker/flutter_holo_date_picker.dart';

import 'step_text.dart';

class EventPeriod extends StatefulWidget {
  final event;
  EventPeriod({Key? key, required this.event}) : super(key: key);

  @override
  _EventPeriodState createState() => _EventPeriodState();
}

class _EventPeriodState extends State<EventPeriod>
    with SingleTickerProviderStateMixin {
  final _dateRangeList = ['30일 간', '다음 달까지', '올해까지', '영구 진행', '직접 입력'];
  String? _dropdownValue;

  @override
  void initState() {
    super.initState();
    _dropdownValue = widget.event.period.shortCut ?? '30일 간';
    widget.event.period.finishDate =
        widget.event.period.startDate.add(Duration(days: 30));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StepText(step: 3),
              ]),
          SizedBox(height: kDefaultPadding),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: kScaffoldBackgroundColor,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: DatePickerWidget(
                    looping: true,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 3,
                        DateTime.now().month, DateTime.now().day),
                    initialDate: widget.event.period.startDate,
                    dateFormat: "yyyy-MMMM-dd",
                    locale: DateTimePickerLocale.ko,
                    onChange: (DateTime newDate, _) {
                      setState(() {
                        widget.event.period.startDate = newDate;
                        if (_dropdownValue == _dateRangeList[0]) {
                          widget.event.period.finishDate = widget
                              .event.period.startDate
                              .add(Duration(days: 30));
                        } else if (_dropdownValue == _dateRangeList[1]) {
                          widget.event.period.finishDate = DateTime(
                                  widget.event.period.startDate.year,
                                  widget.event.period.startDate.month + 2,
                                  1)
                              .subtract(Duration(days: 1));
                        } else if (_dropdownValue == _dateRangeList[2]) {
                          widget.event.period.finishDate = DateTime(
                                  widget.event.period.startDate.year + 1, 1, 1)
                              .subtract(Duration(days: 1));
                        } else if (_dropdownValue == _dateRangeList[3]) {
                          widget.event.period.finishDate = null;
                        }
                      });
                    },
                    pickerTheme: DateTimePickerTheme(
                      backgroundColor: kScaffoldBackgroundColor,
                      itemTextStyle:
                          TextStyle(color: kDefaultFontColor, fontSize: 19),
                      dividerColor: kThemeColor,
                    ),
                  ),
                ),
                Text('부터',
                    style: TextStyle(fontSize: 18, color: kDefaultFontColor)),
                AnimatedSize(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  vsync: this,
                  child: Container(
                    height: _dropdownValue == _dateRangeList.last ? 190 : 0,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: DatePickerWidget(
                            looping: true,
                            firstDate: widget.event.period.startDate,
                            lastDate: DateTime(DateTime.now().year + 3,
                                DateTime.now().month, DateTime.now().day),
                            initialDate: widget.event.period.finishDate ??
                                widget.event.period.startDate,
                            dateFormat: "yyyy-MMMM-dd",
                            locale: DateTimePickerLocale.ko,
                            onChange: (DateTime newDate, _) {
                              widget.event.period.finishDate = newDate;
                            },
                            pickerTheme: DateTimePickerTheme(
                              backgroundColor: kScaffoldBackgroundColor,
                              itemTextStyle: TextStyle(
                                  color: kDefaultFontColor, fontSize: 19),
                              dividerColor: kThemeColor,
                            ),
                          ),
                        ),
                        Text('까지',
                            style: TextStyle(
                                fontSize: 18, color: kDefaultFontColor)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: kDefaultPadding),
                DropdownButton(
                    dropdownColor: kScaffoldBackgroundColor.withOpacity(0.9),
                    value: _dropdownValue,
                    icon: const Icon(
                      Icons.date_range_outlined,
                      color: kThemeColor,
                    ),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(fontSize: 18, color: kDefaultFontColor),
                    underline: Container(
                      height: 2,
                      color: kThemeColor,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _dropdownValue = newValue!;
                        widget.event.period.shortCut = newValue;

                        if (_dropdownValue == _dateRangeList[0]) {
                          widget.event.period.finishDate = widget
                              .event.period.startDate
                              .add(Duration(days: 30));
                        } else if (_dropdownValue == _dateRangeList[1]) {
                          widget.event.period.finishDate = DateTime(
                                  widget.event.period.startDate.year,
                                  widget.event.period.startDate.month + 2,
                                  1)
                              .subtract(Duration(days: 1));
                        } else if (_dropdownValue == _dateRangeList[2]) {
                          widget.event.period.finishDate = DateTime(
                                  widget.event.period.startDate.year + 1, 1, 1)
                              .subtract(Duration(days: 1));
                        } else if (_dropdownValue == _dateRangeList[3]) {
                          widget.event.period.finishDate = null;
                        }
                      });
                    },
                    items: _dateRangeList
                        .map((e) => DropdownMenuItem(
                            child: SizedBox(
                              width: 100,
                              child: Text(
                                e,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: kDefaultFontColor),
                              ),
                            ),
                            value: e))
                        .toList()),
                Visibility(
                  child: Text(
                      widget.event.period.finishDate != null
                          ? '${widget.event.period.finishDate!.toString().substring(0, 10)} 까지에요!'
                          : '이벤트 상품 소진 시까지 진행해요!',
                      style: TextStyle(fontSize: 14, color: kLiteFontColor)),
                  visible: _dropdownValue != _dateRangeList.last,
                ),
              ],
            ),
          )
        ]);
  }
}
