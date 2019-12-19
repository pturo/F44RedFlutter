import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_html_view/flutter_html_view.dart';

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
            new HtmlView(data: post['content']['rendered'])
          ],
        ),
      ),
    );
  }
}