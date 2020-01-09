import 'package:flutter/material.dart';
import 'package:hyrd/screens/dashboard_screen.dart';
import 'package:hyrd/screens/profile_screen.dart';
import 'package:hyrd/screens/search_car_screen.dart';
import 'package:hyrd/screens/total_ad_screen.dart';
import 'package:hyrd/utils/fade_route.dart';

class BottomBar extends StatelessWidget {
  static const bigTextColor = Color(0xFF222455);

  final bool isSelected;

  BottomBar({this.isSelected});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: Colors.transparent,
        elevation: 9.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
            height: 50.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                 //  topLeft: Radius.circular(25.0),
                   //topRight: Radius.circular(25.0)
                  //, color: Color(0xFF584BDD)
                ),
                color: Colors.white
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width /2 - 40.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new IconButton(icon: new Icon(Icons.home,  color: isSelected? Color(0xFF584BDD): Color(0xFF676E79)), onPressed: (){
                            Navigator.pop(context);
                            Navigator.of(context).push(FadeRoute(builder: (context) => DashboardScreen()));
                            //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) =>DashboardScreen()));
                          },),
                          new IconButton(icon: new Icon(Icons.search, color: isSelected? Color(0xFF584BDD): Color(0xFF676E79)), onPressed: (){
                            Navigator.pop(context);
                            Navigator.of(context).push(FadeRoute(builder: (context) => SearchCarScreen()));
                          },),
                        ],
                      )
                  ),
                  Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width /2 - 40.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new IconButton(icon: new Icon(Icons.shopping_basket, color: isSelected? Color(0xFF584BDD): Color(0xFF676E79)), onPressed: (){
                            Navigator.pop(context);
                            Navigator.of(context).push(FadeRoute(builder: (context) => TotalAdScreen()));
                          },),
                          new IconButton(icon: new Icon(Icons.person_outline, color: isSelected? Color(0xFF584BDD): Color(0xFF676E79)), onPressed: (){
                            Navigator.pop(context);
                            Navigator.of(context).push(FadeRoute(builder: (context) => ProfileScreen()));
                          },),
                        ],
                      )
                  ),
                ]
            )
        )
    );
  }
}