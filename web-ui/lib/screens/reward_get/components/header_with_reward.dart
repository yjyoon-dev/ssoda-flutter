import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker_web/api.dart';
import 'package:hashchecker_web/constants.dart';

class HeaderWithReward extends StatefulWidget {
  const HeaderWithReward({
    Key? key,
    required this.storeId,
    required this.rewardImagePath,
  }) : super(key: key);

  final storeId;
  final rewardImagePath;

  @override
  _HeaderWithRewardState createState() => _HeaderWithRewardState();
}

class _HeaderWithRewardState extends State<HeaderWithReward> {
  late Future<String> storeLogoPath;

  @override
  void initState() {
    super.initState();
    storeLogoPath = _fetchStoreLogoPathData();
  }

  Future<String> _fetchStoreLogoPathData() async {
    var dio = Dio();

    final getStoreResponse =
        await dio.get(getApi(API.GET_STORE, suffix: '/${widget.storeId}'));

    final fetchedStore = getStoreResponse.data;

    final String fetchedStoreLogoPath = fetchedStore['logoImagePath'];

    return fetchedStoreLogoPath;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.4 + size.width * 0.25,
      child: Stack(children: [
        Container(
          width: size.width,
          height: size.height * 0.4,
          child: ClipRRect(
              child: Image.asset(
                'assets/images/confetti.png',
                fit: BoxFit.cover,
              ),
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(150))),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(150)),
            color: kThemeColor.withOpacity(0.22),
          ),
        ),
        Positioned(
          child: Card(
            child: Column(children: [
              ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  child: Image.network(
                    '$s3Url${widget.rewardImagePath}',
                    fit: BoxFit.cover,
                    height: size.width * 0.5,
                    width: size.width * 0.5,
                  )),
            ]),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 12,
          ),
          bottom: 0,
          left: size.width * 0.25,
          right: size.width * 0.25,
        ),
        Positioned(
            bottom: size.width * 0.44,
            left: size.width * 0.425,
            right: size.width * 0.425,
            child: FutureBuilder<String>(
                future: storeLogoPath,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        height: size.width * 0.15,
                        width: size.width * 0.15,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                  color: Colors.black.withOpacity(0.3))
                            ],
                            color: kShadowColor,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage('$s3Url${snapshot.data}'),
                                fit: BoxFit.cover)));
                  } else if (snapshot.hasError) {
                    return buildErrorPage();
                  }
                  return Container(
                      height: size.width * 0.15,
                      width: size.width * 0.15,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            color: Colors.black.withOpacity(0.3))
                      ], color: kShadowColor, shape: BoxShape.circle));
                }))
      ]),
    );
  }
}
