import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event_report.dart';
import 'package:hashchecker/models/event_report_per_period.dart';

import 'expenditure_report.dart';
import 'exposure_report.dart';
import 'participate_report.dart';

class MonthlyReport extends StatelessWidget {
  const MonthlyReport(
      {Key? key, required this.eventReport, required this.eventRewardCount})
      : super(key: key);

  final EventReportPerPeriod eventReport;
  final int eventRewardCount;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(height: kDefaultPadding),
        ExposureReport(
            eventReport: eventReport, period: EventReportPeriod.MONTH),
        ParticipationReport(
            eventReport: eventReport, period: EventReportPeriod.MONTH),
        ExpenditureReport(
            eventReport: eventReport,
            eventRewardCount: eventRewardCount,
            period: EventReportPeriod.MONTH),
      ]),
    );
  }
}
