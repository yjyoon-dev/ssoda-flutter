import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event_report.dart';
import 'package:hashchecker/models/event_report_per_period.dart';
import 'package:number_display/number_display.dart';
import 'package:hashchecker/widgets/number_slider/number_slide_animation_widget.dart';

import 'delta_data.dart';
import 'report_design.dart';

class ExposureReport extends StatefulWidget {
  ExposureReport({Key? key, required this.eventReport, required this.period})
      : super(key: key);

  final EventReportPerPeriod eventReport;
  final numberDisplay = createDisplay();
  final EventReportPeriod period;

  @override
  _ExposureReportState createState() => _ExposureReportState();
}

class _ExposureReportState extends State<ExposureReport> {
  List<int> exposureList = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < min(7, widget.eventReport.exposureCount.length); i++)
      exposureList.add(widget.eventReport
          .exposureCount[widget.eventReport.exposureCount.length - i - 1]);

    exposureList = List.from(exposureList.reversed);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Color> gradientColors = [kThemeColor];

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
                value: widget.eventReport.exposureCount.length > 1
                    ? widget.eventReport.exposureCount.last -
                        widget.eventReport.exposureCount[
                            widget.eventReport.exposureCount.length - 2]
                    : widget.eventReport.exposureCount.last)
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
                  number: (widget.eventReport.exposureCount.last).toString(),
                  duration: kDefaultNumberSliderDuration,
                  curve: Curves.easeOut,
                  textStyle: TextStyle(
                      color: kThemeColor,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                  format: NumberFormatMode.comma),
              Text(
                ' 명에게 ',
                style: TextStyle(
                    color: kDefaultFontColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                '노출되었습니다',
                style: TextStyle(
                    color: kDefaultFontColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              )
            ],
          ),
          SizedBox(height: kDefaultPadding),
          SizedBox(
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_outline_rounded,
                  size: 48,
                  color: kDefaultFontColor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('1',
                        style: TextStyle(
                          color: kThemeColor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        )),
                    Text('인 노출 당 ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: kDefaultFontColor)),
                    NumberSlideAnimation(
                        number: widget.eventReport.exposureCount.last == 0
                            ? '0'
                            : '${(widget.eventReport.expenditureCount.last ~/ widget.eventReport.exposureCount.last)}',
                        duration: kDefaultNumberSliderDuration,
                        curve: Curves.easeOut,
                        textStyle: TextStyle(
                            color: kThemeColor,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                        format: NumberFormatMode.comma),
                    Text('원 사용',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: kDefaultFontColor))
                  ],
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                Container(
                  width: size.width * 0.7,
                  height: 100,
                  child: LineChart(LineChartData(
                    lineTouchData: LineTouchData(
                        touchTooltipData:
                            LineTouchTooltipData(tooltipBgColor: Colors.white)),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: kShadowColor,
                          strokeWidth: 0,
                        );
                      },
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                          color: kShadowColor,
                          strokeWidth: 1,
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: SideTitles(
                        showTitles: false,
                      ),
                      leftTitles: SideTitles(
                        interval: _getStandardDeviation(exposureList),
                        showTitles: true,
                        getTextStyles: (context, value) => const TextStyle(
                          color: kLiteFontColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        getTitles: (value) {
                          final numberDisplay = createDisplay(
                              length: 3,
                              roundingType: RoundingType.ceil,
                              units: ['K', 'M', 'G', 'T', 'P']);

                          return numberDisplay(value.toInt());
                        },
                        reservedSize: 14,
                        margin: 12,
                      ),
                    ),
                    borderData: FlBorderData(
                        show: true,
                        border: Border.all(
                            color: const Color(0xff37434d), width: 0)),
                    minX: 0,
                    maxX: 6,
                    minY: 0,
                    maxY: exposureList.reduce(max).toDouble(),
                    lineBarsData: [
                      LineChartBarData(
                        spots: List.generate(
                            exposureList.length,
                            (index) => FlSpot(index.toDouble(),
                                exposureList[index].toDouble())),
                        isCurved: false,
                        colors: gradientColors,
                        barWidth: 5,
                        isStrokeCapRound: false,
                        dotData: FlDotData(
                          show: true,
                        ),
                        belowBarData: BarAreaData(
                          show: false,
                          colors: gradientColors
                              .map((color) => color.withOpacity(0.3))
                              .toList(),
                        ),
                      ),
                    ],
                  )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _getStandardDeviation(List<int> list) {
    int sum = list.reduce((a, b) => a + b);
    if (sum == 0) return 100;
    double ave = sum / list.length;
    double variance = 0;
    list.forEach((element) {
      variance += (element - ave) * (element - ave);
    });
    variance /= list.length;
    double stdDev = sqrt(variance);
    if (stdDev <= 0) return list.reduce(max).toDouble();
    return stdDev;
  }
}
