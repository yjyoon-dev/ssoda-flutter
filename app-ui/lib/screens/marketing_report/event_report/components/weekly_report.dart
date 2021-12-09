import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event_report.dart';
import 'package:hashchecker/models/event_report_per_period.dart';
import 'package:hashchecker/screens/marketing_report/event_report/components/participate_report.dart';

import 'expenditure_report.dart';
import 'exposure_report.dart';

class WeeklyReport extends StatelessWidget {
  const WeeklyReport(
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
            eventReport: eventReport, period: EventReportPeriod.WEEK),
        ParticipationReport(
            eventReport: eventReport, period: EventReportPeriod.WEEK),
        ExpenditureReport(
            eventReport: eventReport,
            eventRewardCount: eventRewardCount,
            period: EventReportPeriod.WEEK),
      ]),
    );
  }
}
