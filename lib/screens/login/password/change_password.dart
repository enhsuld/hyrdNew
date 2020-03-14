import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hyrd/screens/login/signUp/step_two_extend.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/utils/fade_route.dart';
import 'package:hyrd/utils/lang.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const routeName = '/sign-up/step-2';

  Map<String, String> map;

  ChangePasswordScreen({this.map});

  @override
  ChangePasswordScreenScreenState createState() =>
      ChangePasswordScreenScreenState();
}

class ChangePasswordScreenScreenState extends State<ChangePasswordScreen> {
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

  String _password;
  bool _autoValidate = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _ctlPassword = new TextEditingController();
  TextEditingController _ctlPasswordConfirm = new TextEditingController();

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
                  child: Form(
                    key: _formKey,
                    autovalidate: _autoValidate,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: TextFormField(
                              controller: _ctlPassword,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: lang.NEW_PASS,
                                  hintStyle: TextStyle(
                                      fontSize: 15.0, color: Color(0xFF6E7FAA)),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                                  border: new UnderlineInputBorder(
                                      borderSide:
                                          new BorderSide(color: Colors.red))),
                              validator: (val) => val.length < 6
                                  ? 'The password must be at least 6 characters.'
                                  : null,
                              onSaved: (val) => _password = val),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(bottom: 20, right: 20, left: 20),
                          child: TextFormField(
                              controller: _ctlPasswordConfirm,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                  hintText: "Нууц үг давтан оруулах",
                                  hintStyle: TextStyle(
                                      fontSize: 15.0, color: Color(0xFF6E7FAA)),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                                  border: new UnderlineInputBorder(
                                      borderSide:
                                          new BorderSide(color: Colors.red))),
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
                          padding:
                              EdgeInsets.only(left: 20, right: 20, bottom: 30),
                          child: Text(
                              "Нууц үг багадаа 8 оронтой байх ба тусгай тэмдэг оруулсан байх шайрдлагтай.",
                              style: TextStyle(
                                  fontSize: 13, color: Color(0xff6E7FAA))),
                        ),
                        _buildButtons(),
                      ],
                    ),
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
          print(widget.map);
          _validateInputs();
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
                Text(lang.SAVE.toUpperCase(),
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
          title: Text(lang.NEW_PASS,
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
                    SizedBox(height: 30),
                    _buildProfileImage(),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  void _validateInputs() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(widget.map);
      widget.map["password"] = _ctlPassword.text;
      widget.map["password_confirmation"] = _ctlPasswordConfirm.text;
      BackendService.postNewPassword(body: widget.map).then((onValue) {
        if (onValue.statusCode == 200) {
          Navigator.pop(context);
        } else {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text(json.decode(onValue.body)["error"]["message"])));
          // Navigator.pop(context);
          // Navigator.of(context).push(FadeRoute(
          //     builder: (context) => StepTwoScreen(
          //           map: params,
          //         )));
        }
      });
      // setState(() {
      //   _autoValidate = true;
      //   Navigator.pop(context);
      // });
    }
  }
}
