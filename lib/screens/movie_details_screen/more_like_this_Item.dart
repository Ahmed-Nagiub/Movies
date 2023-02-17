import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/TopRelatedResponse.dart';
import 'package:movies_app/provider/my_provider.dart';
import 'package:movies_app/shared/styles/theme_app.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/screens/movie_details_screen/movie_details_screen.dart';

class moreLikeThisItem extends StatelessWidget {

  Results results;

  moreLikeThisItem(this.results);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var provider=Provider.of<myProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Stack(
        children: [
          InkWell(
            onTap: (){
              provider.result_ID=results.id!;
              print('id : ${results.id!}');
              Navigator.pushNamed(context, movieDetailsScreen.routeName, arguments: results);
            },
            child: Container(
              width: w * .26,
              height: h * 0.21,
              color: AppStyle.recommendedItemColor,
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: 'https://image.tmdb.org/t/p/original${results.posterPath! ?? ''}',
                    width: w * 0.26,
                    height: h * 0.12,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 18,
                      ),
                      SizedBox(width: 5,),
                      Text(
                        results.voteAverage.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      width: w * .26,
                      height: h / 60,
                      child: Text(
                        results.title!,
                        style: TextStyle(fontSize: 9, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    width: w * .26,
                    height: h / 60,
                    child: Text(
                      results.releaseDate! ?? '',
                      style: TextStyle(fontSize: 8, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Image.asset('assets/images/bookmark.png'),
        ],
      ),
    );
  }
}
