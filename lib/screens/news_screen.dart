import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/models/post_model.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/utils/hyrd_icons.dart';
import 'package:hyrd/widget/horizontal_car_item.dart';
import 'package:intl/intl.dart';

class NewsScreen extends StatefulWidget {
  static const routeName = '/news';
  final PostModel item;

  NewsScreen({Key key, @required this.item}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  final formatterDate = new DateFormat.yMMMMd('en_US');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(top:25),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width:20,
                    child:  IconButton(
                      iconSize: 20,
                      padding: EdgeInsets.all(0),
                      icon: Icon(Icons.arrow_back_ios,size: 20,),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left:10),
                    width: MediaQuery.of(context).size.width-60,
                    child:Text(
                      this.widget.item.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xff222455),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 50,
                    margin: EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xFFB6BED4), width: 2),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: (widget.item?.org?.avatar == null)
                            ? AssetImage('assets/images/defualt-user.png')
                            : NetworkImage(widget.item?.org?.avatar),),
                    ),
                  ),
                  Container(
                    width:MediaQuery.of(context).size.width - 100,
                    height: 60,
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          (widget.item.org?.name ?? ""),
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF222455),
                          ),
                          textAlign: TextAlign.center,
                        ),

                        Text(
                          formatterDate.format(DateTime.parse(widget.item?.createdAt)) ?? "",
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF6E7FAA),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: (widget.item.coverImage==null)
                      ? AssetImage('assets/images/defualt-car.png')
                      : NetworkImage(widget.item.coverImage),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child:  Html(
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
            Container(
              width: MediaQuery.of(context).size.width - 30,
              child:  Divider(
                thickness: 2,
                color: Color(0xFF222455),
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width - 20,
              padding: EdgeInsets.only(top: 10, left: 5, bottom: 10),
              child: Text(
                'Бусад мэдээ'.toUpperCase(),
                textAlign: TextAlign.left,
                style:
                TextStyle(fontSize: 16, color: Color(0xFF222455)),
              ),
            ),
            Container(
                height: 270,
                margin: EdgeInsets.only(bottom: 40),
                child: FutureBuilder(
                  future: BackendService.getSimilar(id:widget.item.id, page: 1, pageSize: 5),
                  builder: (context, snapshot) {
                    List<dynamic> adsPopulars;
                    if (snapshot.hasData) {
                      adsPopulars = snapshot.data;
                      return ListView.builder(
                        padding: EdgeInsets.only(top: 0, bottom: 0),
                        scrollDirection: Axis.horizontal,
                        itemCount: adsPopulars.length,
                        itemBuilder: (ctx, i) => HorizontalCarItem(
                            index: i,
                            item: CarModel.fromJson(adsPopulars[i])),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
            ),
          ],
        ),
      ),
    );
  }
}
