import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String placeholder;
  final Function onSaved;
  final TextInputType keyboardType;

  Input({
    this.onSaved,
    this.placeholder,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      decoration: new InputDecoration(hintText: placeholder),
      keyboardType: keyboardType,
      onSaved: onSaved,
    );
  }
}
