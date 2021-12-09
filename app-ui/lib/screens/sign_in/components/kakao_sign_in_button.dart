import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

class KakaoSignInButton extends StatelessWidget {
  const KakaoSignInButton({Key? key, required this.size, required this.signIn})
      : super(key: key);

  final Size size;
  final VoidCallback signIn;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      child: TextButton(
          onPressed: signIn,
          child: Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                'assets/images/sign_in/kakao_logo.png',
                width: 30,
                height: 30,
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.9),
              ),
              SizedBox(width: kDefaultPadding / 5),
              Text(
                '카카오로 시작하기 ',
                style: TextStyle(
                  color: Color(0xFF191919),
                  fontSize: 16,
                ),
              )
            ]),
          ),
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all<Color>(
                  Colors.white.withOpacity(0.1)),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.fromLTRB(20, 8, 20, 8)),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xFFFFE500)),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))))),
    );
  }
}
