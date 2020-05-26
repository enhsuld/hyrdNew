import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/models/organization_model.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/widget/vertical_follower_item.dart';
import 'package:hyrd/widget/vertical_following_item.dart';
import 'package:hyrd/widget/vertical_full_width_ads_item.dart';

class FollowerScreen extends StatefulWidget {
  static const routeName = '/follower';

  @override
  _FollowerScreenState createState() => _FollowerScreenState();
}

class _FollowerScreenState extends State<FollowerScreen> {
  static const int PAGE_SIZE = 8;
/*  Future<List<OrganizationModel>> _fetchCash(pageIndex) async {
    return BackendService.getFollowerList(pageIndex + 1, PAGE_SIZE);
  }

  final _pageLoadController = PagewiseLoadController(
      pageSize: PAGE_SIZE,
      pageFuture: (pageIndex) =>
          BackendService.getFollowerList(pageIndex + 1, PAGE_SIZE));*/


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
        title: Text("Дагаж байгаа",
            style:
            TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        elevation: 0.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
       /*   Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  this._pageLoadController.reset();
                  await Future.value({});
                },
                child: PagewiseListView(
                  padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                  itemBuilder: this._itemBuilder,
                  pageLoadController: this._pageLoadController,
                ),
              )
          ),*/

          FutureBuilder(
            future: BackendService.getFollowerList(page: 1, pageSize: 50),
            builder: (context, snapshot) {
              List<dynamic> lists;
              if (snapshot.hasData) {
                lists = snapshot.data;
                return Container(
                  height: double.parse(lists.length.toString()) * 110,
                  padding: EdgeInsets.only(
                      bottom: 20, top: 10, left: 10, right: 10),
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 0, bottom: 0),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: lists.length,
                    itemBuilder: (ctx, i) => VerticalFollowingItem(
                      index: i,
                      item: OrganizationModel.fromJson(lists[i]),
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
        ],
      ),
    );
  }
}
