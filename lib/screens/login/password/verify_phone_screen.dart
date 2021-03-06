import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hyrd/screens/login/password/change_password.dart';
import 'package:hyrd/screens/login/signUp/step_two.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/utils/color_hyrd.dart';
import 'package:hyrd/utils/fade_route.dart';
import 'package:hyrd/utils/lang.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyPhoneScreen extends StatefulWidget {
  static const routeName = '/sign-up/step-1-1';

  final Map<String, String> map;

  VerifyPhoneScreen({this.map});

  @override
  VerifyPhoneScreenState createState() => VerifyPhoneScreenState();
}

class VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
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
            print(widget.map);
            Map<String, String> params = new HashMap();
            params.addAll(widget.map);
            widget.map["verification_code"] = currentText;
            print(params);
            BackendService.getVerifyEqual(body: widget.map).then((onValue) {
              if (onValue.statusCode == 200) {
                Navigator.pop(context);
                Navigator.of(context).push(FadeRoute(
                    builder: (context) => ChangePasswordScreen(
                          map: params,
                        )));
              } else {
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                    content:
                        Text(json.decode(onValue.body)["error"]["message"])));
                // Navigator.pop(context);
                // Navigator.of(context).push(FadeRoute(
                //     builder: (context) => StepTwoScreen(
                //           map: params,
                //         )));
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
    return Scaffold(
        key: _scaffoldKey,
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
          title: Text(lang.VERIFICATION,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          elevation: 0.0,
        ),
        body: Stack(
          children: <Widget>[
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
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
