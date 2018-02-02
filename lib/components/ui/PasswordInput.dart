import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  final String placeholder;
  final String labelText;
  final Function onSaved;

  PasswordInput({
    this.onSaved,
    this.placeholder,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      obscureText: true,
      decoration: new InputDecoration(
        hintText: placeholder,
        labelText: labelText,
      ),
      keyboardType: TextInputType.text,
      onSaved: onSaved,
    );
  }
}
