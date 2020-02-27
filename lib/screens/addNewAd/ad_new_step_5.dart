import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/screens/dashboard_screen.dart';
import 'package:hyrd/screens/home_screen.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/utils/fade_route.dart';

class AdNewStep5Screen extends StatefulWidget {
  static const routeName = '/adNew';
  final CarModel car;
  AdNewStep5Screen({Key key, @required this.car}) : super(key: key);
  @override
  _AdNewStep5ScreenState createState() => _AdNewStep5ScreenState();
}

class _AdNewStep5ScreenState extends State<AdNewStep5Screen> {
  static const textColor = Color(0xFF2D3853);
  static const GradientRed = Color(0xFFDF2626);
  String dropdownValue = 'Суудлын тэрэг';
  String buildYear = '2015';

  bool isSwitched = true;
  bool isChecked = true;
  var isSelected = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<String> countries = [
    'INDIA',
    'USA',
    'JAPAN',
  ];
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formData;

  String _radioPublish = "best_premium";
  int viewId = 0;
  void _handleRadioPriceChange(value) {
    setState(() {
      _radioPublish = value;
      switch (_radioPublish) {
        case "best_premium":
          viewId = 0;
          break;
        case "premium":
          viewId = 1;
          break;
        case "free":
          viewId = 2;
          break;
      }
    });
  }

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
          actions: <Widget>[
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: (){
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: Container(
                  padding: EdgeInsets.only(right: 20, left: 10),
                  child: new SizedBox(
                      height: 15.0,
                      width: 15.0,
                      child: new Icon(Icons.close,
                          color: Colors.white, size: 30.0)),
                ),
              ),
            )
          ],
          title: Text("Зар оруулах 5/5",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          elevation: 0.0,
        ),
        body: Container(
            child: Form(
          key: _formKey,
          autovalidate: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                new Radio(
                                  activeColor: Color(0xFF584BDD),
                                  value: "best_premium",
                                  groupValue: _radioPublish,
                                  onChanged: _handleRadioPriceChange,
                                ),
                                Text(
                                 "Онцгой зар",
                                  style: TextStyle(
                                      color:  (_radioPublish == "best_premium") ? Color(0xff222455) : Color(0xff6E7FAA),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            (_radioPublish == "best_premium")
                                ?  Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              height: 75,
                              child: Column(children: <Widget>[
                                new Container(
                                  alignment: Alignment.centerLeft,
                                  margin: new EdgeInsets.only(top: 20.0, left: 10.0),
                                  child: new Text(
                                    "5 хоног",
                                    style: new TextStyle(
                                      color: Color(0xff6E7FAA),
                                      fontSize: 16.0,
                                      letterSpacing: 0.1,
                                    ),
                                  ),
                                ),
                                Divider(),
                                new Container(
                                  alignment: Alignment.centerLeft,
                                  child: new Text(
                                    "Онцгой зар хамгийн дээр байрлана.",
                                  ),
                                ),
                              ]),
                            )
                                : SizedBox(height: 0)
                          ],
                        ),
                      ),
                      Divider(thickness: 1, color: Colors.grey),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                new Radio(
                                  activeColor: Color(0xFF584BDD),
                                  value: "premium",
                                  groupValue: _radioPublish,
                                  onChanged: _handleRadioPriceChange,
                                ),
                                Text(
                                  "Энгийн зар",
                                  style: TextStyle(
                                      color:  (_radioPublish == "premium") ? Color(0xff222455) : Color(0xff6E7FAA),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            (_radioPublish == "premium")
                                ?  Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              height: 100,
                              child: Column(children: <Widget>[
                                new Container(
                                  alignment: Alignment.centerLeft,
                                  margin: new EdgeInsets.only(top: 20.0, left: 10.0),
                                  child: new Text(
                                    "3 хоног",
                                    style: new TextStyle(
                                      color: Color(0xff6E7FAA),
                                      fontSize: 16.0,
                                      letterSpacing: 0.1,
                                    ),
                                  ),
                                ),
                                Divider(),
                                Text("Энгийн зар бүр онцгой зар болон эрхтэй зарын доор байрлана."),
                              ]),
                            )
                                : SizedBox(height: 0)
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
              ),
              Container(
                padding:
                    EdgeInsets.only(right: 0, left: 0, top: 10, bottom: 20),
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                  onPressed: () {
                    print(widget.car.markName);
                    print(widget.car.id);
                    print(viewId);
                   // widget.car.publishTariff=viewId;


                    BackendService.updateCarAds(taxonomy:widget.car.toJson(),id:widget.car.id).then((response) {
                      print(response);
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    });
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
                    child: const Text('Үргэлжлүүлэх',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
