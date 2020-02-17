import 'package:f44red_flutter/tools/drawer.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'f44red_post.dart';

class F44RedHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => F44RedHomeState();
}

class F44RedHomeState extends State<F44RedHome> {
  // Swpipe to refresh feature
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

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

  Future<Null> refresh() {
    return getPosts().then((post) {
      setState(() => post = posts as String);
    });
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
      body: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: refresh,
        child: ListView.builder(
            itemCount: posts == null ? 0 : posts.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () { Navigator.push(context, new MaterialPageRoute(builder: (context) => new F44RedPost(post: posts[index])));},
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Material(
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(10.0),
                    shadowColor: Theme.of(context).primaryColor.withOpacity(.5),
                    child: SizedBox(
                      height: 200.0,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: <Widget>[
                          FadeInImage.assetNetwork(
                              placeholder: 'images/placeholder.png',
                              image: posts[index]["featured_media"] == 0
                                  ? 'images/placeholder.png'
                                  : posts[index]["_embedded"]["wp:featuredmedia"][0]
                              ["source_url"],
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black,
                                        Colors.transparent
                                      ])),
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0,
                                    bottom: 5.0,
                                    left: 5.0,
                                    right: 5.0),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(
                                          posts[index]["title"]["rendered"],
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0,
                                            shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(1.0, 1.0),
                                                blurRadius: 5.0,
                                                color: Colors.black,
                                              ),
                                              Shadow(
                                                offset: Offset(1.0, 1.0),
                                                blurRadius: 8.0,
                                                color: Colors.black,
                                              ),
                                            ],
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
