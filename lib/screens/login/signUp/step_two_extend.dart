import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hyrd/screens/login/signUp/step_third.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/utils/fade_route.dart';

class StepTwoExtendScreen extends StatefulWidget {
  static const routeName = '/sign-up/step-2-1';

  Map<String, String> map;

  StepTwoExtendScreen({this.map});

  @override
  _StepTwoExtendScreenState createState() => _StepTwoExtendScreenState();
}

class _StepTwoExtendScreenState extends State<StepTwoExtendScreen> {
  TextEditingController _firstName = new TextEditingController();
  TextEditingController _lastName = new TextEditingController();
  TextEditingController _reg = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 2,
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
        hintText: "Улсын дугаар",
        hintStyle: TextStyle(fontSize: 15.0, color: Color(0xFF6E7FAA)),
        contentPadding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
        border: new UnderlineInputBorder(
            borderSide: new BorderSide(color: Colors.red))),
  );

  String dropdownValue = 'Mongolia';
  bool isSwitched = true;
  bool isChecked = true;
  var isSelected = [false, true];

  Widget _buildProfileImage() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        color: Colors.white,
        elevation: 5,
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: TextField(
                                obscureText: false,
                                controller: _firstName,
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF6E7FAA),
                                    fontSize: 15.0),
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                    hintText: "Овог",
                                    hintStyle: TextStyle(
                                        fontSize: 15.0,
                                        color: Color(0xFF6E7FAA)),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        0.0, 15.0, 0.0, 15.0),
                                    border: new UnderlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.red))),
                              )),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: TextField(
                                controller: _lastName,
                                obscureText: false,
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF6E7FAA),
                                    fontSize: 15.0),
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                    hintText: "Нэр",
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
                      Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: TextField(
                            controller: _reg,
                            obscureText: false,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Color(0xFF6E7FAA),
                                fontSize: 15.0),
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                                hintText: "Регистрийн дугаар",
                                hintStyle: TextStyle(
                                    fontSize: 15.0, color: Color(0xFF6E7FAA)),
                                contentPadding:
                                    EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                                border: new UnderlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.red))),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Checkbox(
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value;
                                });
                              },
                            ),
                            Text("Үйлчилгээний нөхцөл зөвшөөрч байна.",
                                style: TextStyle(
                                    fontSize: 13, color: Color(0xff6E7FAA))),
                          ],
                        ),
                      ),
                      _buildButtons(),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Container(
      padding: EdgeInsets.only(right: 0, left: 0, top: 10, bottom: 20),
      width: MediaQuery.of(context).size.width,
      child: FlatButton(
        onPressed: () {
          widget.map["firstname"] = _firstName.text;
          widget.map["lastname"] = _lastName.text;
          widget.map["regnum"] = _reg.text;
          BackendService.postRegister(body: widget.map).then((onValue) {
            if (onValue.statusCode == 200) {
              Navigator.pop(context);
              Navigator.of(context)
                  .push(FadeRoute(builder: (context) => StepThirdScreen()));
            } else {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text(json.decode(onValue.body)["message"])));
            }
          });
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
                Text("Үргэлжлүүлэх".toUpperCase(),
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                Icon(Icons.exit_to_app, color: Colors.white, size: 22.0)
              ],
            )),
      ),
    );
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
                              "Бүртгэл 2/3",
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
                    Container(
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(150.0),
                        color: Colors.white.withOpacity(0.1),
                      ),
                      child: Image.asset(
                        "assets/images/pic.png",
                        width: MediaQuery.of(context).size.width - 250,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 30),
                    _buildProfileImage(),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
