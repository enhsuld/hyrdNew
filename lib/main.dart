import 'package:flutter/material.dart';
import 'package:hyrd/screens/add_car_screen.dart';
import 'package:hyrd/screens/dashboard_screen.dart';
import 'package:hyrd/screens/login/login_screen.dart';
import 'package:hyrd/screens/movie_details_screen.dart';
import 'package:hyrd/screens/profile_screen.dart';
import 'package:hyrd/screens/search_car_screen.dart';
import 'package:hyrd/screens/total_ad_screen.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hyrd',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Gilroy'
      ),
      routes: <String, WidgetBuilder>{
        MovieDetailsScreen.routeName: (ctx) => MovieDetailsScreen(),
        DashboardScreen.routeName: (ctx) => DashboardScreen(),
        SearchCarScreen.routeName: (ctx) => SearchCarScreen(),
        AddCarScreen.routeName: (ctx) => AddCarScreen(),
        TotalAdScreen.routeName: (ctx) => TotalAdScreen(),
        ProfileScreen.routeName: (ctx) => ProfileScreen(),
      },
      home: LoginScreen(),
    );
  }
}