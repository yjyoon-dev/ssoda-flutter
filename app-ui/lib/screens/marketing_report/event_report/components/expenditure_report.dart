import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event_report.dart';
import 'package:hashchecker/models/event_report_per_period.dart';
import 'package:hashchecker/screens/marketing_report/event_report/components/delta_data.dart';
import 'package:number_display/number_display.dart';
import 'dart:math';

import 'package:hashchecker/widgets/number_slider/number_slide_animation_widget.dart';

import 'report_design.dart';

class ExpenditureReport extends StatefulWidget {
  const ExpenditureReport(
      {Key? key,
      required this.eventReport,
      required this.eventRewardCount,
      required this.period})
      : super(key: key);

  final EventReportPerPeriod eventReport;
  final int eventRewardCount;
  final EventReportPeriod period;

  @override
  _ExpenditureReportState createState() => _ExpenditureReportState();
}

class _ExpenditureReportState extends State<ExpenditureReport> {
  final Duration animDuration = const Duration(milliseconds: 250);
  final numberDisplay = createDisplay();

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(20),
      width: size.width,
      margin: const EdgeInsets.fromLTRB(5, 5, 5, 15),
      decoration: reportBoxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(periodStringMap[widget.period]!,
                style: TextStyle(
                    color: kDefaultFontColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14)),
            DeltaData(
              value: (widget.eventReport.expenditureCount.length > 1
                  ? widget.eventReport.expenditureCount.last -
                      widget.eventReport.expenditureCount[
                          widget.eventReport.expenditureCount.length - 2]
                  : widget.eventReport.expenditureCount.last),
            )
          ]),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: 5.0,
            children: [
              Text('총 ',
                  style: TextStyle(
                      color: kDefaultFontColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              NumberSlideAnimation(
                number: (widget.eventReport.expenditureCount.last).toString(),
                duration: kDefaultNumberSliderDuration,
                curve: Curves.easeOut,
                textStyle: TextStyle(
                    color: kThemeColor,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
                format: NumberFormatMode.comma,
              ),
              Text(
                ' 원 ',
                style: TextStyle(
                    color: kDefaultFontColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                '사용하였습니다',
                style: TextStyle(
                    color: kDefaultFontColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              )
            ],
          ),
          SizedBox(height: kDefaultPadding),
          Container(
            height: 200,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            width: size.width,
            child: BarChart(mainBarData()),
          )
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    double width = 30,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: y,
          colors: [kThemeColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: widget.eventReport.levelExpenditure.reduce(max).toDouble() * 1.1,
            colors: [Colors.transparent],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(
      widget.eventRewardCount,
      (i) => makeGroupData(i, widget.eventReport.levelExpenditure[i].toDouble(),
          isTouched: i == touchedIndex));

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: kScaffoldBackgroundColor.withOpacity(0.8),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${numberDisplay(rod.y.toInt())}원',
                TextStyle(
                  color: kThemeColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              );
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! PointerUpEvent &&
                barTouchResponse.touchInput is! PointerExitEvent) {
              touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
              color: kDefaultFontColor,
              fontWeight: FontWeight.bold,
              fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return '1단계';
              case 1:
                return '2단계';
              case 2:
                return '3단계';
              case 3:
                return '4단계';
              case 4:
                return '5단계';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }
}
