import 'package:flutter/material.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/screens/popular_ads_screen.dart';
import 'package:hyrd/screens/special_ads_screen.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/utils/fade_route.dart';
import 'package:hyrd/widget/horizontal_car_item.dart';
import 'package:hyrd/widget/vertical_ads_item.dart';

class SearchCarScreen extends StatefulWidget {
  static const routeName = '/search-car';

  @override
  _SearchCarScreenState createState() => _SearchCarScreenState();
}

class _SearchCarScreenState extends State<SearchCarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [Color(0xff584BDD), Color(0xffB755FF)],
              )),
              width: double.infinity,
              height: MediaQuery.of(context).padding.top,
            ),
            Padding(
              padding: EdgeInsets.only(top: 12, left: 15.0, right: 15.0),
              child: Material(
                elevation: 8.0,
                borderRadius: BorderRadius.circular(8.0),
                child: TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon:
                            Icon(Icons.search, color: Colors.grey, size: 30.0),
                        suffixIcon: IconButton(
                          icon: new Icon(Icons.format_line_spacing,
                              color: Color(0xFF676E79)),
                          onPressed: () {},
                        ),
                        contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                        hintText: 'Хайлт хийх',
                        hintStyle: TextStyle(
                            color: Colors.grey, fontFamily: 'Quicksand'))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 20, right: 5),
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
                    child: Text(
                      'бүгдийг харах',
                      style: TextStyle(color: Color(0xFF6E7FAA), fontSize: 13),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          FadeRoute(builder: (context) => PopularAdsScreen()));
                    },
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
                        padding: EdgeInsets.only(top: 0, bottom: 0),
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
              padding: EdgeInsets.only(left: 20, right: 5),
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
                    child: Text(
                      'бүгдийг харах',
                      style: TextStyle(color: Color(0xFF6E7FAA), fontSize: 13),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          FadeRoute(builder: (context) => SpecialAdsScreen()));
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
                    height: double.parse(lists.length.toString()) * 122,
                    padding: EdgeInsets.only(
                        bottom: 20, top: 0, left: 10, right: 10),
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
            )
          ],
        ),
      ),
    );
  }
}
