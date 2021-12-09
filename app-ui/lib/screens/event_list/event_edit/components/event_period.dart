import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class EventPeriodEdit extends StatefulWidget {
  final event;
  final startDatePickerController;
  final finishDatePickerController;
  const EventPeriodEdit(
      {Key? key,
      required this.event,
      required this.startDatePickerController,
      required this.finishDatePickerController})
      : super(key: key);

  @override
  _EventPeriodEditState createState() => _EventPeriodEditState();
}

class _EventPeriodEditState extends State<EventPeriodEdit> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      bool showDateErr = false;
                      return StatefulBuilder(
                          builder: (context, setDialogState) {
                        return AlertDialog(
                          contentPadding:
                              const EdgeInsets.fromLTRB(12, 10, 12, 0),
                          actionsPadding:
                              const EdgeInsets.fromLTRB(12, 0, 12, 4),
                          content: IntrinsicHeight(
                            child: Column(
                              children: [
                                Container(
                                    width: size.width * 0.8,
                                    height: size.height * 0.5,
                                    child: SfDateRangePicker(
                                      selectionMode:
                                          DateRangePickerSelectionMode.single,
                                      selectionColor: kThemeColor,
                                      todayHighlightColor: kThemeColor,
                                      showNavigationArrow: true,
                                      initialSelectedDate:
                                          widget.event.period.startDate,
                                      monthCellStyle:
                                          DateRangePickerMonthCellStyle(
                                              todayTextStyle: TextStyle(
                                                  color: kThemeColor,
                                                  fontSize: 12)),
                                      yearCellStyle:
                                          DateRangePickerYearCellStyle(
                                              todayTextStyle: TextStyle(
                                                  color: kThemeColor,
                                                  fontSize: 12)),
                                      controller:
                                          widget.startDatePickerController,
                                    )),
                                if (showDateErr == true)
                                  Text('시작 날짜가 종료 날짜보다 앞서 있어요!',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12))
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('취소')),
                            ElevatedButton(
                                onPressed: () {
                                  if (widget.event.period.finishDate != null &&
                                      widget.startDatePickerController
                                          .selectedDate!
                                          .isAfter(widget
                                              .event.period.finishDate!)) {
                                    setDialogState(() {
                                      showDateErr = true;
                                    });
                                    widget.startDatePickerController
                                            .selectedDate =
                                        widget.event.period.startDate;
                                    return;
                                  }
                                  setState(() {
                                    if (widget.startDatePickerController
                                            .selectedDate !=
                                        null)
                                      widget.event.period.startDate = widget
                                          .startDatePickerController
                                          .selectedDate!;
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text('확인'))
                          ],
                        );
                      });
                    });
              },
              child: Row(
                children: [
                  Icon(Icons.calendar_today_rounded,
                      color: kDefaultFontColor.withOpacity(0.85), size: 16),
                  SizedBox(width: kDefaultPadding / 3),
                  Text(
                    widget.event.period.startDate.toString().substring(0, 10),
                    style:
                        TextStyle(color: kDefaultFontColor.withOpacity(0.85)),
                  ),
                ],
              ),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  elevation: MaterialStateProperty.all<double>(4.0),
                  shadowColor: MaterialStateProperty.all<Color>(
                      kShadowColor.withOpacity(0.3)),
                  overlayColor: MaterialStateProperty.all<Color>(kShadowColor),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.fromLTRB(8, 8, 12, 8)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      kScaffoldBackgroundColor)),
            ),
            SizedBox(width: kDefaultPadding),
            Text('~', style: TextStyle(color: kDefaultFontColor)),
            SizedBox(width: kDefaultPadding),
            widget.event.period.finishDate == null
                ? Text('상품 소진 시까지',
                    style: TextStyle(
                        color: kDefaultFontColor.withOpacity(0.85),
                        fontSize: 14,
                        fontWeight: FontWeight.bold))
                : ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            bool showDateErr = false;
                            return StatefulBuilder(
                              builder: (context, setDialogState) => AlertDialog(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(12, 10, 12, 0),
                                actionsPadding:
                                    const EdgeInsets.fromLTRB(12, 0, 12, 4),
                                content: IntrinsicHeight(
                                  child: Column(
                                    children: [
                                      Container(
                                          width: size.width * 0.8,
                                          height: size.height * 0.5,
                                          child: SfDateRangePicker(
                                            selectionMode:
                                                DateRangePickerSelectionMode
                                                    .single,
                                            selectionColor: kThemeColor,
                                            todayHighlightColor: kThemeColor,
                                            showNavigationArrow: true,
                                            initialSelectedDate:
                                                widget.event.period.finishDate,
                                            monthCellStyle:
                                                DateRangePickerMonthCellStyle(
                                                    todayTextStyle: TextStyle(
                                                        color: kThemeColor,
                                                        fontSize: 12)),
                                            yearCellStyle:
                                                DateRangePickerYearCellStyle(
                                                    todayTextStyle: TextStyle(
                                                        color: kThemeColor,
                                                        fontSize: 12)),
                                            controller: widget
                                                .finishDatePickerController,
                                          )),
                                      if (showDateErr == true)
                                        Text('시작 날짜가 종료 날짜보다 앞서 있어요!',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12))
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('취소')),
                                  ElevatedButton(
                                      onPressed: () {
                                        if (widget.finishDatePickerController
                                                    .selectedDate !=
                                                null &&
                                            widget.event.period.startDate
                                                .isAfter(widget
                                                    .finishDatePickerController
                                                    .selectedDate!)) {
                                          setDialogState(() {
                                            showDateErr = true;
                                          });
                                          widget.finishDatePickerController
                                                  .selectedDate =
                                              widget.event.period.finishDate;
                                          return;
                                        }
                                        setState(() {
                                          if (widget.finishDatePickerController
                                                  .selectedDate !=
                                              null)
                                            widget.event.period.finishDate =
                                                widget
                                                    .finishDatePickerController
                                                    .selectedDate!;
                                        });

                                        Navigator.pop(context);
                                      },
                                      child: Text('확인'))
                                ],
                              ),
                            );
                          });
                    },
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today_rounded,
                            color: kDefaultFontColor.withOpacity(0.85),
                            size: 16),
                        SizedBox(width: kDefaultPadding / 3),
                        Text(
                            widget.event.period.finishDate
                                .toString()
                                .substring(0, 10),
                            style: TextStyle(
                                color: kDefaultFontColor.withOpacity(0.85))),
                      ],
                    ),
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        elevation: MaterialStateProperty.all<double>(4.0),
                        shadowColor: MaterialStateProperty.all<Color>(
                            kShadowColor.withOpacity(0.3)),
                        overlayColor:
                            MaterialStateProperty.all<Color>(kShadowColor),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.fromLTRB(8, 8, 12, 8)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            kScaffoldBackgroundColor)),
                  ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              value: widget.event.period.finishDate == null,
              onChanged: (value) {
                setState(() {
                  if (value!)
                    widget.event.period.finishDate = null;
                  else
                    widget.event.period.finishDate =
                        widget.event.period.startDate.add(Duration(days: 30));
                });
              },
              activeColor: kThemeColor,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (widget.event.period.finishDate != null)
                    widget.event.period.finishDate = null;
                  else
                    widget.event.period.finishDate =
                        widget.event.period.startDate.add(Duration(days: 30));
                });
                widget.finishDatePickerController.selectedDate =
                    widget.event.period.finishDate;
              },
              child: Text('상품 소진 시까지 영구진행',
                  style: TextStyle(
                      fontSize: 14,
                      color: widget.event.period.finishDate == null
                          ? kThemeColor
                          : kLiteFontColor)),
            )
          ],
        )
      ],
    );
  }
}
