import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/widget/vertical_ads_item.dart';

class TabAddressScreen extends StatefulWidget {
  static const routeName = '/tab-address-screen';

  @override
  _TabAddressScreenState createState() => _TabAddressScreenState();
}

class _TabAddressScreenState extends State<TabAddressScreen> {

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
              margin: EdgeInsets.only(bottom: 10),
              child:  Card(
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
                      Container(
                        margin: EdgeInsets.only(bottom: 10,left: 30),
                        child: Text("#206, Mungut Sharga Office, Tumurchnii Street, 2nd Khoroo, Ulaanbaatar, Mongolia", style: TextStyle(fontSize: 12,color: Color(0xFF6E7FAA)),textAlign: TextAlign.left),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text("Ажлын цаг:", style: TextStyle(fontSize: 16,color: Color(0xFF222455)),textAlign: TextAlign.left),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10,left: 30),
                        child: Text("Open Now 9:00 AM - 6:00 pm", style: TextStyle(fontSize: 12,color: Color(0xFF6E7FAA)),textAlign: TextAlign.left),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text("Цахим шуудан:", style: TextStyle(fontSize: 16,color: Color(0xFF222455)),textAlign: TextAlign.left),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10,left: 30),
                        child: Text("info@jmtech.mn", style: TextStyle(fontSize: 12,color: Color(0xFF6E7FAA)),textAlign: TextAlign.left),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text("Веб сайт:", style: TextStyle(fontSize: 16,color: Color(0xFF222455)),textAlign: TextAlign.left),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10,left: 30),
                        child: Text("www.jmteach.mn", style: TextStyle(fontSize: 12,color: Color(0xFF6E7FAA)),textAlign: TextAlign.left),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text("Холбогдох утас:", style: TextStyle(fontSize: 16,color: Color(0xFF222455)),textAlign: TextAlign.left),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10,left: 30),
                        child: Text("(+976) 89951555", style: TextStyle(fontSize: 12,color: Color(0xFF6E7FAA)),textAlign: TextAlign.left),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
