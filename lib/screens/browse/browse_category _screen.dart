import 'package:flutter/material.dart';
import 'package:movies_app/models/BrowseResponse.dart';
import 'package:movies_app/models/MoviesResponse.dart';
import 'package:movies_app/models/TopRelatedResponse.dart';
import 'package:movies_app/screens/search/search_item.dart';
import 'package:movies_app/shared/netwoek/remote/api_manager.dart';
import 'package:movies_app/shared/styles/theme_app.dart';

class browseCategoryScreen extends StatefulWidget {
  static const String routeName = "browseCategoryScreen";

  @override
  State<browseCategoryScreen> createState() => _browseCategoryScreenState();
}

class _browseCategoryScreenState extends State<browseCategoryScreen> {
  List<Results> searchList = [];
  Genres genres = Genres();

  @override
  Widget build(BuildContext context) {
    var genre = ModalRoute.of(context)?.settings.arguments as Genres;
    return Scaffold(
      backgroundColor: AppStyle.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 45),
        child: Column(
          children: [
            FutureBuilder<Movies>(
                future: ApiManager.getMoviesByList(genre.id!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        children: [
                          Text('Something Went Wrong'),
                          TextButton(
                            onPressed: () {
                              print(snapshot.error);
                            },
                            child: Text('Try Again'),
                          ),
                        ],
                      ),
                    );
                  }
                  var browseMovie = snapshot.data?.results ?? [];
                  print('hghguuieu${browseMovie.length}');
                  return Expanded(
                    child: ListView.builder(
                      itemCount: browseMovie.length,
                      itemBuilder: (context, index) {
                        return SearchItems(browseMovie[index]);
                      },),
                  );
                },)
          ],
        ),
      ),
    );
  }

}
