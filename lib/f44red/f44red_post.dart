import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_html/flutter_html.dart';

class F44RedPost extends StatelessWidget {
  var post;
  F44RedPost({Key key, @required var this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(post['title']['rendered']),
        backgroundColor: Colors.redAccent
      ),
      body: new Padding(
        padding: EdgeInsets.all(16.0),
        child: new ListView(
          children: [
            new FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: post["featured_media"] == 0
                  ? 'images/placeholder.png'
                  : post["_embedded"]["wp:featuredmedia"][0]["source_url"],
            ),
            new Html(
              data: post['content']['rendered'],
              padding: EdgeInsets.all(8.0),
              linkStyle: const TextStyle(
                color: Colors.redAccent,
                decorationColor: Colors.redAccent,
                decoration: TextDecoration.underline
              ),
            )
          ],
        ),
      ),
    );
  }
}