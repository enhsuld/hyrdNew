import 'package:flutter/material.dart';
import 'package:hyrd/screens/add_car_screen.dart';
import 'package:hyrd/screens/car_details_screen.dart';
import 'package:hyrd/screens/dashboard_screen.dart';
import 'package:hyrd/screens/home_screen.dart';
import 'package:hyrd/screens/profile_screen.dart';
import 'package:hyrd/screens/search_car_screen.dart';
import 'package:hyrd/screens/total_ad_screen.dart';
import 'package:hyrd/utils/fade_route.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hyrd',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo, fontFamily: 'Roboto'),
      routes: <String, WidgetBuilder>{
        CarDetailsScreen.routeName: (ctx) => CarDetailsScreen(),
        DashboardScreen.routeName: (ctx) => DashboardScreen(),
        SearchCarScreen.routeName: (ctx) => SearchCarScreen(),
        AddCarScreen.routeName: (ctx) => AddCarScreen(),
        TotalAdScreen.routeName: (ctx) => TotalAdScreen(),
        ProfileScreen.routeName: (ctx) => ProfileScreen(),
      },
      home: SplashScreen(
        seconds: 2,
        navigateAfterSeconds: HomeScreen(),
        imageBackground:
        ExactAssetImage('assets/images/splash.png'),
        gradientBackground: new LinearGradient(
            colors: [Colors.cyan, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: () => Navigator.of(context)
            .push(FadeRoute(builder: (context) => HomeScreen())),
        loaderColor: Colors.red,
      ),
    );
  }
}
