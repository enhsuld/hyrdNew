import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/widget/vertical_full_width_ads_item.dart';

class TabAdvertisementScreen extends StatefulWidget {
  static const routeName = '/tab-adv-screen';

  final CarModel item;

  TabAdvertisementScreen({Key key, @required this.item}) : super(key: key);

  @override
  _TabAdvertisementScreenState createState() => _TabAdvertisementScreenState();
}

class _TabAdvertisementScreenState extends State<TabAdvertisementScreen> {
  static const int PAGE_SIZE = 2;

  Future<List<CarModel>> _fetchCash(pageIndex) async {
    return BackendService.getOrgAds(
        widget.item.user.org.id, pageIndex + 1, PAGE_SIZE);
  }

  double screenSize;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 5, bottom: 10,left: 20),
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Энгийн зар',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16, color: Color(0xFF222455)),
              ),
            ),
            Container(
              height: 400,
              padding: EdgeInsets.only(bottom: 20),
              child: RefreshIndicator(
                onRefresh: () async {
                  PagewiseLoadController(
                      pageSize: PAGE_SIZE,
                      pageFuture: (pageIndex) => BackendService.getOrgAds(
                          widget.item.user.org.id,
                          pageIndex + 1,
                          PAGE_SIZE)).reset();
                  await Future.value({});
                },
                child: PagewiseListView(
                  padding: EdgeInsets.all(0),
                  itemBuilder: this._itemBuilder,
                  pageLoadController: PagewiseLoadController(
                      pageSize: PAGE_SIZE,
                      pageFuture: (pageIndex) => BackendService.getOrgAds(
                          widget.item.user.org.id,
                          pageIndex + 1,
                          PAGE_SIZE)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemBuilder(context, CarModel entry, _) {
    return VerticalFullWidthAdsItem(item: entry);
  }
}
