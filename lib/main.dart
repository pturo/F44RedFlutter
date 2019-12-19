import 'package:flutter/material.dart';
import 'package:f44red_flutter/f44red/f44red_main_page.dart';

void main() => runApp(new F44RedApp());

class F44RedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'F44Red',
      home: new F44RedHome(),
    );
  }
}