import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hyrd/screens/addNewAd/ad_new_step_3.dart';
import 'package:hyrd/screens/add_car_screen.dart';
import 'package:hyrd/screens/bottom_bar.dart';
import 'package:hyrd/utils/fade_route.dart';
import 'package:hyrd/widget/recent_list_item.dart';

import '../../models/car.dart';
import '../../widget/vertical_list_item.dart';
import '../../widget/horizontal_list_item.dart';

class AdNewStep2Screen extends StatefulWidget {
  static const routeName = '/adNew';

  @override
  _AdNewStep2ScreenState createState() => _AdNewStep2ScreenState();
}

class _AdNewStep2ScreenState extends State<AdNewStep2Screen> {
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

  _ExampleFormState() {
    formData = {
      'City': 'Bangalore',
      'Country': 'INDIA',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF584BDD),
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
                  Navigator.pop(context);
                  Navigator.pop(context);
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
          title: Text("Зар оруулах 2/5",
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 20),
                            width: MediaQuery.of(context).size.width,
                            child: Text("Үйлдвэр"),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            width: (MediaQuery.of(context).size.width * 2) / 5,
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                child: DropdownButton(
                                  value: buildYear,
                                  isDense: true,
                                  style: TextStyle(
                                    color: Color(0xFF6E7FAA),
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      buildYear = newValue;
                                    });
                                  },
                                  items: <String>['2015', '2016', '2017']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 1,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 20),
                            width: MediaQuery.of(context).size.width,
                            child: Text("Загвар"),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            width: (MediaQuery.of(context).size.width * 2) / 5,
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                child: DropdownButton(
                                  value: buildYear,
                                  isDense: true,
                                  style: TextStyle(
                                    color: Color(0xFF6E7FAA),
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      buildYear = newValue;
                                    });
                                  },
                                  items: <String>['2015', '2016', '2017']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 1,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 20),
                            width: MediaQuery.of(context).size.width,
                            child: Text("Гадна өнгө"),
                          ),
                          /* Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.only(top: 10),
                                    child: ToggleButtons(
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                      selectedColor: Colors.white,
                                      color: Color(0xff6E7FAA),
                                      fillColor: Color(0xff584BDD),
                                      children: <Widget>[
                                        Container(
                                          width: (MediaQuery.of(context).size.width - 36)/9,
                                          color: Colors.grey,
                                        ),
                                        Container(
                                          width: (MediaQuery.of(context).size.width - 36)/9,
                                          color: Colors.black,
                                        ),
                                        Container(
                                          width: (MediaQuery.of(context).size.width - 36)/9,
                                          color: Colors.red,
                                        ),
                                        Container(
                                          width: (MediaQuery.of(context).size.width - 36)/9,
                                          color: Colors.cyan,
                                        ),
                                        Container(
                                          width: (MediaQuery.of(context).size.width - 36)/9,
                                          color: Colors.blue,
                                        ),
                                        Container(
                                          width: (MediaQuery.of(context).size.width - 36)/9,
                                          color: Colors.brown,
                                        ),
                                        Container(
                                          width: (MediaQuery.of(context).size.width - 36)/9,
                                          color: Colors.purple,
                                        ),
                                        Container(
                                          width: (MediaQuery.of(context).size.width - 36)/9,
                                          color: Colors.indigo,
                                        ),
                                        Container(
                                          width: (MediaQuery.of(context).size.width - 36)/9,
                                          color: Colors.amber,
                                        ),
                                      ],
                                      onPressed: (int index) {
                                        setState(() {
                                          for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                                            if (buttonIndex == index) {
                                              isSelected[buttonIndex] = true;
                                            } else {
                                              isSelected[buttonIndex] = false;
                                            }
                                          }
                                        });
                                      },
                                      isSelected: isSelected,
                                    ),
                                  ),*/
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 20),
                            width: MediaQuery.of(context).size.width,
                            child: Text("Хөтлөгч"),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            width: (MediaQuery.of(context).size.width * 2) / 5,
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                child: DropdownButton(
                                  value: buildYear,
                                  isDense: true,
                                  style: TextStyle(
                                    color: Color(0xFF6E7FAA),
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      buildYear = newValue;
                                    });
                                  },
                                  items: <String>['2015', '2016', '2017']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 1,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 20),
                            width: MediaQuery.of(context).size.width,
                            child: Text("Хаяг байршил"),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              child: TextField(
                                obscureText: false,
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF6E7FAA),
                                    fontSize: 15.0),
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                    hintText: "22 авто зах",
                                    hintStyle: TextStyle(
                                        fontSize: 15.0,
                                        color: Color(0xFF6E7FAA)),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        0.0, 15.0, 0.0, 15.0),
                                    border: new UnderlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.red))),
                              )),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 20),
                            width: MediaQuery.of(context).size.width,
                            child: Text("Утас"),
                          ),

                        ],
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width:
                                  (MediaQuery.of(context).size.width * 2) / 5,
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  child: DropdownButton(
                                    value: buildYear,
                                    isDense: true,
                                    style: TextStyle(
                                      color: Color(0xFF6E7FAA),
                                    ),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        buildYear = newValue;
                                      });
                                    },
                                    items: <String>['2015', '2016', '2017']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                width:
                                    (MediaQuery.of(context).size.width * 2) / 5,
                                child: TextField(
                                  obscureText: false,
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xFF6E7FAA),
                                      fontSize: 15.0),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.left,
                                  decoration: InputDecoration(
                                      hintText: "8995 1555",
                                      hintStyle: TextStyle(
                                          fontSize: 15.0,
                                          color: Color(0xFF6E7FAA)),
                                      contentPadding: EdgeInsets.fromLTRB(
                                          0.0, 15.0, 0.0, 15.0),
                                      border: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.red))),
                                )),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 20),
                            width: MediaQuery.of(context).size.width,
                            child: Text("Нөхцөл"),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            width: (MediaQuery.of(context).size.width * 2) / 5,
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                child: DropdownButton(
                                  value: buildYear,
                                  isDense: true,
                                  style: TextStyle(
                                    color: Color(0xFF6E7FAA),
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      buildYear = newValue;
                                    });
                                  },
                                  items: <String>['2015', '2016', '2017']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 1,
                          ),
                        ],
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
                    Navigator.of(context).push(
                        FadeRoute(builder: (context) => AdNewStep3Screen()));
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
