import 'package:flutter/material.dart';
import 'package:movies_app/layout/splash/splash_screen.dart';
import 'package:movies_app/screens/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Movies App",
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName : (c)=> SplashScreen(),
        HomeScreen.routeName : (c)=> HomeScreen(),
      },
    );
  }
}
