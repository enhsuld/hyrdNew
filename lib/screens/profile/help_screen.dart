import 'package:flutter/material.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/models/help_model.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/widget/vertical_follower_item.dart';
import 'package:hyrd/widget/vertical_help_item.dart';

class HelpScreen extends StatefulWidget {
  static const routeName = '/help';

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {

  var helps=new List<HelpModel>();

  @override
  void initState() {
    BackendService.getHelps().then((data) {
      setState(() {
        this.helps=data;
      });
    });

    super.initState();
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
          title: Text("Тусламж",
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          elevation: 0.0,
        ),
        body: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                FutureBuilder(
                  future: BackendService.getHelps(),
                  builder: (context, snapshot) {
                    List<dynamic> lists;
                    if (snapshot.hasData) {
                      lists = snapshot.data;
                      return Container(
                        height: double.parse(lists.length.toString()) * 110,
                        padding: EdgeInsets.only(
                            bottom: 20, top: 0, left: 10, right: 10),
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: 0, bottom: 0),
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: lists.length,
                          itemBuilder: (ctx, i) => VerticalHelpItem(
                            index: i,
                            item: HelpModel.fromJson(lists[i]),
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),

                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child:  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text("Холбогдох утас:", style: TextStyle(fontSize: 16,color: Color(0xFF222455)),textAlign: TextAlign.left),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text("(+976) 89951555", style: TextStyle(fontSize: 12,color: Color(0xFF6E7FAA)),textAlign: TextAlign.left),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child:  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text("Хаяг:", style: TextStyle(fontSize: 16,color: Color(0xFF222455)),textAlign: TextAlign.left),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text("'Таван Богд' ХХК-н Toyota төв, 1-р Олимпийн гудамж, Сүхбаатаатар дүүрэг, Улаанбаатар хот, Монгол улс (0.73 mi) Ulaanbaatar, Mongolia", style: TextStyle(fontSize: 12,color: Color(0xFF6E7FAA)),textAlign: TextAlign.left),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child:  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text("Цахим шуудан:", style: TextStyle(fontSize: 16,color: Color(0xFF222455)),textAlign: TextAlign.left),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text("info@jmtech.mn", style: TextStyle(fontSize: 12,color: Color(0xFF6E7FAA)),textAlign: TextAlign.left),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
        )
    );
  }

}
