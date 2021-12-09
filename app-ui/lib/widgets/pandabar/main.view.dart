import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/selected_store.dart';
import 'package:hashchecker/screens/create_event/create_event_step/create_event_step_screen.dart';
import 'package:hashchecker/screens/create_store/create_store_screen.dart';
import 'package:provider/provider.dart';
import 'fab-button.view.dart';
import 'model.dart';
import 'pandabar.dart';

class PandaBar extends StatefulWidget {
  final Color? backgroundColor;
  final List<PandaBarButtonData> buttonData;
  final Widget? fabIcon;

  final Color? buttonColor;
  final Color? buttonSelectedColor;
  final List<Color>? fabColors;

  final Function(dynamic selectedPage) onChange;
  final VoidCallback? onFabButtonPressed;

  const PandaBar({
    Key? key,
    required this.buttonData,
    required this.onChange,
    this.backgroundColor,
    this.fabIcon,
    this.fabColors,
    this.onFabButtonPressed,
    this.buttonColor,
    this.buttonSelectedColor,
  }) : super(key: key);

  @override
  _PandaBarState createState() => _PandaBarState();
}

class _PandaBarState extends State<PandaBar> {
  final double fabSize = 55;
  final Color unSelectedColor = kLiteFontColor;

  dynamic selectedId;

  @override
  void initState() {
    selectedId =
        widget.buttonData.length > 0 ? widget.buttonData.first.id : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final clipper = _PandaBarClipper(fabSize: fabSize);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CustomPaint(
          painter: _ClipShadowPainter(
            shadow: Shadow(
                color: kShadowColor, blurRadius: 10, offset: Offset(0, -2)),
            clipper: clipper,
          ),
          child: ClipPath(
            clipper: clipper,
            child: Container(
              height: 60,
              padding: EdgeInsets.symmetric(vertical: 10),
              color: widget.backgroundColor ?? Color(0xFF222427),
              child: Builder(builder: (context) {
                List<Widget> leadingChildren = [];
                List<Widget> trailingChildren = [];

                widget.buttonData.asMap().forEach((i, data) {
                  Widget btn = PandaBarButton(
                    icon: data.icon,
                    title: data.title,
                    isSelected: data.id != null && selectedId == data.id,
                    unselectedColor: widget.buttonColor,
                    selectedColor: widget.buttonSelectedColor,
                    onTap: () {
                      setState(() {
                        selectedId = data.id;
                      });
                      this.widget.onChange(data.id);
                    },
                  );

                  if (i < 2) {
                    leadingChildren.add(btn);
                  } else {
                    trailingChildren.add(btn);
                  }
                });

                return Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: leadingChildren,
                      ),
                    ),
                    Container(width: fabSize),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: trailingChildren,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
        OpenContainer<bool>(
          transitionType: ContainerTransitionType.fade,
          openBuilder: (BuildContext context, VoidCallback _) {
            if (context.read<SelectedStore>().id != null)
              return const CreateEventStepScreen();
            else
              return const CreateStoreScreen();
          },
          tappable: false,
          closedElevation: 0,
          closedColor: Colors.white,
          closedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(360))),
          closedBuilder: (BuildContext _, VoidCallback openContainer) {
            return PandaBarFabButton(
              size: fabSize,
              icon: widget.fabIcon,
              onTap: openContainer,
              colors: widget.fabColors,
            );
          },
        )
      ],
    );
  }
}

class _PandaBarClipper extends CustomClipper<Path> {
  final double fabSize;
  final double padding = 40;
  final double centerRadius = 25;
  final double cornerRadius = 35;

  _PandaBarClipper({this.fabSize = 100});

  @override
  Path getClip(Size size) {
    final xCenter = (size.width / 2);

    final fabSizeWithPadding = fabSize + padding;

    final path = Path();
    path.lineTo((xCenter - (fabSizeWithPadding / 2) - cornerRadius), 0);
    path.quadraticBezierTo(xCenter - (fabSizeWithPadding / 2), 0,
        (xCenter - (fabSizeWithPadding / 2)) + cornerRadius, cornerRadius);
    path.lineTo(
        xCenter - centerRadius, (fabSizeWithPadding / 2) - centerRadius);
    path.quadraticBezierTo(xCenter, (fabSizeWithPadding / 2),
        xCenter + centerRadius, (fabSizeWithPadding / 2) - centerRadius);
    path.lineTo(
        (xCenter + (fabSizeWithPadding / 2) - cornerRadius), cornerRadius);
    path.quadraticBezierTo(xCenter + (fabSizeWithPadding / 2), 0,
        (xCenter + (fabSizeWithPadding / 2) + cornerRadius), 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(oldClipper) => false;
}

class _ClipShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  _ClipShadowPainter({required this.shadow, required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
