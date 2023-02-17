import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/TopRelatedResponse.dart';
import 'package:movies_app/models/favorites.dart';
import 'package:movies_app/provider/my_provider.dart';
import 'package:movies_app/shared/netwoek/remote/firebase_utils.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/screens/movie_details_screen/movie_details_screen.dart';

class newReleasesItem extends StatelessWidget {

  Results results;
  newReleasesItem(this.results);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var provider = Provider.of<myProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Stack(
        children: [
          InkWell(
            onTap: (){
              provider.result_ID = results.id!;
              Navigator.pushNamed(context, movieDetailsScreen.routeName,arguments: results);
            },
            child: Container(
              width: w * .26,
              height: h * 0.18,
              child: CachedNetworkImage(
                imageUrl: 'https://image.tmdb.org/t/p/original${results.posterPath!}',
                width: w * 0.26,
                height: h * 0.17,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          InkWell(
              onTap: (){
                favorites fav = favorites(
                    movie_id: results.id!,
                    movieName: results.title!,
                    backdropPath: results.posterPath!,
                    voteAverage: results.voteAverage!,
                    releaseDate: results.releaseDate!
                );
                addFavoritesMovieToFireStore(fav);
              },
              child: Image.asset('assets/images/bookmark.png')),
        ],
      ),
    );
  }
}
