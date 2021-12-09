import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/models/reward.dart';
import 'package:hashchecker/models/selected_store.dart';
import 'package:hashchecker/screens/create_event/create_complete/create_complete_screen.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class CreateEventButton extends StatelessWidget {
  final Event event;
  final ScreenshotController screenshotController;
  CreateEventButton(
      {Key? key, required this.event, required this.screenshotController})
      : super(key: key);

  String? templateImagePath;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        child: Text(
          '이대로 등록하기',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        onPressed: () async {
          await showProgressDialog(context, _eventCreateProcess(context));
          if (templateImagePath != null)
            Navigator.of(context).pushAndRemoveUntil(
                slidePageRouting(
                    CreateCompleteScreen(templateImage: templateImagePath!)),
                (Route<dynamic> route) => false);
        },
        style: ButtonStyle(
            shadowColor: MaterialStateProperty.all<Color>(kShadowColor),
            backgroundColor: MaterialStateProperty.all<Color>(kThemeColor),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.0)))),
      ),
    );
  }

  Future<void> _eventCreateProcess(BuildContext context) async {
    templateImagePath = await _saveTemplateImage(context);

    final storeId = context.read<SelectedStore>().id!;

    await _createEvent(context, storeId);
  }

  Future<void> _createEvent(BuildContext context, int storeId) async {
    var dio = await authDio(context);

    dio.options.contentType = 'multipart/form-data';

    var eventData = FormData.fromMap({
      'title': event.title,
      'startDate': DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime(
          event.period.startDate.year,
          event.period.startDate.month,
          event.period.startDate.day,
          0,
          0,
          0)),
      'finishDate': event.period.finishDate == null
          ? null
          : DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime(
              event.period.finishDate!.year,
              event.period.finishDate!.month,
              event.period.finishDate!.day,
              23,
              59,
              59)),
      'images': List.generate(event.images.length,
          (index) => MultipartFile.fromFileSync(event.images[index]!)),
      'hashtags': event.hashtagList,
      'requirements': event.requireList,
      'template': event.template.id,
      'rewardPolicy': event.rewardPolicy
    });

    var eventResponse = await dio
        .post(getApi(API.CREATE_EVENT, suffix: '/$storeId'), data: eventData);

    print(eventResponse.data);
    var rewardsData = FormData();

    for (int i = 0; i < event.rewardList.length; i++) {
      if (event.rewardList[i] == null) continue;
      rewardsData.fields
          .add(MapEntry('rewards[$i].name', event.rewardList[i]!.name));
      rewardsData.fields.add(
          MapEntry('rewards[$i].level', event.rewardList[i]!.level.toString()));
      rewardsData.fields.add(
          MapEntry('rewards[$i].price', event.rewardList[i]!.price.toString()));
      rewardsData.fields.add(
          MapEntry('rewards[$i].count', event.rewardList[i]!.count.toString()));
      rewardsData.fields.add(MapEntry('rewards[$i].category',
          event.rewardList[i]!.category.index.toString()));
      rewardsData.files.add(MapEntry('rewards[$i].image',
          MultipartFile.fromFileSync(event.rewardList[i]!.imgPath)));
    }

    var rewardsResponse = await dio.post(
        getApi(API.CREATE_REWARDS, suffix: '/${eventResponse.data}'),
        data: rewardsData);
    print(rewardsResponse.data);
  }

  Future<String> _saveTemplateImage(BuildContext context) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    final result = await screenshotController.captureAndSave(tempPath);

    return result!;
  }
}
