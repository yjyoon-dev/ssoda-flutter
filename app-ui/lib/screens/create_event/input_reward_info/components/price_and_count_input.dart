import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

class PriceAndCountInput extends StatelessWidget {
  const PriceAndCountInput({
    Key? key,
    required TextEditingController priceController,
    required TextEditingController countController,
  })  : _priceController = priceController,
        _countController = countController,
        super(key: key);

  final TextEditingController _priceController;
  final TextEditingController _countController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: TextField(
                  textAlign: TextAlign.end,
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      counterText: "",
                      prefixIcon: Icon(Icons.monetization_on_outlined),
                      labelText: '상품 단가',
                      suffixText: '원'),
                  maxLength: 7),
            ),
            SizedBox(height: kDefaultPadding),
            Expanded(
              child: TextField(
                  textAlign: TextAlign.end,
                  controller: _countController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      counterText: "",
                      prefixIcon: Icon(Icons.toll_outlined),
                      labelText: '보유 수량',
                      suffixText: '개'),
                  maxLength: 5),
            ),
          ],
        ));
  }
}
