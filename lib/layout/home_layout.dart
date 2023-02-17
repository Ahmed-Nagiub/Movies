import 'package:flutter/material.dart';
import 'package:movies_app/screens/browse/browse_item.dart';
import 'package:movies_app/screens/home/home_screen.dart';
import 'package:movies_app/screens/search/search_screen.dart';
import 'package:movies_app/screens/watch_list/watchlist_screen.dart';

import '../screens/browse/browse_screen.dart';

class HomeLayout extends StatefulWidget {

  static const String routeName = "HomeLayout";

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
          onTap: (index) {
            currentIndex=index;
            setState(() {});
          },
          currentIndex: currentIndex,
          items:  [
            BottomNavigationBarItem(label: "Home",
                icon: Image(image:
                AssetImage(
                  currentIndex == 0 ? "assets/images/Home_icon.png" : "assets/images/Home.png",
                ),),
            ),
            BottomNavigationBarItem(label: "Search",
                icon: Image(image: AssetImage(
                    currentIndex == 1 ? "assets/images/search_icon.png" : "assets/images/search.png"
                ),),
            ),
            BottomNavigationBarItem(
                label: "Browse",
                icon: Image(image: AssetImage(
                   currentIndex == 2 ? "assets/images/browse_icon.png" : "assets/images/browse.png"
                ),),
            ),
            BottomNavigationBarItem(
                label: "Watchlist",
                icon: Image(
                  image: AssetImage(
                     currentIndex == 3 ? "assets/images/watchlist_icon.png" : "assets/images/watchlist.png"
                  ),),
            ),
          ],
      ),
    );
  }

  List<Widget> tabs=[
    HomeScreen(),
    SearchScreen(),
    browseScreen(),
    watchListScreen()
  ];
}
