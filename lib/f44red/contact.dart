import 'package:f44red_flutter/tools/drawer.dart';
import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new DrawerNav(),    // New Line
      appBar: new AppBar(title: new Text("Kontakt"),),
      body: new Text("To jest strona 'Kontakt'..."),
    );
  }
}