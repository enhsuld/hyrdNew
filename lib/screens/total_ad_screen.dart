import 'package:flutter/material.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/widget/horizontal_car_item.dart';
import 'package:hyrd/widget/recent_list_item.dart';
import 'package:hyrd/widget/vertical_ads_item.dart';

import '../models/car.dart';
import '../widget/vertical_list_item.dart';
import '../widget/horizontal_list_item.dart';

class TotalAdScreen extends StatefulWidget {
  static const routeName = '/search-car';

  @override
  _TotalAdScreenState createState() => _TotalAdScreenState();
}

class _TotalAdScreenState extends State<TotalAdScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top:40,left: 20,right: 20,bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Нийт зар',
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
                          width:30,
                          child: IconButton(
                            icon: Icon(Icons.notifications),
                            onPressed: () {},
                            color: Color(0xFF222455),
                            iconSize: 20.0,
                          ),
                        ),
                        Container(
                          width:30,
                          child: IconButton(
                            icon: Icon(Icons.settings),
                            onPressed: () {},
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
            Padding(
              padding: EdgeInsets.only(top:10,left: 20,right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Эрэлттэй зарууд',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF222455),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FlatButton(
                    child: Text('бүгдийг харах', style: TextStyle(color: Color(0xFF6E7FAA), fontSize: 13), ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Container(
                height: 270,
                child: FutureBuilder(
                  future: BackendService.getPopular(page: 1, pageSize: 5),
                  builder: (context, snapshot) {
                    List<dynamic> adsPopulars;
                    if (snapshot.hasData) {
                      adsPopulars = snapshot.data;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: adsPopulars.length,
                        itemBuilder: (ctx, i) => HorizontalCarItem(
                            index: i, item: CarModel.fromJson(adsPopulars[i])),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )),
            Padding(
              padding: EdgeInsets.only(top:10,left: 20,right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Онцлох',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF222455),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FlatButton(
                    child: Text('бүгдийг харах', style: TextStyle(color: Color(0xFF6E7FAA), fontSize: 13), ),
                    onPressed: () {},
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
                    height: double.parse(lists.length.toString()) * 125,
                    padding: EdgeInsets.only(
                        bottom: 20, top: 0, left: 10, right: 10),
                    child: ListView.builder(
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
            )
          ],
        ),
      ),
    );
  }
}
