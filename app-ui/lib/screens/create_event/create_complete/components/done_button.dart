import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/screens/hall/hall_screen.dart';

class DoneButton extends StatelessWidget {
  const DoneButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 20),
      height: 50,
      child: TextButton(
        child: Text(
          '확인',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.pushAndRemoveUntil(context, slidePageRouting(HallScreen()),
              (Route<dynamic> route) => false);
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(kThemeColor),
            overlayColor: MaterialStateProperty.all<Color>(kShadowColor),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.0)))),
      ),
    );
  }
}
