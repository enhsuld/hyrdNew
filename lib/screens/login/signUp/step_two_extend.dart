import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hyrd/screens/add_car_screen.dart';
import 'package:hyrd/screens/bottom_bar.dart';
import 'package:hyrd/screens/login/signUp/step_one_extend.dart';
import 'package:hyrd/screens/login/signUp/step_third.dart';
import 'package:hyrd/screens/profile/ad_screen.dart';
import 'package:hyrd/screens/profile/follower_screen.dart';
import 'package:hyrd/screens/profile/help_screen.dart';
import 'package:hyrd/screens/profile/setting_screen.dart';
import 'package:hyrd/screens/profile/user_information_screen.dart';
import 'package:hyrd/screens/total_ad_screen.dart';
import 'package:hyrd/utils/fade_route.dart';

class StepTwoExtendScreen extends StatefulWidget {
  static const routeName = '/sign-up/step-2-1';

  @override
  _StepTwoExtendScreenState createState() => _StepTwoExtendScreenState();
}

class _StepTwoExtendScreenState extends State<StepTwoExtendScreen> {

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


  final firstNameField = TextField(
    obscureText: false,
    style:  TextStyle(fontFamily: 'Roboto', color: Color(0xFF6E7FAA), fontSize: 15.0),
    textAlign: TextAlign.left,
    decoration: InputDecoration(
        hintText: "Овог",
        hintStyle: TextStyle(fontSize: 15.0, color: Color(0xFF6E7FAA)),
        contentPadding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
        border: new UnderlineInputBorder(
            borderSide: new BorderSide(
                color: Colors.red
            )
        )
    ),
  );
  final lastNameField = TextField(
    obscureText: false,
    style:  TextStyle(fontFamily: 'Roboto', color: Color(0xFF6E7FAA), fontSize: 15.0),
    textAlign: TextAlign.left,
    decoration: InputDecoration(
        hintText: "Нэр",
        hintStyle: TextStyle(fontSize: 15.0, color: Color(0xFF6E7FAA)),
        contentPadding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
        border: new UnderlineInputBorder(
            borderSide: new BorderSide(
                color: Colors.red
            )
        )
    ),
  );
  final regNumField = TextField(
    obscureText: false,
    style:  TextStyle(fontFamily: 'Roboto', color: Color(0xFF6E7FAA), fontSize: 15.0),
    textAlign: TextAlign.left,
    decoration: InputDecoration(
        hintText: "Регистрийн дугаар",
        hintStyle: TextStyle(fontSize: 15.0, color: Color(0xFF6E7FAA)),
        contentPadding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
        border: new UnderlineInputBorder(
            borderSide: new BorderSide(
                color: Colors.red
            )
        )
    ),
  );



  final phoneField = TextField(
    obscureText: false,
    style:  TextStyle(fontFamily: 'Roboto', color: Color(0xFF6E7FAA), fontSize: 15.0),
    textAlign: TextAlign.left,
    decoration: InputDecoration(
      hintText: "Улсын дугаар",
      hintStyle: TextStyle(fontSize: 15.0, color: Color(0xFF6E7FAA)),
      contentPadding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
        border: new UnderlineInputBorder(
            borderSide: new BorderSide(
                color: Colors.red
            )
        )
    ),
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
                              width:MediaQuery.of(context).size.width*0.45,
                              padding: EdgeInsets.only(left: 20,right: 20),
                              child: firstNameField
                          ),
                          Container(
                              width:MediaQuery.of(context).size.width*0.45,
                              padding: EdgeInsets.only(left: 20,right: 20),
                              child: lastNameField
                          ),
                        ],
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 20,right: 20),
                          child: regNumField
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(top:20,left: 20,right: 20),
                            child: DropdownButton<String>(
                                isDense: true,
                                style: TextStyle(color: Color(0xFF6E7FAA),),
                                value: dropdownValue,
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValue = newValue;
                                  });
                                },
                                items: <String>['Mongolia', 'China', 'Russia']
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList()),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              width:MediaQuery.of(context).size.width*0.45,
                              padding: EdgeInsets.only(left: 20,right: 20),
                              child: phoneField
                          ),
                          Container(
                              width:MediaQuery.of(context).size.width*0.45,
                              padding: EdgeInsets.only(top:10),
                              child: ToggleButtons(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                selectedColor: Colors.white,
                                color: Color(0xff6E7FAA),
                                fillColor: Color(0xff584BDD),
                                //borderColor: Colors.white,
                                children: <Widget>[
                                  Container(
                                    child: Text("Male"),
                                  ),
                                  Container(
                                    child: Text("Female"),
                                  )
                                ],
                                onPressed: (int index) {
                                  setState(() {
                                    for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                                      if (buttonIndex == index) {
                                        isSelected[buttonIndex] = !isSelected[buttonIndex];
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
                      SizedBox(
                        height: 10,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Checkbox(
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value;
                              });
                            },
                          ),
                          Text("Үйлчилгээний нөхцөл зөвшөөрч байна.", style: TextStyle(fontSize: 13,color: Color(0xff6E7FAA))),
                        ],
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
          Navigator.pop(context);
          Navigator.of(context).push(FadeRoute(builder: (context) => StepThirdScreen()));
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
      body: Stack(
        children: <Widget>[
          _buildCoverImage(screenSize),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top:20,bottom: 10),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          padding: new EdgeInsets.all(20),
                          icon: new Icon(Icons.arrow_back_ios,color: Colors.white, size: 18.0),
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
      )
    );
  }
}
