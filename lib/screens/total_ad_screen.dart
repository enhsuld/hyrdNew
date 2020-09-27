import 'package:flutter/material.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/screens/notification/notification_screen.dart';
import 'package:hyrd/screens/profile/setting_screen.dart';
import 'package:hyrd/screens/special_ads_screen.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/utils/fade_route.dart';
import 'package:hyrd/utils/hyrd_icons.dart';
import 'package:hyrd/utils/lang.dart';
import 'package:hyrd/widget/horizontal_car_item.dart';
import 'package:hyrd/widget/vertical_ads_item.dart';
import 'package:loading_more_list/loading_more_list.dart';

class TotalAdScreen extends StatefulWidget {
  static const routeName = '/total-ads';

  @override
  _TotalAdScreenState createState() => _TotalAdScreenState();
}

class _TotalAdScreenState extends State<TotalAdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: LoadingMoreCustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                padding:
                    EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      lang.TOTAL_ADS.toUpperCase(),
                      style: TextStyle(
                        fontSize: 21.0,
                        color: Color(0xFF222455),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 30,
                            child: IconButton(
                              icon: Icon(Hyrd.notification_on),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    FadeRoute(
                                        builder: (context) =>
                                            NotificationScreen()));
                              },
                              color: Color(0xFF222455),
                              iconSize: 20.0,
                            ),
                          ),
                          Container(
                            width: 30,
                            child: IconButton(
                              icon: Icon(Hyrd.settings),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    FadeRoute(
                                        builder: (context) => SettingScreen()));
                              },
                              color: Color(0xFF222455),
                              iconSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ])),
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.only(left: 20, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      lang.HIGHLIGHT_ADS,
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF222455),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FlatButton(
                      child: Text(
                        lang.ALLVIEW,
                        style:
                            TextStyle(color: Color(0xFF6E7FAA), fontSize: 13),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            FadeRoute(
                                builder: (context) => SpecialAdsScreen()));
                      },
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: BackendService.getHighlight(page: 1, pageSize: 5),
                builder: (context, snapshot) {
                  List<dynamic> lists;
                  if (snapshot.hasData) {
                    lists = snapshot.data;
                    return Container(
                      // height: double.parse(lists.length.toString()) * 122,
                      height: 270,
                      // padding: EdgeInsets.only(                        bottom: 20, top: 0, left: 10, right: 10),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        //physics: NeverScrollableScrollPhysics(),
                        itemCount: lists.length,
                        itemBuilder: (ctx, i) => HorizontalCarItem(
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
            ])),
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.only(left: 20, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Шинээр нэмэгдсэн',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF222455),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FlatButton(
                      child: Text(
                        'бүгдийг харах',
                        style:
                            TextStyle(color: Color(0xFF6E7FAA), fontSize: 13),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            FadeRoute(
                                builder: (context) => SpecialAdsScreen()));
                      },
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: BackendService.getHighlight(page: 1, pageSize: 10),
                builder: (context, snapshot) {
                  List<dynamic> lists;
                  if (snapshot.hasData) {
                    lists = snapshot.data;
                    return Container(
                      height: double.parse(lists.length.toString()) * 105,
                      padding: EdgeInsets.only(
                          bottom: 0, top: 0, left: 10, right: 10),
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 0, bottom: 0),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: lists.length,
                        itemBuilder: (ctx, i) => VerticalAdsItem(
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
            ]))
          ],
        ),
      ),
    );
  }
}
