import 'package:flutter/material.dart';

class NameInput extends StatelessWidget {
  const NameInput({
    Key? key,
    required TextEditingController nameController,
  })  : _nameController = nameController,
        super(key: key);

  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return TextField(
        textAlign: TextAlign.start,
        controller: _nameController,
        decoration: InputDecoration(
            counterText: "",
            prefixIcon: Icon(Icons.local_offer_outlined),
            labelText: '상품명'),
        maxLength: 20);
  }
}
