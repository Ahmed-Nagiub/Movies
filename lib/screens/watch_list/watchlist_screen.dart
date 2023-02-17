import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/favorites.dart';
import 'package:movies_app/provider/my_provider.dart';
import 'package:movies_app/screens/watch_list/watchlist_item.dart';
import 'package:movies_app/shared/netwoek/remote/firebase_utils.dart';
import 'package:movies_app/shared/styles/theme_app.dart';
import 'package:provider/provider.dart';

class watchListScreen extends StatefulWidget {
  static const String routeName = 'watchlist';

  @override
  State<watchListScreen> createState() => _watchListScreenState();
}

class _watchListScreenState extends State<watchListScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<myProvider>(context);
    return Scaffold(
      backgroundColor: AppStyle.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Watch List ',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: AppStyle.backgroundColor,
        elevation: 0,
        titleSpacing: 10,
        toolbarHeight: 45,
      ),
      body: StreamBuilder<QuerySnapshot<favorites>>(
          stream: getFavoritesMovieFromFireStore(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text(
                "samthing_Has_Error",
                style: TextStyle(color: Colors.white60),
              );
            }
            var favorite = snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
            return favorite.length == 0 ? Center(
              child: Column(
                children: [
                  Icon(Icons.movie_filter_rounded,color: Colors.white70,size: 80,),
                  SizedBox(height: 8,),
                  Text('No Filmes Are Watched ',style: TextStyle(color: Colors.white60,fontSize: 23),)
                ],
              ),
            ):ListView.builder(
              itemCount: favorite.length,
              itemBuilder: (context, index) {
                print(favorite.length);
                return watchlistItem(favorite[index]);
              },
            );
          },
      ),
    );
  }
}