import 'package:f44red_flutter/f44red/about_us.dart';
import 'package:f44red_flutter/f44red/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new ListView(children: <Widget>[
        new UserAccountsDrawerHeader(
          accountName: Text('John Rambo'),
          accountEmail: Text('triplekill@examplemail.com'),
          currentAccountPicture: GestureDetector(
            child: new CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white),
            ),
          ),
          decoration: new BoxDecoration(color: Colors.redAccent),
        ),
        InkWell(
            onTap: () {},
            child: ListTile(title: Text('F44Red'), leading: Icon(Icons.home))),
        InkWell(
            onTap: () {},
            child: ListTile(
                title: Text('Aktualności'), leading: Icon(Icons.info))),
        InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new AboutUs()));
            },
            child: ListTile(
                title: Text('O nas'), leading: Icon(Icons.account_box))),
        InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new Contact()));
            },
            child: ListTile(
                title: Text('Kontakt'), leading: Icon(Icons.contact_mail))),

        Divider(),

        InkWell(
            onTap: () {},
            child: ListTile(
                title: Text('Ustawienia'), leading: Icon(Icons.settings))),
        InkWell(
            onTap: () {},
            child: ListTile(
                title: Text('O aplikacji'), leading: Icon(Icons.help))),
      ]),
    );
  }
}