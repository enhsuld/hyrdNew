import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/widget/vertical_ads_item.dart';
import 'package:hyrd/widget/vertical_news_item.dart';

class TabNewsScreen extends StatefulWidget {
  static const routeName = '/tab-news-screen';

  @override
  _TabNewsScreenState createState() => _TabNewsScreenState();
}

class _TabNewsScreenState extends State<TabNewsScreen> {

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
              padding: EdgeInsets.only(top:5,bottom: 10,left:20),
              width: MediaQuery.of(context).size.width,
              child:  Text(
                'Мэдээлэл',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF222455)),
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
                    // padding: EdgeInsets.only(bottom: 20, top: 0),
                    child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 20, top: 0),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: lists.length,
                      itemBuilder: (ctx, i) => VerticalNewsItem(
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
          ],
        ),
      ),
    );
  }

}
