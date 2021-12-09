import 'package:flutter/material.dart';
import 'package:hashchecker/models/event.dart';
import 'components/body.dart';

class EventPreviewScreen extends StatelessWidget {
  final Event event;
  const EventPreviewScreen({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Body(event: event));
  }
}
