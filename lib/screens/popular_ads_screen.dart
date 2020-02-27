import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/widget/vertical_full_width_ads_item.dart';
import 'package:hyrd/widget/vertical_own_ads_item.dart';

class PopularAdsScreen extends StatefulWidget {
  static const routeName = '/ad-popular';

  @override
  _PopularAdsScreenState createState() => _PopularAdsScreenState();
}

class _PopularAdsScreenState extends State<PopularAdsScreen> {
  static const int PAGE_SIZE = 8;
  Future<List<CarModel>> _fetchCash(pageIndex) async {
    return BackendService.getPopularList(pageIndex + 1, PAGE_SIZE);
  }

  final _pageLoadController = PagewiseLoadController(
      pageSize: PAGE_SIZE,
      pageFuture: (pageIndex) =>
          BackendService.getPopularList(pageIndex + 1, PAGE_SIZE));


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
        title: Text("Эрэлттэй зарууд",
            style:
            TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        elevation: 0.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  this._pageLoadController.reset();
                  await Future.value({});
                },
                child: PagewiseListView(
                  padding: EdgeInsets.all(20),
                  itemBuilder: this._itemBuilder,
                  pageLoadController: this._pageLoadController,
                ),
              )),
        ],
      ),
    );
  }

  Widget _itemBuilder(context, CarModel entry, _) {
    return VerticalFullWidthAdsItem(item: entry);
  }
}
