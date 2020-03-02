import 'package:flutter/material.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/widget/vertical_follower_item.dart';

class FollowerScreen extends StatefulWidget {
  static const routeName = '/follower';

  @override
  _FollowerScreenState createState() => _FollowerScreenState();
}

class _FollowerScreenState extends State<FollowerScreen> {

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
        body: Container(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                      child:  FutureBuilder(
                        future: BackendService.getHighlight(page: 1, pageSize: 5),
                        builder: (context, snapshot) {
                          List<dynamic> lists;
                          if (snapshot.hasData) {
                            lists = snapshot.data;
                            return Container(
                              height: double.parse(lists.length.toString()) * 118,
                              padding: EdgeInsets.only(
                                  bottom: 20, top: 0, left: 10, right: 10),
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: lists.length,
                                itemBuilder: (ctx, i) => VerticalFollowerItem(
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
                  ),
                ),
              ],
            )
        )
    );
  }
}
