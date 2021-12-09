import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:qr_flutter/qr_flutter.dart';

class JoinQrCode extends StatelessWidget {
  final storeId;
  const JoinQrCode({Key? key, required this.storeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('이벤트 참여',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: kDefaultFontColor)),
      SizedBox(height: kDefaultPadding),
      SizedBox(
          child: QrImage(
            data: '$eventJoinUrl/$storeId',
            version: QrVersions.auto,
          ),
          height: size.width * 0.33,
          width: size.width * 0.33)
    ]);
  }
}
