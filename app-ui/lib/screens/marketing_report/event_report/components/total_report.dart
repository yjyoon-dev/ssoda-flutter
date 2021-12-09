import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event_report_total_sum.dart';

import './total_report/expenditure_report_total.dart';
import './total_report/exposure_report_total.dart';
import './total_report/participation_report_total.dart';

class TotalReport extends StatelessWidget {
  const TotalReport(
      {Key? key, required this.eventReport, required this.eventRewardCount})
      : super(key: key);

  final EventReportTotalSum eventReport;
  final int eventRewardCount;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: kDefaultPadding),
          ExposureReportTotal(eventReport: eventReport),
          ParticipationReportTotal(eventReport: eventReport),
          ExpenditureReportTotal(
              eventReport: eventReport, eventRewardCount: eventRewardCount),
        ],
      ),
    );
  }
}
