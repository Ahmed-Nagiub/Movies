import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/TopRelatedResponse.dart';
import 'package:movies_app/provider/my_provider.dart';
import 'package:movies_app/screens/movie_details_screen/movie_details_screen.dart';
import 'package:provider/provider.dart';



class popularItem extends StatelessWidget {

  Results results;

  popularItem(this.results);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var provider = Provider.of<myProvider>(context);
    return SingleChildScrollView(
      child: Stack(
        children: [
          InkWell(
            onTap: (){
              provider.result_ID = results.id!;
              Navigator.pushNamed(context, movieDetailsScreen.routeName,arguments: results);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/original${results.backdropPath!}',
                  width: double.infinity,
                  height: h * 0.22,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 115),
                  child: Text(
                    results.title!,
                    style: TextStyle(
                        color: Colors.white, fontSize: 17,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 120),
                  child: Text(
                    results.releaseDate!,
                    style: TextStyle(
                        color: Colors.white, fontSize: 9
                    ),
                  ),
                ),

              ],
            ),
          ),
          Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 55.0),
                child: Icon(
                  Icons.play_circle,
                  color: Colors.white,
                  size: 60,
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 10,top: 120),
            child: Stack(
              children: [
                Container(
                  width: w * .26,
                  height: h * 0.18,
                  child: CachedNetworkImage(
                    imageUrl: 'https://image.tmdb.org/t/p/original${results.posterPath!}',
                    width: double.infinity,
                    height: h * 0.22,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Image.asset('assets/images/bookmark.png')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
