import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/TopRelatedResponse.dart';
import 'package:movies_app/models/favorites.dart';
import 'package:movies_app/provider/my_provider.dart';
import 'package:movies_app/screens/movie_details_screen/more_like_this_view.dart';
import 'package:movies_app/shared/components/ui_utils.dart';
import 'package:movies_app/shared/netwoek/remote/firebase_utils.dart';
import 'package:movies_app/shared/styles/theme_app.dart';
import 'package:provider/provider.dart';

class movieDetailsScreen extends StatefulWidget {
  static const routeName = "movieDetails";

  @override
  State<movieDetailsScreen> createState() => _movieDetailsScreenState();
}

class _movieDetailsScreenState extends State<movieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var provider = Provider.of<myProvider>(context);
    var result = ModalRoute.of(context)?.settings.arguments as Results;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            result.title!,
          style: TextStyle(
            fontSize: 14
          ),
        ),
        backgroundColor: AppStyle.backgroundColor,
        elevation: 0.0,
      ),
      body: Container(
        width: double.infinity,
        color: AppStyle.backgroundColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              'https://image.tmdb.org/t/p/original${result.backdropPath!}',
                          width: double.infinity,
                          height: h * 0.22,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            result.title!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            result.releaseDate!,
                            style: TextStyle(color: Colors.white, fontSize: 9),
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
                ],
              ),
              SizedBox(height: 10,),
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Container(
                            width: w * .28,
                            height: h * 0.20,
                            child: CachedNetworkImage(
                              imageUrl:
                              'https://image.tmdb.org/t/p/original${result.posterPath!}',
                              width: double.infinity,
                              height: h * 0.19,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ),
                          Image.asset('assets/images/bookmark.png'),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: w * 0.60,
                          child: Text(
                            result.overview!,
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 9,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(height: 4,),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 22,
                            ),
                            SizedBox(width: 3,),
                            Text(
                              result.voteAverage.toString(),
                              style: TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.black87,
                              shadowColor: Colors.grey,
                              animationDuration: Duration(seconds: 1)),
                          onPressed: () {
                            favorites favorite = favorites(
                                movie_id: result.id ?? 0,
                                movieName: result.title ?? "",
                                backdropPath: result.backdropPath ?? '',
                                voteAverage: result.voteAverage ?? 0,
                                releaseDate: result.releaseDate ?? '',
                                isFavorite: true);
                            provider.fav = favorite.isFavorite;
                            showMassage(
                               context, "Film is Add to Watch List", "OK",
                                    () {
                                 hideMassage(context);
                                });
                            addFavoritesMovieToFireStore(favorite)
                                .then((value) => (value) {})
                                .catchError((error) {
                              print(error);
                              //hideMassage(context);
                            });
                          },
                          child: Row(
                            children: [
                              Text(
                                'Add To Watch List ',
                                style: TextStyle(
                                    color: Colors.orange, fontSize: 12),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Icon(
                                Icons.featured_play_list_rounded,
                                color: Colors.orange,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              moreLikeThisView(),
            ],
          ),
        ),
      ),
    );
  }
}
