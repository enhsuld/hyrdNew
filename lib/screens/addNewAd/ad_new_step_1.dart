import 'dart:collection';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/models/taxonomy.dart';
import 'package:hyrd/screens/addNewAd/ad_new_step_2.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/utils/fade_route.dart';

class AdNewScreen extends StatefulWidget {
  static const routeName = '/adNew';
  final CarModel car;

  AdNewScreen({Key key, @required this.car}) : super(key: key);

  @override
  _AdNewScreenState createState() => _AdNewScreenState();
}

class _AdNewScreenState extends State<AdNewScreen> {
  static const textColor = Color(0xFF2D3853);
  static const GradientRed = Color(0xFFDF2626);
  String dropdownValue = 'Суудлын тэрэг';
  String buildYear = '2015';

  int typeId = 0;

  bool isSwitched = true;
  bool isChecked = true;
  var isSelected = [false, true];
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formData;

  var nowDate = new DateTime.now();
  List<int> yearList;
  var yearBuildList;

  var carTypes = new List<TaxonomyModel>();
  var carColors = new List<TaxonomyModel>();
  var carFuelTypes = new List<TaxonomyModel>();
  var carTransmissions = new List<TaxonomyModel>();
  var carClasses = new List<TaxonomyModel>();
  var carWheelPositions = new List<TaxonomyModel>();
  var carManCounts = new List<TaxonomyModel>();
  var carDriveTrains = new List<TaxonomyModel>();

  TaxonomyModel carType,
      carColor,
      carFuelType,
      carTransmission,
      carClass,
      carWheelPosition,
      carManCount,
      carDriveTrain;

  @override
  void initState() {
    yearList = List.generate(0, (i) => nowDate.year - i);
    yearBuildList = List.generate(30, (i) => nowDate.year - i);

    BackendService.getTaxonomies(taxonomy: '/type').then((taxonomy) {
      setState(() {
        this.carTypes = taxonomy;
      });
    });
    BackendService.getTaxonomies(taxonomy: '/color').then((taxonomy) {
      setState(() {
        this.carColors = taxonomy;
      });
    });
    BackendService.getTaxonomies(taxonomy: '/fuel-type').then((taxonomy) {
      setState(() {
        this.carFuelTypes = taxonomy;
      });
    });
    BackendService.getTaxonomies(taxonomy: '/transmission').then((taxonomy) {
      setState(() {
        this.carTransmissions = taxonomy;
      });
    });
    BackendService.getTaxonomies(taxonomy: '/class').then((taxonomy) {
      setState(() {
        this.carClasses = taxonomy;
      });
    });
    BackendService.getTaxonomies(taxonomy: '/wheel-position').then((taxonomy) {
      setState(() {
        this.carWheelPositions = taxonomy;
      });
    });
    BackendService.getTaxonomies(taxonomy: '/man-count').then((taxonomy) {
      setState(() {
        this.carManCounts = taxonomy;
      });
    });
    BackendService.getTaxonomies(taxonomy: '/drivetrain').then((taxonomy) {
      setState(() {
        this.carDriveTrains = taxonomy;
      });
    });
    super.initState();
  }

  List<DropdownMenuItem<TaxonomyModel>> buildAndGetDropDownMenuItems(
      List carTypes) {
    List<DropdownMenuItem<TaxonomyModel>> items = List();
    for (TaxonomyModel item in carTypes) {
      items.add(DropdownMenuItem(value: item, child: Text(item.name)));
    }
    return items;
  }

  TextEditingController _capacityController = new TextEditingController();
  TextEditingController _mileageController = new TextEditingController();

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
          title: Text("Зар оруулах 1/5",
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
                            child: Text("Төрөл"),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            width: (MediaQuery.of(context).size.width * 2) / 5,
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                child: DropdownButton<TaxonomyModel>(
                                    value: carType,
                                    hint: Text("Сонгох"),
                                    isDense: true,
                                    style: TextStyle(
                                      color: Color(0xFF6E7FAA),
                                    ),
                                    onChanged: (TaxonomyModel item) {
                                      setState(() {
                                        carType = item;
                                        widget.car.type = item.name;
                                      });
                                    },
                                    items:buildAndGetDropDownMenuItems(carTypes)),
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
                            child: Text("Дотор өнгө"),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            width: (MediaQuery.of(context).size.width * 2) / 5,
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                child: DropdownButton<TaxonomyModel>(
                                    value: carColor,
                                    hint: Text("Сонгох"),
                                    isDense: true,
                                    style: TextStyle(
                                      color: Color(0xFF6E7FAA),
                                    ),
                                    onChanged: (TaxonomyModel item) {
                                      setState(() {
                                        carColor = item;
                                        widget.car.colorName = item.name;
                                      });
                                    },
                                    items: buildAndGetDropDownMenuItems(
                                        carColors)),
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
                            child: Text("Хурдны хайрцаг"),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(top: 10),
                            child: ToggleButtons(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              selectedColor: Colors.white,
                              color: Color(0xff6E7FAA),
                              fillColor: Color(0xff584BDD),
                              children: <Widget>[
                                Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 43) /
                                          2,
                                  child: Text(
                                    "Механик",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 43) /
                                          2,
                                  child: Text(
                                    "Автомат",
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                              onPressed: (int index) {
                                setState(() {
                                  for (int buttonIndex = 0;
                                      buttonIndex < isSelected.length;
                                      buttonIndex++) {
                                    if (buttonIndex == index) {
                                      isSelected[buttonIndex] =
                                          !isSelected[buttonIndex];
                                    } else {
                                      isSelected[buttonIndex] = false;
                                    }
                                  }
                                });
                              },
                              isSelected: isSelected,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 20),
                            width: MediaQuery.of(context).size.width,
                            child: Text("Үйлдвэрлэсэн он"),
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
                            child: Text("Орж ирсэн он"),
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
                            child: Text("Хөдөлгүүр"),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            width: (MediaQuery.of(context).size.width * 2) / 5,
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                child: DropdownButton<TaxonomyModel>(
                                    value: carFuelType,
                                    hint: Text("Сонгох"),
                                    isDense: true,
                                    style: TextStyle(
                                      color: Color(0xFF6E7FAA),
                                    ),
                                    onChanged: (TaxonomyModel item) {
                                      setState(() {
                                        carFuelType = item;
                                        widget.car.fuelType = item.name;
                                      });
                                    },
                                    items: buildAndGetDropDownMenuItems(
                                        carFuelTypes)),
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
                            child: Text("Хүрд"),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            width: (MediaQuery.of(context).size.width * 2) / 5,
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                child: DropdownButton<TaxonomyModel>(
                                    value: carWheelPosition,
                                    hint: Text("Сонгох"),
                                    isDense: true,
                                    style: TextStyle(
                                      color: Color(0xFF6E7FAA),
                                    ),
                                    onChanged: (TaxonomyModel item) {
                                      setState(() {
                                        carWheelPosition = item;
                                        widget.car.wheelPosition = item.name;
                                      });
                                    },
                                    items: buildAndGetDropDownMenuItems(
                                        carWheelPositions)),
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
                            child: Text("Суудал"),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            width: (MediaQuery.of(context).size.width * 2) / 5,
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                child: DropdownButton<TaxonomyModel>(
                                    value: carManCount,
                                    hint: Text("Сонгох"),
                                    isDense: true,
                                    style: TextStyle(
                                      color: Color(0xFF6E7FAA),
                                    ),
                                    onChanged: (TaxonomyModel item) {
                                      setState(() {
                                        carManCount = item;
                                        widget.car.manCount =
                                            int.parse(item.name);
                                      });
                                    },
                                    items: buildAndGetDropDownMenuItems(
                                        carManCounts)),
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
                            child: Text("Явсан км"),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              child: TextField(
                                obscureText: false,
                                controller: _mileageController,
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF6E7FAA),
                                    fontSize: 15.0),
                                textAlign: TextAlign.left,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: "0 км",
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 20),
                            width: MediaQuery.of(context).size.width,
                            child: Text("Мотор багтаамж"),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              child: TextField(
                                obscureText: false,
                                controller: _capacityController,
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF6E7FAA),
                                    fontSize: 15.0),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                    hintText: "2.0 л",
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
                    /* widget.car.mileage =
                        int.parse(_mileageController?.text ?? "0");
                    widget.car.capacity =
                        int.parse(_capacityController?.text ?? "0");

                    Map<String, dynamic> adMap = new HashMap();
                    adMap['type'] = widget.car.type;
                    adMap['colorName'] = widget.car.colorName;
                    adMap['fuelType'] = widget.car.fuelType;
                    adMap['mileage'] = widget.car.mileage;
                    adMap['capacity'] = widget.car.capacity;
                    adMap['user_id'] = 1;
                    adMap['manCount'] = widget.car.manCount;
                    adMap['wheelPosition'] = widget.car.wheelPosition;

                    BackendService.createCarAds(taxonomy: adMap).then((onValue) {
                      print(onValue);

                    });*/
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AdNewStep2Screen(car: widget.car)));
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
