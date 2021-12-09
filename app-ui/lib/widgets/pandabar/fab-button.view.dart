import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:hashchecker/constants.dart';

class PandaBarFabButton extends StatefulWidget {
  final double size;
  final VoidCallback? onTap;
  final List<Color>? colors;
  final Widget? icon;

  const PandaBarFabButton({
    Key? key,
    required this.size,
    required this.onTap,
    this.colors,
    this.icon,
  }) : super(key: key);

  @override
  _PandaBarFabButtonState createState() => _PandaBarFabButtonState();
}

class _PandaBarFabButtonState extends State<PandaBarFabButton> {
  bool _touched = false;

  @override
  Widget build(BuildContext context) {
    final _colors = widget.colors ??
        [
          kThemeColor,
          Color(0xFF5dc3d1),
        ];

    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: InkResponse(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: widget.onTap as void Function(),
        onHighlightChanged: (touched) {
          setState(() {
            _touched = touched;
          });
        },
        child: Transform.rotate(
          angle: 45 * math.pi / 180,
          child: Container(
            width: _touched ? widget.size - 1 : widget.size,
            height: _touched ? widget.size - 1 : widget.size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.size),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: _touched ? _colors : _colors.reversed.toList()),
            ),
            child: Center(
              child: Transform.rotate(
                  angle: -45 * math.pi / 180,
                  child: this.widget.icon ??
                      Icon(
                        Icons.add,
                        size: widget.size / 1.5,
                        color: Colors.white,
                      )),
            ),
          ),
        ),
      ),
    );
  }
}
