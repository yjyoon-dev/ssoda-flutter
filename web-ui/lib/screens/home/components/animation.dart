import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class ImageAnimation extends StatefulWidget {
  const ImageAnimation(
      {Key? key, required this.maxImgNum, required this.section})
      : super(key: key);

  final maxImgNum;
  final section;
  @override
  _ImageAnimationState createState() => _ImageAnimationState();
}

class _ImageAnimationState extends State<ImageAnimation> {
  late Timer _timer;
  var _currentImgNum = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_currentImgNum + 1 < widget.maxImgNum)
        setState(() {
          _currentImgNum++;
        });
      else
        _currentImgNum = -1;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 0.6,
        margin: const EdgeInsets.all(20),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) =>
              FadeTransition(opacity: animation, child: child),
          child: Image.asset(
            'assets/images/home/${widget.section}-$_currentImgNum.png',
            key: ValueKey<int>(_currentImgNum),
          ),
        ));
  }
}

class HorizontalAnimation extends StatefulWidget {
  const HorizontalAnimation(
      {Key? key, required this.maxImgNum, required this.section})
      : super(key: key);

  final maxImgNum;
  final section;
  @override
  _HorizontalAnimationState createState() => _HorizontalAnimationState();
}

class _HorizontalAnimationState extends State<HorizontalAnimation> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.6,
      child: CarouselSlider(
          options: CarouselOptions(
              initialPage: 1,
              enableInfiniteScroll: true,
              pauseAutoPlayInFiniteScroll: false,
              pauseAutoPlayOnManualNavigate: false,
              pauseAutoPlayOnTouch: false,
              autoPlayAnimationDuration: const Duration(seconds: 2),
              autoPlayInterval: const Duration(seconds: 2),
              autoPlayCurve: Curves.linear,
              autoPlay: true,
              height: size.height * 0.33,
              viewportFraction: 0.775,
              enlargeCenterPage: false),
          items: List.generate(
              widget.maxImgNum,
              (index) => ClipRRect(
                    child: Image.asset(
                        'assets/images/home/${widget.section}-$index.png'),
                    borderRadius: BorderRadius.circular(15),
                  ))),
    );
  }
}
