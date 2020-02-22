import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hyrd/screens/add_car_screen.dart';
import 'package:hyrd/screens/bottom_bar.dart';
import 'package:hyrd/screens/dashboard_screen.dart';
import 'package:hyrd/screens/home_screen.dart';
import 'package:hyrd/screens/login/signUp/step_one.dart';
import 'package:hyrd/screens/profile/ad_screen.dart';
import 'package:hyrd/screens/profile/follower_screen.dart';
import 'package:hyrd/screens/profile/help_screen.dart';
import 'package:hyrd/screens/profile/setting_screen.dart';
import 'package:hyrd/screens/profile/user_information_screen.dart';
import 'package:hyrd/screens/total_ad_screen.dart';
import 'package:hyrd/utils/fade_route.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextStyle style =
      TextStyle(fontFamily: 'Roboto', color: Colors.white, fontSize: 15.0);

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      obscureText: false,
      style: style,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: "Утасны дугаар",
        hintStyle: TextStyle(fontSize: 15.0, color: Colors.white),
        prefixIcon: Container(
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(50.0),
            color: Colors.white,
          ),
          child: new IconButton(
              icon: new Icon(
                Icons.account_circle,
                color: Colors.purple,
              ),
              onPressed: null),
        ),
        prefixText: ' ',
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
    final passwordField = TextField(
      obscureText: true,
      style: style.copyWith(color: Colors.white, fontSize: 15),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Нууц үг",
        hintStyle: TextStyle(fontSize: 15.0, color: Colors.white),
        prefixIcon: Container(
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(50.0),
            color: Colors.white,
          ),
          child: new IconButton(
              icon: new Icon(
                Icons.lock_open,
                color: Colors.purple,
              ),
              onPressed: null),
        ),
        prefixText: ' ',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.of(context).push(FadeRoute(builder: (context) => HomeScreen()));
        },
        child: Text("Нэвтрэх".toUpperCase(),
            textAlign: TextAlign.center,
            style: style.copyWith(color: Color(0xff5F4CE0), fontSize: 15)),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.topRight,
            colors: <Color>[Color(0xFF584BDD), Color(0xFFB755FF)],
          )),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left:26.0,right: 26.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                      /*  decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(50.0),
                          color: Colors.white.withOpacity(0.1),
                        ),*/
                        child: Image.asset('assets/images/screen-logo.png',fit: BoxFit.cover,),
                      ),
                      SizedBox(height: 25.0),
                      Column(
                        children: <Widget>[
                          Text("HYRD CAR",
                              style: style.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 29)),
                          Text("APP SERVICE",
                              style:
                              style.copyWith(color: Colors.white, fontSize: 14))
                        ],
                      ),
                      SizedBox(height: 45.0),
                      emailField,
                      SizedBox(height: 25.0),
                      passwordField,
                      SizedBox(
                        height: 35.0,
                      ),
                      loginButon,
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Та бүртгэлүй бол?",
                              style:
                              style.copyWith(color: Colors.grey, fontSize: 15)),
                          new InkWell(
                              child: Padding(
                                padding: new EdgeInsets.all(10.0),
                                child: new Text("Шинээр бүртгүүлэх",    style:style.copyWith(color: Colors.white, fontSize: 15)),
                              ),
                              onTap: () {
                                Navigator.of(context).push(FadeRoute(builder: (context) => StepOneScreen()));
                              }
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new InkWell(
                        child: Padding(
                          padding: new EdgeInsets.all(10.0),
                          child: new Text("Нууц үг мартсан?", style:style.copyWith(color: Colors.white, fontSize: 15)),
                        ),
                        onTap: () {
                          // Navigator.pop(context);
                          // Navigator.of(context).push(FadeRoute(builder: (context) => SignUpPage()));
                        }
                    ),
                  ],
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
