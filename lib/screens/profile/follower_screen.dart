import 'package:flutter/material.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/screens/add_car_screen.dart';
import 'package:hyrd/screens/bottom_bar.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/widget/recent_list_item.dart';
import 'package:hyrd/widget/vertical_ads_item.dart';
import 'package:hyrd/widget/vertical_follower_item.dart';
import 'package:hyrd/widget/vertical_news_item.dart';

import '../../models/car.dart';
import '../../widget/vertical_list_item.dart';
import '../../widget/horizontal_list_item.dart';

class FollowerScreen extends StatefulWidget {
  static const routeName = '/follower';

  @override
  _FollowerScreenState createState() => _FollowerScreenState();
}

class _FollowerScreenState extends State<FollowerScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF584BDD),
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
          title: Text("Дагаж байгаа",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          elevation: 0.0,
        ),
        body: Container(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                      child:  FutureBuilder(
                        future: BackendService.getHighlight(page: 1, pageSize: 5),
                        builder: (context, snapshot) {
                          List<dynamic> lists;
                          if (snapshot.hasData) {
                            lists = snapshot.data;
                            return Container(
                              height: double.parse(lists.length.toString()) * 118,
                              padding: EdgeInsets.only(
                                  bottom: 20, top: 0, left: 10, right: 10),
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: lists.length,
                                itemBuilder: (ctx, i) => VerticalFollowerItem(
                                  index: i,
                                  item: CarModel.fromJson(lists[i]["car_ad"]),
                                ),
                              ),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                  ),
                ),
              ],
            )
        )
    );
  }
}
