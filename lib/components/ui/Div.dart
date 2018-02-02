import 'package:flutter/material.dart';

class Div extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline textBaseline;
  final List<Widget> children;
  final EdgeInsetsGeometry padding;

  Div(
      {this.mainAxisAlignment: MainAxisAlignment.start,
      this.mainAxisSize: MainAxisSize.max,
      this.crossAxisAlignment: CrossAxisAlignment.center,
      this.textDirection,
      this.verticalDirection: VerticalDirection.down,
      this.textBaseline,
      this.children: const <Widget>[],
      this.padding});

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: padding ?? new EdgeInsets.all(0.0),
      child: new Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        textBaseline: textBaseline,
        children: children,
      ),
    );
  }
}
