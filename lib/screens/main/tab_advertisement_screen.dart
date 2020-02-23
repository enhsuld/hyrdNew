import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/widget/vertical_ads_item.dart';
import 'package:hyrd/widget/vertical_full_width_ads_item.dart';

class TabAdvertisementScreen extends StatefulWidget {
  static const routeName = '/tab-adv-screen';

  @override
  _TabAdvertisementScreenState createState() => _TabAdvertisementScreenState();
}

class _TabAdvertisementScreenState extends State<TabAdvertisementScreen> {

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
                'Энгийн зар',
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
                    height: double.parse(lists.length.toString()) * 210,
                    child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 20, top: 0),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: lists.length,
                      itemBuilder: (ctx, i) => VerticalFullWidthAdsItem(
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
