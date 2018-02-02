import 'package:flutter/material.dart';
import 'package:hub/components/screens/Login.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Hub Demo',
      theme: new ThemeData(),
      home: new Material(
        child: new Center(
          child: new Login(),
        ),
      ),
    );
  }
}
