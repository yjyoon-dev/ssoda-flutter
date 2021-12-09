import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

class PandaBarButton extends StatefulWidget {
  final IconData icon;
  final String title;
  final bool isSelected;

  final VoidCallback? onTap;

  final Color? selectedColor;
  final Color? unselectedColor;

  const PandaBarButton(
      {Key? key,
      this.isSelected = false,
      this.icon = Icons.dashboard,
      this.selectedColor,
      this.unselectedColor,
      this.title = '',
      this.onTap})
      : super(key: key);

  @override
  _PandaBarButtonState createState() => _PandaBarButtonState();
}

class _PandaBarButtonState extends State<PandaBarButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: Duration(milliseconds: 700),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    animation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 10), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 10, end: 0), weight: 50),
    ]).chain(CurveTween(curve: Curves.bounceOut)).animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkResponse(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: widget.onTap as void Function(),
        onHighlightChanged: (touched) {
          if (!touched) {
            animationController.forward().whenCompleteOrCancel(() {
              animationController.reset();
            });
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(widget.icon,
                color: widget.isSelected
                    ? (widget.selectedColor ?? kThemeColor)
                    : (widget.unselectedColor ?? Color(0xFF9FACBE))),
            Container(
              height: animation.value,
            ),
            Text(widget.title,
                style: TextStyle(
                    color: widget.isSelected
                        ? (widget.selectedColor ?? kThemeColor)
                        : (widget.unselectedColor ?? Color(0xFF9FACBE)),
                    fontWeight: FontWeight.bold,
                    fontSize: 10))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
