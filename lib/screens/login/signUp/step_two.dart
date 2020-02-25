import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hyrd/screens/login/signUp/step_two_extend.dart';
import 'package:hyrd/utils/fade_route.dart';

class StepTwoScreen extends StatefulWidget {
  static const routeName = '/sign-up/step-2';

  @override
  _StepTwoScreenScreenState createState() => _StepTwoScreenScreenState();
}

class _StepTwoScreenScreenState extends State<StepTwoScreen> {

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

  String _password;
  TextEditingController _ctlPassword = new TextEditingController();

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
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: TextFormField(
                            controller: _ctlPassword,
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: "Нууц үг",
                                hintStyle: TextStyle(fontSize: 15.0, color: Color(0xFF6E7FAA)),
                                contentPadding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                                border: new UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Colors.red
                                    )
                                )
                            ),
                            validator: (val) => val.length < 6
                                ? 'The password must be at least 6 characters.'
                                : null,
                            onSaved: (val) => _password = val),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 20,right: 20,left: 20),
                        child: TextFormField(
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                                hintText: "Нууц үг давтан оруулах",
                                hintStyle: TextStyle(fontSize: 15.0, color: Color(0xFF6E7FAA)),
                                contentPadding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                                border: new UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Colors.red
                                    )
                                )
                            ),
                            validator: (value) {
                              if (value != _ctlPassword.text) {
                                return 'Password is not matching';
                              }
                              return null;
                            },
                            obscureText: true,
                            onChanged: (value) {}),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20,right: 20,bottom: 30),
                        child: Text("Нууц үг багадаа 8 оронтой байх ба тусгай тэмдэг оруулсан байх шайрдлагтай.", style: TextStyle(fontSize: 13,color: Color(0xff6E7FAA))),
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
        //  Navigator.pop(context);
          Navigator.of(context).push(FadeRoute(builder: (context) => StepTwoExtendScreen()));


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
                   padding: EdgeInsets.all(30),
                    width: MediaQuery.of(context).size.width - 150,
                    child: Image.asset(
                      "assets/images/lock.png",
                      fit: BoxFit.fitWidth,
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
