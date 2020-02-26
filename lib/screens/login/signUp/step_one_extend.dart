import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hyrd/screens/login/signUp/step_two.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/utils/color_hyrd.dart';
import 'package:hyrd/utils/fade_route.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class StepOneExtendScreen extends StatefulWidget {
  static const routeName = '/sign-up/step-1-1';

  final Map<String, String> map;

  StepOneExtendScreen({this.map});

  @override
  _StepOneExtendScreenState createState() => _StepOneExtendScreenState();
}

class _StepOneExtendScreenState extends State<StepOneExtendScreen> {
  String currentText;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: 130,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.topRight,
        colors: <Color>[Color(0xFF584BDD), Color(0xFFB755FF)],
      )),
    );
  }

  final phoneField = TextField(
    obscureText: false,
    style: TextStyle(
        fontFamily: 'Roboto', color: Color(0xFF6E7FAA), fontSize: 15.0),
    textAlign: TextAlign.left,
    decoration: InputDecoration(
        hintText: "Утасны дугаар",
        hintStyle: TextStyle(fontSize: 15.0, color: Color(0xFF6E7FAA)),
        contentPadding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
        border: new UnderlineInputBorder(
            borderSide: new BorderSide(color: Colors.red))),
  );

  Widget _buildButtons() {
    return Container(
      padding: EdgeInsets.only(right: 0, left: 0, top: 10, bottom: 20),
      width: MediaQuery.of(context).size.width,
      child: FlatButton(
        onPressed: () {
          if (currentText != null &&
              currentText.isNotEmpty &&
              currentText.length == 4) {
            widget.map["verification_code"] = currentText;
            BackendService.getVerifyEqual(body: widget.map).then((onValue) {
              if (onValue.statusCode == 200) {
                Navigator.pop(context);
                Navigator.of(context)
                    .push(FadeRoute(builder: (context) => StepTwoScreen()));
              } else {
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                    content:
                        Text(json.decode(onValue.body)["error"]["message"])));
              }
            });
          }
        },
        textColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
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
            padding: const EdgeInsets.fromLTRB(30, 15, 15, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Баталгаажуулах".toUpperCase(),
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                Icon(Icons.exit_to_app, color: Colors.white, size: 22.0)
              ],
            )),
      ),
    );
  }

  TextStyle style =
      TextStyle(fontFamily: 'Roboto', color: Colors.white, fontSize: 15.0);
  Timer _timer;
  int _start = 30;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            _buildCoverImage(screenSize),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            padding: new EdgeInsets.all(20),
                            icon: new Icon(Icons.arrow_back_ios,
                                color: Colors.white, size: 18.0),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 120,
                            child: Text(
                              "Бүртгэл 1/3",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        SizedBox(height: 50),
                        Text("Баталгаажуулах код".toUpperCase(),
                            style: style.copyWith(
                                color: Color(0xff222455),
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                                fontSize: 21)),
                        SizedBox(height: 30),
                        Text("Илгээсэн баталгаажуулах кодыг оруулна уу",
                            style: style.copyWith(
                                color: Color(0xff6E7FAA), fontSize: 14)),
                        SizedBox(height: 20),
                        Text(
                            "(" +
                                (widget?.map["country_code"] ?? "+976") +
                                ") " +
                                (widget?.map["phone"] ?? ""),
                            style: style.copyWith(
                                color: Color(0xff6E7FAA), fontSize: 14)),
                        SizedBox(height: 40),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child: PinCodeTextField(
                            length: 4,
                            obsecureText: false,
                            textInputType: TextInputType.number,
                            animationType: AnimationType.fade,
                            shape: PinCodeFieldShape.box,
                            animationDuration: Duration(milliseconds: 300),
                            borderRadius: BorderRadius.circular(5),
                            selectedColor: ColorHyrd.pink,
                            activeColor: ColorHyrd.pink,
                            inactiveColor: ColorHyrd.pink,
                            fieldHeight: 55,
                            fieldWidth: 50,
                            onChanged: (value) {
                              setState(() {
                                print(value);
                                currentText = value;
                              });
                            },
                          ),
                        ),
                        /* PinFieldAutoFill(
                          codeLength:4
                      ),*/
                        SizedBox(height: 40),
                        (_start == 0)
                            ? FlatButton(
                                onPressed: () {
                                  BackendService.getVerifyCode(body: widget.map)
                                      .then((onValue) {
                                    _start = 30;
                                    startTimer();
                                  });
                                },
                                child: Text("Дахин код авах"),
                              )
                            : Container(),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'Та ',
                            style: style.copyWith(
                                color: Color(0xff6E7FAA), fontSize: 14),
                            children: <TextSpan>[
                              TextSpan(
                                text: "$_start",
                                style: TextStyle(
                                  color: Color(0xff5F4CE0),
                                  fontWeight: FontWeight.bold,
                                  decorationStyle: TextDecorationStyle.wavy,
                                ),
                              ),
                              TextSpan(
                                  text:
                                      ' секундын дотор кодыг бөглөх \n\n ёстойг анхаарна уу'),
                            ],
                          ),
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                    SizedBox(height: 30),
                    _buildButtons(),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
