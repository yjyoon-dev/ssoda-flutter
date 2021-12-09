import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/user.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'user_options_modal.dart';

class UserInfo extends StatelessWidget {
  final User user;
  const UserInfo({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Material(
          color: Colors.white.withOpacity(0),
          child: InkWell(
            onTap: () => showMaterialModalBottomSheet(
                backgroundColor: Colors.transparent,
                expand: false,
                context: context,
                builder: (context) => UserOptionsModal()),
            highlightColor: kShadowColor,
            overlayColor: MaterialStateProperty.all<Color>(kShadowColor),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                          color: kShadowColor,
                          shape: BoxShape.circle,
                          image: user.picture == null
                              ? null
                              : DecorationImage(
                                  image: NetworkImage(user.picture!),
                                  fit: BoxFit.cover))),
                  SizedBox(width: kDefaultPadding),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.name ?? "",
                            style: TextStyle(
                                color: kDefaultFontColor, fontSize: 14)),
                        SizedBox(height: kDefaultPadding / 5),
                        Text(user.email ?? "카카오 계정",
                            style:
                                TextStyle(color: kLiteFontColor, fontSize: 12))
                      ])
                ],
              ),
            ),
          ),
        ),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: kShadowColor,
                spreadRadius: 1,
                blurRadius: 6,
                offset: Offset(3, 3), // changes position of shadow
              ),
            ],
            color: kScaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(12)));
  }
}
