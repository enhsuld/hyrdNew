import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hyrd/models/car_model.dart';

class TabAddressScreen extends StatefulWidget {
  static const routeName = '/tab-address-screen';

  final CarModel item;

  TabAddressScreen({Key key, @required this.item}) : super(key: key);

  @override
  _TabAddressScreenState createState() => _TabAddressScreenState();
}

class _TabAddressScreenState extends State<TabAddressScreen> {
  Completer<GoogleMapController> _controller = Completer();
  double screenSize;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child:  Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width - 30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text("Бидний тухай", style: TextStyle(fontSize: 16,color: Color(0xFF222455)),textAlign: TextAlign.left),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10,left: 20),
                        child: Text(widget.item.user.org.about, style: TextStyle(fontSize: 12,color: Color(0xFF6E7FAA)),textAlign: TextAlign.left),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text("Ажлын цаг:", style: TextStyle(fontSize: 16,color: Color(0xFF222455)),textAlign: TextAlign.left),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10,left: 20),
                        child: Text(widget.item.user.org.workHours, style: TextStyle(fontSize: 12,color: Color(0xFF6E7FAA)),textAlign: TextAlign.left),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text("Цахим шуудан:", style: TextStyle(fontSize: 16,color: Color(0xFF222455)),textAlign: TextAlign.left),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10,left: 20),
                        child: Text(widget.item.user.org.email, style: TextStyle(fontSize: 12,color: Color(0xFF6E7FAA)),textAlign: TextAlign.left),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text("Веб сайт:", style: TextStyle(fontSize: 16,color: Color(0xFF222455)),textAlign: TextAlign.left),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10,left: 20),
                        child: Text(widget.item.user.org.website, style: TextStyle(fontSize: 12,color: Color(0xFF6E7FAA)),textAlign: TextAlign.left),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text("Холбогдох утас:", style: TextStyle(fontSize: 16,color: Color(0xFF222455)),textAlign: TextAlign.left),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10,left: 20),
                        child: Text(widget.item.user.org.phone, style: TextStyle(fontSize: 12,color: Color(0xFF6E7FAA)),textAlign: TextAlign.left),
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
                  width: MediaQuery.of(context).size.width - 30,
                  child: _buildGoogleMap(context),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(40.712776, -74.005974), zoom: zoomVal)));
  }
  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(40.712776, -74.005974), zoom: zoomVal)));
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:  CameraPosition(target: LatLng(40.712776, -74.005974), zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {newyork1Marker,newyork2Marker,newyork3Marker,gramercyMarker,bernardinMarker,blueMarker},
      ),
    );
  }

}
Marker gramercyMarker = Marker(
  markerId: MarkerId('gramercy'),
  position: LatLng(40.738380, -73.988426),
  infoWindow: InfoWindow(title: 'Gramercy Tavern'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

Marker bernardinMarker = Marker(
  markerId: MarkerId('bernardin'),
  position: LatLng(40.761421, -73.981667),
  infoWindow: InfoWindow(title: 'Le Bernardin'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker blueMarker = Marker(
  markerId: MarkerId('bluehill'),
  position: LatLng(40.732128, -73.999619),
  infoWindow: InfoWindow(title: 'Blue Hill'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

//New York Marker

Marker newyork1Marker = Marker(
  markerId: MarkerId('newyork1'),
  position: LatLng(40.742451, -74.005959),
  infoWindow: InfoWindow(title: 'Los Tacos'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker newyork2Marker = Marker(
  markerId: MarkerId('newyork2'),
  position: LatLng(40.729640, -73.983510),
  infoWindow: InfoWindow(title: 'Tree Bistro'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker newyork3Marker = Marker(
  markerId: MarkerId('newyork3'),
  position: LatLng(40.719109, -74.000183),
  infoWindow: InfoWindow(title: 'Le Coucou'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);