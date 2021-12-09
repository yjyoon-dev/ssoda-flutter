import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

class EasterEggScreen extends StatefulWidget {
  const EasterEggScreen({Key? key}) : super(key: key);

  @override
  _EasterEggScreenState createState() => _EasterEggScreenState();
}

class _EasterEggScreenState extends State<EasterEggScreen> {
  var _boom = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: kThemeColor,
        body: Container(
          padding: const EdgeInsets.all(5),
          height: size.height,
          child: Center(
            child: AnimatedCrossFade(
                duration: const Duration(milliseconds: 500),
                firstChild: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Stack(
                          children: [
                            Image.asset('assets/images/easter_egg/logo.png',
                                width: size.width),
                            Positioned(
                              bottom: size.height * 0.075,
                              right: size.width * 0.42,
                              child: DragTarget(
                                builder:
                                    (context, canidateData, rejectedData) =>
                                        CircleAvatar(
                                  backgroundColor: kThemeColor,
                                  maxRadius: size.width * 0.022,
                                ),
                                onAccept: (data) {
                                  setState(() {
                                    _boom = true;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Draggable(
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                maxRadius: size.width * 0.022,
                              ),
                            ),
                            feedback: CircleAvatar(
                              backgroundColor: Colors.white,
                              maxRadius: size.width * 0.022,
                            ),
                            childWhenDragging: CircleAvatar(
                              backgroundColor: kThemeColor,
                            ),
                            data: "SSODA"))
                  ],
                ),
                secondChild: OtpTextField(
                  numberOfFields: 4,
                  autoFocus: _boom ? true : false,
                  borderColor: Colors.white60,
                  enabledBorderColor: Colors.white60,
                  focusedBorderColor: Colors.white,
                  cursorColor: Colors.white,
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                  borderWidth: 5.0,
                  fieldWidth: size.width * 0.15,
                  onSubmit: (code) {
                    if (code == "0422")
                      launch("https://blog.naver.com/sw_maestro/222556553980");
                    else {
                      setState(() {
                        _boom = false;
                      });
                    }
                  },
                ),
                crossFadeState: _boom
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst),
          ),
        ));
  }
}
