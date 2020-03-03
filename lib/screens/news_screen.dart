import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:hyrd/models/post_model.dart';

class NewsScreen extends StatefulWidget {
  static const routeName = '/news';
  final PostModel item;
  NewsScreen({Key key, @required this.item}) : super(key: key);
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.topRight,
                  colors: <Color>[Color(0xFF584BDD), Color(0xFFB755FF)],
                )),
          ),
          centerTitle: true,
          leading: Builder(builder: (BuildContext context) {
            return new SizedBox(
                height: 18.0,
                width: 18.0,
                child: new IconButton(
                  padding: new EdgeInsets.all(0.0),
                  color: Colors.white,
                  icon: new Icon(Icons.arrow_back_ios, size: 20.0),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ));
          }),
          title: Text(this.widget.item.title,
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Html(
            data: widget.item.body,
            //Optional parameters:
            padding: EdgeInsets.all(8.0),
            linkStyle: const TextStyle(
              color: Colors.redAccent,
              decorationColor: Colors.redAccent,
              decoration: TextDecoration.underline,
            ),
            onLinkTap: (url) {
              print("Opening $url...");
            },
            onImageTap: (src) {
              print(src);
            },
            //Must have useRichText set to false for this to work
            customRender: (node, children) {
              if (node is dom.Element) {
                switch (node.localName) {
                  case "custom_tag":
                    return Column(children: children);
                }
              }
              return null;
            },
            customTextAlign: (dom.Node node) {
              if (node is dom.Element) {
                switch (node.localName) {
                  case "p":
                    return TextAlign.justify;
                }
              }
              return null;
            },
            customTextStyle: (dom.Node node, TextStyle baseStyle) {
              if (node is dom.Element) {
                switch (node.localName) {
                  case "p":
                    return baseStyle.merge(TextStyle(height: 2, fontSize: 20));
                }
              }
              return baseStyle;
            },
          ),
        ),
    );
  }
}
