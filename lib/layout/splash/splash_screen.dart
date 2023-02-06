import 'dart:async';
import 'package:flutter/material.dart';
import '../../screens/home/home_screen.dart';

class SplashScreen extends StatelessWidget {

  static const String routeName="Spalsh";

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });
    return Scaffold(
      backgroundColor: Colors.black,
      body: Image.asset('assets/images/splash_screen.png',
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}

