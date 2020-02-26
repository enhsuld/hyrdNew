import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/screens/addNewAd/ad_new_step_4.dart';
import 'package:hyrd/screens/addNewAd/customCalendar.dart';
import 'package:hyrd/utils/fade_route.dart';

class AdNewStep3Screen extends StatefulWidget {
  static const routeName = '/adNew';

  final DateTime minimumDate;
  final DateTime maximumDate;
  final bool barrierDismissible;
  final DateTime initialStartDate;
  final DateTime initialEndDate;
  final Function(DateTime, DateTime) onApplyClick;
  final Function onCancelClick;
  final CarModel car;
  AdNewStep3Screen({Key key, @required this.car, this.minimumDate, this.maximumDate, this.barrierDismissible, this.initialStartDate, this.initialEndDate, this.onApplyClick, this.onCancelClick}) : super(key: key);

 // const AdNewStep3Screen({Key key, this.minimumDate, this.maximumDate, this.barrierDismissible, this.initialStartDate, this.initialEndDate, this.onApplyClick, this.onCancelClick}) : super(key: key);

  @override
  _AdNewStep3ScreenState createState() => _AdNewStep3ScreenState();
}

class _AdNewStep3ScreenState extends State<AdNewStep3Screen> with TickerProviderStateMixin{
  static const textColor = Color(0xFF2D3853);
  static const GradientRed = Color(0xFFDF2626);
  String dropdownValue = 'Суудлын тэрэг';
  String buildYear = '2015';

  bool isSwitched = true;
  bool isChecked = true;
  var isSelected = [false, true];
  List<String> countries = [
    'INDIA',
    'USA',
    'JAPAN',
  ];
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formData;

  AnimationController animationController;
  DateTime startDate;
  DateTime endDate;

  @override
  void initState() {
    animationController = AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    if (widget.initialStartDate != null) {
      startDate = widget.initialStartDate;
    }
    if (widget.initialEndDate != null) {
      endDate = widget.initialEndDate;
    }
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  TextEditingController _priceController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();

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
          title: Text("Зар оруулах 3/5",
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
                            child: new Card(
                              elevation: 10,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 20, left: 20, right: 20),
                                    child: Row(
                                      children: <Widget>[
                                        Text("Үнэ",
                                            style: TextStyle(
                                                fontFamily: "Sans",
                                                color: textColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 20, left: 20, right: 20),
                                    child: new TextField(
                                      decoration: new InputDecoration(
                                          suffixText: "Сая ₮",
                                          hintText: '0.00',
                                          suffixStyle: TextStyle(
                                              color: textColor,
                                              fontSize: 16,
                                              fontFamily: "Sans",
                                              fontWeight: FontWeight.bold)),
                                      controller: _priceController,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                          fontFamily: "Sans",
                                          color: textColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 20, left: 5),
                            child: Text(
                              "Нэмэлт тайлбар",
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xff222455)),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 20),
                            child: new Card(
                              elevation: 10,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Container(
                                padding: EdgeInsets.all(20),
                                height: 200,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/mainLogo.png"),
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                                child: TextField(
                                  maxLines: 8,
                                  decoration: InputDecoration.collapsed(hintText: "Enter your text here"),
                                ),
                              )
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 20, left: 5),
                            child: Text(
                              "Зарах хугацаа",
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xff6E7FAA)),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 20,bottom: 20),
                            child: new Card(
                              elevation: 10,
                             child:   CustomCalendarView(
                               minimumDate: widget.minimumDate,
                               maximumDate: widget.maximumDate,
                               initialEndDate: widget.initialEndDate,
                               initialStartDate: widget.initialStartDate,
                               startEndDateChange: (DateTime startDateData, DateTime endDateData) {
                                 setState(() {
                                   startDate = startDateData;
                                   endDate = endDateData;
                                 });
                               },
                             ),
                            ),
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
                    widget.car.price=int.parse(_priceController?.text ?? 0);
                    widget.car.description=_descriptionController?.text ?? "";
                    Navigator.push(context,MaterialPageRoute(builder: (context) => AdNewStep4Screen(car: widget.car)));
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
