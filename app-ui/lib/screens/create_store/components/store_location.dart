import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/address.dart';
import 'package:hashchecker/widgets/kpostal/kpostal.dart';

class StoreLocation extends StatelessWidget {
  final setAddress;
  final zipCodeController;
  final addressController;
  const StoreLocation(
      {Key? key,
      required this.setAddress,
      required this.zipCodeController,
      required this.addressController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          child: Row(
            children: [
              Icon(Icons.location_on_rounded, color: kLiteFontColor),
              SizedBox(width: kDefaultPadding),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: kShadowColor,

                          blurRadius: 4,
                          offset: Offset(2, 2), // changes position of shadow
                        ),
                      ],
                      color: kScaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                    readOnly: true,
                    style: TextStyle(fontSize: 14, color: kDefaultFontColor),
                    controller: zipCodeController,
                    decoration: InputDecoration(
                        counterText: "",
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: kThemeColor, width: 1),
                            borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: kScaffoldBackgroundColor, width: 0),
                            borderRadius: BorderRadius.circular(12)),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        hintText: '우편번호',
                        hintStyle: TextStyle(color: kLiteFontColor)),
                  ),
                ),
              ),
              SizedBox(width: kDefaultPadding / 2),
              ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => KpostalView(
                        title: '주소 검색',
                        appBarColor: kScaffoldBackgroundColor,
                        titleColor: kDefaultFontColor,
                        loadingColor: kThemeColor,
                        callback: (Kpostal result) {
                          Address address = Address(
                              city: result.sido,
                              country: result.sigungu,
                              town: result.bname,
                              road: result.roadname,
                              building: result.address.split(' ').last,
                              zipCode: result.postCode,
                              latitude: result.latitude,
                              longitude: result.longitude);
                          setAddress(address);
                        },
                      ),
                    ),
                  );
                },
                child: Text(
                  '주소 검색',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
                style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all<Color>(Colors.white24),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(kThemeColor),
                    shadowColor: MaterialStateProperty.all<Color>(kShadowColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)))),
              ),
            ],
          ),
        ),
        SizedBox(height: kDefaultPadding / 2),
        Row(
          children: [
            Icon(Icons.location_on_rounded, color: kScaffoldBackgroundColor),
            SizedBox(width: kDefaultPadding),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: kShadowColor,

                        blurRadius: 4,
                        offset: Offset(2, 2), // changes position of shadow
                      ),
                    ],
                    color: kScaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(12)),
                child: TextField(
                  readOnly: true,
                  style: TextStyle(fontSize: 14, color: kDefaultFontColor),
                  controller: addressController,
                  decoration: InputDecoration(
                      counterText: "",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kThemeColor, width: 1),
                          borderRadius: BorderRadius.circular(12)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: kScaffoldBackgroundColor, width: 0),
                          borderRadius: BorderRadius.circular(12)),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      hintText: '주소',
                      hintStyle: TextStyle(color: kLiteFontColor)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
