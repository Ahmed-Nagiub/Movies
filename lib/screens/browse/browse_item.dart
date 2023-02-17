import 'package:flutter/material.dart';
import 'package:movies_app/models/BrowseResponse.dart';
import 'package:movies_app/provider/my_provider.dart';
import 'package:movies_app/shared/styles/theme_app.dart';
import 'package:movies_app/screens/browse/browse_category%20_screen.dart';
import 'package:provider/provider.dart';

class MovieCategories extends StatelessWidget {

  Genres genres;
  MovieCategories(this.genres);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<myProvider>(context);
    return InkWell(
      onTap: (){
        provider.result_ID=genres.id!;
        Navigator.pushNamed(context, browseCategoryScreen.routeName , arguments: genres);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppStyle.itemBackColor,
        ),
        child: Stack(
          children:[
            Image.asset(
              fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                genres.name == "Action" ? 'assets/images/Action.webp' :
                genres.name == 'Adventure' ? 'assets/images/adventure.jpg' :
                genres.name == 'Animation' ? 'assets/images/animation.webp' :
                genres.name == 'Comedy' ? 'assets/images/comedy.jpg' :
                genres.name == 'Crime' ? 'assets/images/crime.jpg' :
                genres.name == 'Documentary' ? 'assets/images/Documentary.webp' :
                genres.name == 'Drama' ? 'assets/images/Drama.jpg' :
                genres.name == 'Family' ? 'assets/images/Family.jpg' :
                genres.name == 'Fantasy' ? 'assets/images/Fantasy.png' :
                genres.name == 'History' ? 'assets/images/History.png' :
                genres.name == 'Horror' ? 'assets/images/Horror.webp' :
                genres.name == 'Music' ? 'assets/images/Music.webp' :
                genres.name == 'Mystery' ? 'assets/images/Mystery.jpg' :
                genres.name == 'Romance' ? 'assets/images/Romance.jpg' :
                genres.name == 'Science Fiction' ? 'assets/images/Science Fiction.jpg' :
                genres.name == 'TV Movie' ? 'assets/images/TV Movie.jpg' :
                genres.name == 'Thriller' ? 'assets/images/Thriller.jpg' :
                genres.name == 'War' ? 'assets/images/War.webp' :
                genres.name == 'Western' ? 'assets/images/Western.webp' :''
            ),
            Center(
              child: Text(
                genres.name!,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
