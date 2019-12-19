import 'package:f44red_flutter/tools/drawer.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';
import 'f44red_post.dart';

class F44RedHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => F44RedHomeState();
}

class F44RedHomeState extends State<F44RedHome> {
  // Base URL for F44Red page
  final String f44Url = "http://f44red.com/wp-json/wp/v2/";

  // Empty list for posts
  List posts;

  // Function that fetches list of posts
  Future<String> getPosts() async {
    var res = await http.get(Uri.encodeFull(f44Url + "posts?_embed"),
        headers: {"Accept": "applications/json"});
    // fills posts with results
    setState(() {
      var resBody = json.decode(res.body);
      posts = resBody;
    });

    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    this.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("F44Red"), backgroundColor: Colors.redAccent),
      drawer: DrawerNav(),
      body: ListView.builder(
        itemCount: posts == null ? 0 : posts.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Card(
                child: Column(
                  children: <Widget>[
                    new FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: posts[index]["featured_media"] == 0
                          ? 'images/placeholder.png'
                          : posts[index]["_embedded"]["wp:featuredmedia"][0]
                              ["source_url"],
                    ),
                    new Padding(
                        padding: EdgeInsets.all(10.0),
                        child: new ListTile(
                          title: new Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child:
                                  new Text(posts[index]["title"]["rendered"])),
                          subtitle: new Text(posts[index]["excerpt"]["rendered"]
                              .replaceAll(RegExp('&#8211;'), '–')),
                        )),
                    // ignore: deprecated_member_use
                    new ButtonTheme.bar(
                      child: new ButtonBar(
                        children: <Widget>[
                          new FlatButton(
                            child: const Text('READ MORE'),
                            color: Colors.red,
                            onPressed: () {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) =>
                                      new F44RedPost(post: posts[index]),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
