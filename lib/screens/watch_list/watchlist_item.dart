import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/favorites.dart';
import 'package:movies_app/provider/my_provider.dart';
import 'package:movies_app/shared/netwoek/remote/firebase_utils.dart';
import 'package:provider/provider.dart';

class watchlistItem extends StatefulWidget {

  favorites favorite;

  watchlistItem(this.favorite);

  @override
  State<watchlistItem> createState() => _watchlistItemState();
}

class _watchlistItemState extends State<watchlistItem> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      height: h*0.23,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child:CachedNetworkImage(
                            imageUrl: 'https://image.tmdb.org/t/p/original${widget.favorite.backdropPath??''}',
                            width: w * .40,
                            height: h * 0.15,
                            fit:BoxFit.cover,
                            imageBuilder: (context, imageProvider) =>
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: w*0.40,
                                child: Text(
                                  widget.favorite.movieName.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(height: 6,),
                              Text(
                                widget.favorite.releaseDate??'',
                                style: TextStyle(
                                    fontSize: 11, color: Colors.white70),
                              ),
                              SizedBox(height: 6,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 18,
                                  ),
                                  Text(
                                    widget.favorite.voteAverage.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        deleteFavoritesMovieFromFirestore(widget.favorite.id);
                        setState(() {
                        });
                      },
                      child: widget.favorite.isFavorite
                          ? Image.asset(
                        'assets/images/bookmarkyellow.png',
                      )
                          : Image.asset(
                        'assets/images/bookmark.png',
                      ),
                    )
                  ],
                ),

              ],
            ),
            SizedBox(height: 3,),
            Divider(
              height: 2,
              color: Colors.white70,
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}
