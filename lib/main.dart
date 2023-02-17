import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/layout/home_layout.dart';
import 'package:movies_app/layout/splash/splash_screen.dart';
import 'package:movies_app/provider/my_provider.dart';
import 'package:movies_app/screens/browse/browse_category%20_screen.dart';
import 'package:movies_app/screens/home/home_screen.dart';
import 'package:movies_app/screens/movie_details_screen/movie_details_screen.dart';
import 'package:movies_app/screens/watch_list/watchlist_screen.dart';
import 'package:movies_app/shared/styles/theme_app.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (context) => myProvider(),
      child: MyApp()));
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
        HomeLayout.routeName : (c)=> HomeLayout(),
        movieDetailsScreen.routeName : (c)=> movieDetailsScreen(),
        browseCategoryScreen.routeName : (c)=> browseCategoryScreen(),
        watchListScreen.routeName : (c)=> watchListScreen(),
      },
      theme: AppStyle.lightTheme,
    );
  }
}
