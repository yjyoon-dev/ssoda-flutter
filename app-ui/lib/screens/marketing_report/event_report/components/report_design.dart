import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

final reportBoxDecoration = BoxDecoration(boxShadow: [
  BoxShadow(
    color: kShadowColor,
    spreadRadius: 5,
    blurRadius: 20,
    offset: Offset(0, 0), // changes position of shadow
  ),
], color: kScaffoldBackgroundColor, borderRadius: BorderRadius.circular(20));
