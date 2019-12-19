import 'package:f44red_flutter/tools/drawer.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new DrawerNav(),    // New Line
      appBar: new AppBar(title: new Text("O nas"),),
      body: new Text("To jest strona 'O nas'..."),
    );
  }
}