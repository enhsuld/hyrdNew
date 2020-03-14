import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hyrd/models/profile_model.dart';
import 'package:hyrd/screens/profile/ad_screen.dart';
import 'package:hyrd/screens/profile/notification_screen.dart';
import 'package:hyrd/screens/profile/reset_password_screen.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/utils/fade_route.dart';
import 'package:hyrd/utils/hyrd_icons.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:toast/toast.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const routeName = '/reset/password';

  final ProfileModel user;

  ResetPasswordScreen({Key key, @required this.user}) : super(key: key);

  @override
  _UserInformationScreenState createState() => _UserInformationScreenState();
}



bool _autovalidate = false;

class _UserInformationScreenState extends State<ResetPasswordScreen> {

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  TextEditingController _currentPasswordController = new TextEditingController();
  TextEditingController _newPasswordController = new TextEditingController();
  TextEditingController _confirmPasswordController = new TextEditingController();

  String _currentPassword,_newPassword,_confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text("Нууц үг шинэчлэх",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        elevation: 0.0,
      ),
      body: Container(
        child: Form(
          key: formKey,
          autovalidate: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          new Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            child: Container(
                              padding: EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 10),
                              child: Column(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: Text("Хуучин нууц үг"),
                                      ),
                                      Container(
                                          width: MediaQuery.of(context).size.width,
                                          child: TextFormField(
                                            controller: _currentPasswordController,
                                            validator: (val) => val.length < 2
                                                ? 'The password must be at least 2 characters.'
                                                : null,
                                            onSaved: (val) => _currentPassword = val,
                                            obscureText: true,
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Color(0xFF6E7FAA),
                                                fontSize: 15.0),
                                            textAlign: TextAlign.left,
                                            decoration: InputDecoration(
                                                hintStyle: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Color(0xFF6E7FAA)),
                                                contentPadding: EdgeInsets.fromLTRB(
                                                    0.0, 15.0, 0.0, 15.0),
                                                border: new UnderlineInputBorder(
                                                    borderSide: new BorderSide(
                                                        color: Colors.red))),
                                          )),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(top: 20),
                                        width: MediaQuery.of(context).size.width,
                                        child: Text("Шинэ нууц үг"),
                                      ),
                                      Container(
                                          width: MediaQuery.of(context).size.width,
                                          child: TextFormField(
                                            controller: _newPasswordController,
                                            validator: (val) => val.length < 3
                                                ? 'The password must be at least 3 characters.'
                                                : null,
                                            onSaved: (val) => _newPassword = val,
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Color(0xFF6E7FAA),
                                                fontSize: 15.0),
                                            textAlign: TextAlign.left,
                                            decoration: InputDecoration(
                                                hintStyle: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Color(0xFF6E7FAA)),
                                                contentPadding: EdgeInsets.fromLTRB(
                                                    0.0, 15.0, 0.0, 15.0),
                                                border: new UnderlineInputBorder(
                                                    borderSide: new BorderSide(
                                                        color: Colors.red))),
                                          )),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(top: 20),
                                        width: MediaQuery.of(context).size.width,
                                        child: Text("Нууц үг давтах"),
                                      ),
                                      Container(
                                          width: MediaQuery.of(context).size.width,
                                          child: TextFormField(
                                            controller: _confirmPasswordController,
                                            validator: (value) {
                                              if (value != _newPasswordController.text) {
                                                return 'Password is not matching';
                                              }
                                              return null;
                                            },
                                            obscureText: true,
                                            onSaved: (val) => _confirmPassword = val,
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Color(0xFF6E7FAA),
                                                fontSize: 15.0),
                                            textAlign: TextAlign.left,
                                            decoration: InputDecoration(
                                                hintStyle: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Color(0xFF6E7FAA)),
                                                contentPadding: EdgeInsets.fromLTRB(
                                                    0.0, 15.0, 0.0, 15.0),
                                                border: new UnderlineInputBorder(
                                                    borderSide: new BorderSide(
                                                        color: Colors.red))),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
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
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();

                      Map<String, dynamic> adMap = new HashMap();
                      adMap['current_password'] = _currentPasswordController.text;
                      adMap['new_password'] = _newPasswordController.text;
                      adMap['new_password_confirmation'] = _confirmPasswordController.text;

                      BackendService.crud('put', 'pass', adMap).then((onValue) {
                        print(onValue);
                        if (onValue != null) {
                          showToast("Амжилттай", gravity: Toast.BOTTOM);
                          Navigator.of(context).pop();
                        }
                        else{
                          showToast("Алдаа үүслээ.", gravity: Toast.BOTTOM);
                        }
                      });
                    } else {
                      setState(() {
                        _autovalidate = true;
                      });
                    }
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
                    child: const Text('Хадгалах',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: 1, gravity: gravity);
  }
}
