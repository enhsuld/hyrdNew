import 'dart:collection';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hyrd/screens/login/password/verify_phone_screen.dart';
import 'package:hyrd/screens/login/signUp/step_one_extend.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/utils/fade_route.dart';
import 'package:hyrd/utils/lang.dart';

class PhoneScreen extends StatefulWidget {
  static const routeName = '/sign-up/step-1';

  @override
  PhoneScreenScreenState createState() => PhoneScreenScreenState();
}

class PhoneScreenScreenState extends State<PhoneScreen> {
  String countryCode;

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
                        autovalidate: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 15),
                              child: new CountryCodePicker(
                                onChanged: (code) {
                                  countryCode = code.toString();
                                },
                                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                initialSelection: 'MN',
                                favorite: ['+7', 'MN'],
                                // optional. Shows only country name and flag
                                showCountryOnly: false,
                                // optional. Shows only country name and flag when popup is closed.
                                showOnlyCountryWhenClosed: true,
                                // optional. aligns the flag and the Text left
                                alignLeft: true,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: FormBuilderTextField(
                                attribute: "phone",
                                keyboardType: TextInputType.phone,
                                decoration:
                                    InputDecoration(labelText: "Утасны дугаар"),
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
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 30),
                              child: Text(
                                  "Таны оруулсан дугаарт код илгээж таныг баталгаажуулах болно.",
                                  style: TextStyle(
                                      fontSize: 13, color: Color(0xff6E7FAA))),
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
            Map<String, String> map = new HashMap();
            map["phone"] = _fbKey.currentState.value["phone"];
            if (countryCode != null && countryCode.isNotEmpty)
              map["country_code"] = countryCode;
            BackendService.getVerifyCode(body: map).then((onValue) {
              if (onValue != null) {
                print(onValue);
                Navigator.pop(context);
                Navigator.of(context).push(FadeRoute(
                    builder: (context) => VerifyPhoneScreen(
                          map: map,
                        )));
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
                Text(lang.NEXT.toUpperCase(),
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
          title: Text(lang.FORGET_PASS,
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
}
