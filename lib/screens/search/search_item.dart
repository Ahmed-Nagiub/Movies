import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies_app/screens/movie_details_screen/movie_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/TopRelatedResponse.dart';
import 'package:movies_app/provider/my_provider.dart';
import 'package:provider/provider.dart';

class SearchItems extends StatelessWidget {

  Results results;
  SearchItems(this.results);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var provider = Provider.of<myProvider>(context);
    return Container(
      width: double.infinity,
      height: h*0.20,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    provider.result_ID = results.id!;
                    Navigator.pushNamed(context, movieDetailsScreen.routeName,
                        arguments: results);
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: CachedNetworkImage(
                              imageUrl: 'https://image.tmdb.org/t/p/original${results.posterPath!}',
                              width: w * 0.26,
                              height: h * 0.12,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: w*0.50,
                                child: Text(
                                  results.title.toString(),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.white,fontSize: 12),
                                ),
                              ),
                              SizedBox(height: 6,),
                              Text(
                                results.releaseDate!.substring(0,4),
                                style: TextStyle(
                                    fontSize: 11, color: Colors.white70),
                              ),
                              SizedBox(height: 6,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 18,
                                  ),
                                  Text(
                                    results.voteAverage.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Image.asset(
              'assets/images/bookmark.png',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Center(
                child: Divider(
                  height: 2,
                  color: Colors.white70,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
