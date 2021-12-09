import 'package:flutter/material.dart';
import 'package:hashchecker_web/constants.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: kLiteFontColor,
      width: size.width,
      padding: const EdgeInsets.fromLTRB(30, 40, 30, 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Rocketdan', style: TextStyle(color: Colors.white, fontSize: 12)),
        SizedBox(height: kDefaultPadding * 1.2),
        Text('서울특별시 강남구 테헤란로 311(역삼동) 아남타워 7층',
            style: TextStyle(color: Colors.white, fontSize: 11)),
        SizedBox(height: kDefaultPadding / 3),
        Text('rocket.ssoda@gmail.com',
            style: TextStyle(color: Colors.white, fontSize: 12)),
        SizedBox(height: kDefaultPadding * 1.2),
        Text('이용약관', style: TextStyle(color: Colors.white, fontSize: 11)),
        SizedBox(height: kDefaultPadding / 3),
        Text('개인정보보호정책', style: TextStyle(color: Colors.white, fontSize: 11)),
        SizedBox(height: kDefaultPadding * 1.2),
        Text(
            'SSODA는 과학기술정보통신부와 정보통신기획평가원이 주관하고 한국정보산업연합회에서 운영하는 SW 마에스트로 12기 연수생 로켓단팀이 개발한 서비스입니다.',
            style: TextStyle(color: Colors.white, fontSize: 9)),
        SizedBox(height: kDefaultPadding * 2),
        Center(
          child: Text(
            'ⓒ 2021 Rocketdan All rights reserved.',
            style: TextStyle(color: Colors.white, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        )
      ]),
    );
  }
}
