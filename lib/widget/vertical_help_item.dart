import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/models/help_model.dart';
import 'package:hyrd/screens/car_details_screen.dart';
import 'package:hyrd/screens/main/detail_screen.dart';
import 'package:hyrd/utils/fade_route.dart';
import 'package:intl/intl.dart';

class VerticalHelpItem extends StatelessWidget {
  final int index;
  final HelpModel item;
  VerticalHelpItem({this.index, this.item});
  static const miniTextColor = Color(0xFF6E7FAA);
  static const bigTextColor = Color(0xFF222455);

  @override
  Widget build(BuildContext context) {

    final formatter = new NumberFormat("#,###");


    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(item.title, style: TextStyle(fontSize: 16,color: Color(0xFF222455)),textAlign: TextAlign.left),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(item.body, style: TextStyle(fontSize: 12,color: Color(0xFF6E7FAA)),textAlign: TextAlign.left),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
