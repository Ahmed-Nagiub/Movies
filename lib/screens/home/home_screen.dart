import 'package:flutter/material.dart';
import 'package:movies_app/screens/home/new_releases/new_releases_view.dart';
import 'package:movies_app/screens/home/popular_view/popular_viewer.dart';
import 'package:movies_app/screens/home/recommended/recommended_view.dart';

import 'package:movies_app/shared/styles/theme_app.dart';


class HomeScreen extends StatelessWidget {

  static const String routeName = "home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            popularViewer(),
            SizedBox(height: 10,),
            newReleasesView(),
            SizedBox(height: 15,),
            recommendedView(),
          ],
        ),
      ),
    );
  }
}
