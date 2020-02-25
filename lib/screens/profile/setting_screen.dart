import 'package:flutter/material.dart';
import 'package:hyrd/screens/add_car_screen.dart';
import 'package:hyrd/widget/recent_list_item.dart';

import '../../models/car.dart';
import '../../widget/vertical_list_item.dart';
import '../../widget/horizontal_list_item.dart';

class SettingScreen extends StatefulWidget {
  static const routeName = '/settings';

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

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
                    'Popular',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF222455),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FlatButton(
                    child: Text('View All', style: TextStyle(color: Color(0xFF6E7FAA), fontSize: 16), ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Container(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topRatedCarList.length,
                itemBuilder: (ctx, i) => HorizontalListItem(i),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top:10,left: 20,right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Highlighted Ads',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF222455),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FlatButton(
                    child: Text('View All', style: TextStyle(color: Color(0xFF6E7FAA), fontSize: 16), ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Container(
              height: 460,
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: highlighted.length,
                itemBuilder: (ctx, i) => VerticalListItem(i),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top:10,left: 20,right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Recent posts',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF222455),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FlatButton(
                    child: Text('View All', style: TextStyle(color: Color(0xFF6E7FAA), fontSize: 16), ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Container(
              height: 460,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: recentCarList.length,
                itemBuilder: (ctx, i) => RecentListItem(i),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
