import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/widget/vertical_ads_item.dart';

class TabHomeScreen extends StatefulWidget {
  static const routeName = '/tab-home-screen';

  final CarModel item;

  TabHomeScreen({Key key, @required this.item}) : super(key: key);

  @override
  _TabHomeScreenState createState() => _TabHomeScreenState();
}

class _TabHomeScreenState extends State<TabHomeScreen> {

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
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              child: Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width - 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text("Бидний тухай", style: TextStyle(fontSize: 16,color: Color(0xFF222455)),textAlign: TextAlign.left),
                    ),
                    ExpandablePanel(
                      header: Text(widget.item.user.org.about,maxLines: 2,
                        style: Theme.of(context).textTheme.body2,
                      ),
                      expanded: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.item.user.org.about,
                            softWrap: true,
                          )),
                      tapHeaderToExpand: true,
                      hasIcon: true,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top:10,bottom: 10,left:20),
              width: MediaQuery.of(context).size.width,
              child:  Text(
                'Өмнөх зар',
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
                    height: double.parse(lists.length.toString()) * 109,
                    // padding: EdgeInsets.only(bottom: 20, top: 0),
                    child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 20, top: 0),
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
            Container(
              padding: EdgeInsets.only(bottom: 10,left:20),
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
                    height: double.parse(lists.length.toString()) * 112,
                    // padding: EdgeInsets.only(bottom: 20, top: 0),
                    child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 20, top: 0),
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
          ],
        ),
      ),
    );
  }

}
