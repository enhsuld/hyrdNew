import 'package:flutter/material.dart';
import 'package:hyrd/screens/addNewAd/ad_new_step_1.dart';
import 'package:hyrd/utils/fade_route.dart';
import '../models/car.dart';
import '../widget/vertical_list_item.dart';

class AddCarScreen extends StatefulWidget {
  static const routeName = '/add-car';

  @override
  _AddCarScreenState createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Зар оруулах',
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
                          width: 30,
                          child: IconButton(
                            icon: Icon(Icons.notifications),
                            onPressed: () {},
                            color: Color(0xFF222455),
                            iconSize: 20.0,
                          ),
                        ),
                        Container(
                          width: 30,
                          child: IconButton(
                            icon: Icon(Icons.format_line_spacing),
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
            Container(
              padding: EdgeInsets.only(right: 0, left: 0, top: 10, bottom: 20),
              width: MediaQuery.of(context).size.width,
              // height: 95,
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(FadeRoute(builder: (context) => AdNewScreen()));
                },
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Color(0xFFB755FF),
                          Color(0xFF584BDD),
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: const Text('ШИНЭЭР ЗАР НЭМЭХ',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 20, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Өмнөх зар',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF222455),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 460,
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: highlighted.length,
                itemBuilder: (ctx, i) => VerticalListItem(i),
              ),
            ),
          ],
        ),
      )
    );
  }
}
