import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hyrd/screens/add_car_screen.dart';
import 'package:hyrd/screens/bottom_bar.dart';
import 'package:hyrd/screens/dashboard_screen.dart';
import 'package:hyrd/screens/login/signUp/step_two.dart';
import 'package:hyrd/screens/profile/ad_screen.dart';
import 'package:hyrd/screens/profile/follower_screen.dart';
import 'package:hyrd/screens/profile/help_screen.dart';
import 'package:hyrd/screens/profile/setting_screen.dart';
import 'package:hyrd/screens/profile/user_information_screen.dart';
import 'package:hyrd/screens/total_ad_screen.dart';
import 'package:hyrd/utils/fade_route.dart';

class StepThirdScreen extends StatefulWidget {
  static const routeName = '/sign-up/step-3';

  @override
  _StepThirdExtendScreenState createState() => _StepThirdExtendScreenState();
}

class _StepThirdExtendScreenState extends State<StepThirdScreen> {

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



  Widget _buildButtons() {
    return Container(
      padding: EdgeInsets.only(right: 0, left: 0, top: 10, bottom: 20),
      width: MediaQuery.of(context).size.width,
      child: FlatButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.of(context).push(FadeRoute(builder: (context) => DashboardScreen()));
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
                Text("Нэвтрэх".toUpperCase(),
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                Icon(Icons.exit_to_app, color: Colors.white, size: 22.0)
              ],
            )),
      ),
    );
  }

  TextStyle style = TextStyle(fontFamily: 'Roboto', color: Colors.white, fontSize: 15.0);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(height: 50),
                      Text("Амжилттай бүртгэгдлээ", style: style.copyWith(color: Color(0xff222455), fontFamily: 'Roboto',fontWeight: FontWeight.w700, fontSize: 21)),
                      SizedBox(height: 50),
                      Container(
                        padding: EdgeInsets.only(left:50,right: 50),
                        child: Text("Аппликейшн тухай товч өгүүлбэр байх ба 2 мөрнөөс бүрдсэн байх шаардлагатай.",style: style.copyWith(color: Color(0xff6E7FAA), fontSize: 14)),
                      ),
                      SizedBox(height: 100),
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
                      SizedBox(height: 100),
                    ],
                  ),
                  _buildButtons(),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
