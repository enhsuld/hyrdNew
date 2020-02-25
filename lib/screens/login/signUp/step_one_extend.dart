import 'package:flutter/material.dart';
import 'package:hyrd/screens/login/signUp/step_two.dart';
import 'package:hyrd/utils/fade_route.dart';

class StepOneExtendScreen extends StatefulWidget {
  static const routeName = '/sign-up/step-1-1';

  @override
  _StepOneExtendScreenState createState() => _StepOneExtendScreenState();
}

class _StepOneExtendScreenState extends State<StepOneExtendScreen> {

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
          Navigator.of(context).push(FadeRoute(builder: (context) => StepTwoScreen()));
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

  TextStyle style = TextStyle(fontFamily: 'Roboto', color: Colors.white, fontSize: 15.0);

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
                  Column(
                    children: <Widget>[
                      SizedBox(height: 50),
                      Text("Баталгаажуулах код".toUpperCase(), style: style.copyWith(color: Color(0xff222455), fontFamily: 'Roboto',fontWeight: FontWeight.w700, fontSize: 21)),
                      SizedBox(height: 30),
                      Text("Илгээсэн баталгаажуулах кодыг оруулна уу",style: style.copyWith(color: Color(0xff6E7FAA), fontSize: 14)),
                      SizedBox(height: 20),
                      Text("Mongolia (+976) 89951555",style: style.copyWith(color: Color(0xff6E7FAA), fontSize: 14)),
                      SizedBox(height: 40),
                     /* PinFieldAutoFill(
                          codeLength:4
                      ),*/
                      SizedBox(height: 40),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Та',
                          style: style.copyWith(color: Color(0xff6E7FAA), fontSize: 14),
                          children: <TextSpan>[

                            TextSpan(
                              text: ' 30 ',
                              style: TextStyle(
                                color: Color(0xff5F4CE0),
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.wavy,
                              ),
                            ),
                            TextSpan(text: 'секундын дотор кодыг бөглөх \n\n ёстойг анхаарна уу'),
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
      )
    );
  }
}
