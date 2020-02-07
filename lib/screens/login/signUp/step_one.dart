import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hyrd/screens/add_car_screen.dart';
import 'package:hyrd/screens/bottom_bar.dart';
import 'package:hyrd/screens/login/signUp/step_one_extend.dart';
import 'package:hyrd/screens/profile/ad_screen.dart';
import 'package:hyrd/screens/profile/follower_screen.dart';
import 'package:hyrd/screens/profile/help_screen.dart';
import 'package:hyrd/screens/profile/setting_screen.dart';
import 'package:hyrd/screens/profile/user_information_screen.dart';
import 'package:hyrd/screens/total_ad_screen.dart';
import 'package:hyrd/utils/fade_route.dart';

class StepOneScreen extends StatefulWidget {
  static const routeName = '/sign-up/step-1';

  @override
  _StepOneScreenScreenState createState() => _StepOneScreenScreenState();
}

class _StepOneScreenScreenState extends State<StepOneScreen> {

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
    style:  TextStyle(fontFamily: 'Roboto', color: Color(0xFF6E7FAA), fontSize: 15.0),
    textAlign: TextAlign.left,
    decoration: InputDecoration(
      hintText: "Утасны дугаар",
      hintStyle: TextStyle(fontSize: 15.0, color: Color(0xFF6E7FAA)),
      contentPadding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
        border: new UnderlineInputBorder(
            borderSide: new BorderSide(
                color: Colors.red
            )
        )
    ),
  );

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  String dropdownValue = 'Mongolia';

  Widget _buildProfileImage() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        elevation: 3,
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      FormBuilder(
                        key: _fbKey,
                        initialValue: {
                          'date': DateTime.now(),
                          'accept_terms': false,
                        },
                        autovalidate: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(top:20,left: 20,right: 20),
                              child:  FormBuilderDropdown(
                                attribute: "gender",
                                decoration: InputDecoration(labelText: "Gender"),
                                hint: Text('Select Gender'),
                                validators: [FormBuilderValidators.required()],
                                items: ['Male', 'Female', 'Other']
                                    .map((gender) => DropdownMenuItem(
                                    value: gender,
                                    child: Text("$gender")
                                )).toList(),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 20,right: 20),
                                child:  FormBuilderTextField(
                                  attribute: "phone",
                                  decoration: InputDecoration(labelText: "Утасны дугаар"),
                                  validators: [
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.numeric()
                                  ],
                                ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 20,right: 20,bottom: 30),
                              child: Text("Таны оруулсан дугаарт код илгээж таныг баталгаажуулах болно.", style: TextStyle(fontSize: 13,color: Color(0xff6E7FAA))),
                            ),
                            _buildButtons(),
                          ],
                        ),
                      ),
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
          if (_fbKey.currentState.saveAndValidate()) {
            print(_fbKey.currentState.value);
         //   Navigator.pop(context);
            Navigator.of(context).push(FadeRoute(builder: (context) => StepOneExtendScreen()));
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
                  Container(
                    child: Image.asset(
                      "assets/images/send.png",
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
