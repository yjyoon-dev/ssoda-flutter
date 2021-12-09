import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker_web/constants.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Colors.white,
          ),
          SizedBox(height: kDefaultPadding),
          SizedBox(
            height: 40,
            child: DefaultTextStyle(
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    TyperAnimatedText('잠시만 기다려주세요...',
                        speed: Duration(milliseconds: 200))
                  ],
                )),
          ),
          SizedBox(height: kDefaultPadding / 3),
          Text(
            '인스타그램 게시글을 검사 중입니다.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
