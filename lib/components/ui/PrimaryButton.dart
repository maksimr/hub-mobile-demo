import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;

  PrimaryButton({
    this.child,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
      color: Colors.blue,
      onPressed: onPressed,
      child: child,
    );
  }
}
