import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/models/taxonomy.dart';
import 'package:hyrd/screens/addNewAd/ad_new_step_3.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/utils/fade_route.dart';

class AdNewStep2Screen extends StatefulWidget {
  static const routeName = '/adNew';
  final CarModel car;

  AdNewStep2Screen({Key key, @required this.car}) : super(key: key);

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



  var carMarks = new List<TaxonomyModel>();
  var carModels = new List<TaxonomyModel>();
  var carFuelTypes = new List<TaxonomyModel>();
  var carTransmissions = new List<TaxonomyModel>();
  var carClasses = new List<TaxonomyModel>();
  var carWheelPositions = new List<TaxonomyModel>();
  var carManCounts = new List<TaxonomyModel>();
  var carDriveTrains = new List<TaxonomyModel>();

  TaxonomyModel carMark,
      carModel,
      carFuelType,
      carTransmission,
      carClass,
      carWheelPosition,
      carManCount,
      carDriveTrain;

  @override
  void initState() {

    BackendService.getTaxonomies(taxonomy: '/mark').then((taxonomy) {
      setState(() {
        this.carMarks = taxonomy;
      });
    });
    BackendService.getTaxonomies(taxonomy: '/toyota').then((taxonomy) {
      setState(() {
        this.carModels = taxonomy;
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

  TextEditingController _addressController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();

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
                                child: DropdownButton<TaxonomyModel>(
                                    value: carMark,
                                    hint: Text("Сонгох"),
                                    isDense: true,
                                    style: TextStyle(
                                      color: Color(0xFF6E7FAA),
                                    ),
                                    onChanged: (TaxonomyModel item) {
                                      setState(() {
                                        carMark = item;
                                        widget.car.markName =item.name;
                                      });
                                    },
                                    items: buildAndGetDropDownMenuItems(
                                        carMarks)),
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
                                child: DropdownButton<TaxonomyModel>(
                                    value: carModel,
                                    hint: Text("Сонгох"),
                                    isDense: true,
                                    style: TextStyle(
                                      color: Color(0xFF6E7FAA),
                                    ),
                                    onChanged: (TaxonomyModel item) {
                                      setState(() {
                                        carModel = item;
                                        widget.car.modelName =item.name;
                                      });
                                    },
                                    items: buildAndGetDropDownMenuItems(
                                        carModels)),
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
                            child: Text("Хөтлөгч"),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            width: (MediaQuery.of(context).size.width * 2) / 5,
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                child: DropdownButton<TaxonomyModel>(
                                    value: carDriveTrain,
                                    hint: Text("Сонгох"),
                                    isDense: true,
                                    style: TextStyle(
                                      color: Color(0xFF6E7FAA),
                                    ),
                                    onChanged: (TaxonomyModel item) {
                                      setState(() {
                                        carDriveTrain = item;
                                        widget.car.description =
                                            item.id.toString();
                                      });
                                    },
                                    items: buildAndGetDropDownMenuItems(
                                        carDriveTrains)),
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
                                controller: _addressController,
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
                                    items: <String>['Mongolia (+976)', '2015','2016', '2017']
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
                                  controller: _phoneController,
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
                    widget.car.ownerAddress=_addressController.text;
                    widget.car.ownerHandphone=_phoneController.text;
                    Navigator.push(context,MaterialPageRoute(builder: (context) => AdNewStep3Screen(car: widget.car)));
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
