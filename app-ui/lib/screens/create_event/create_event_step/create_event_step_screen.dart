import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/requires.dart';

import 'components/body.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/models/period.dart';
import 'package:hashchecker/models/template.dart';

class CreateEventStepScreen extends StatefulWidget {
  const CreateEventStepScreen({Key? key}) : super(key: key);

  @override
  _CreateEventStepScreenState createState() => _CreateEventStepScreenState();
}

class _CreateEventStepScreenState extends State<CreateEventStepScreen> {
  int step = 0;
  int prevStep = -1;
  final maxStep = 5;

  late Event savingEvent;

  @override
  void initState() {
    super.initState();

    savingEvent = Event(
        title: "",
        rewardList: [null],
        hashtagList: ["쏘다"],
        period: Period(
            DateTime.now(), DateTime.now().add(Duration(days: 30)), null),
        images: [null],
        requireList: List.generate(requireStringList.length, (index) => false),
        template: Template(0),
        rewardPolicy: kRewardPolicyRandom);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          appBar: buildAppBar(),
          body: Body(
              step: step,
              prevStep: prevStep,
              maxStep: maxStep,
              plusStep: plusStep,
              event: savingEvent)),
      onWillPop: () async {
        bool result = _onBackPressed();
        return await Future.value(result);
      },
    );
  }

  bool _onBackPressed() {
    if (step > 0) {
      setState(() {
        prevStep = step;
        step--;
      });
    } else {
      Navigator.of(context).pop();
    }

    return false;
  }

  void plusStep() {
    setState(() {
      prevStep = step;
      step++;
    });
  }

  AppBar buildAppBar() {
    return AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: kDefaultFontColor),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              if (step > 0) {
                setState(() {
                  step--;
                });
              } else {
                Navigator.of(context).pop();
              }
            }));
  }
}
