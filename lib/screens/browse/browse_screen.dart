import 'package:flutter/material.dart';
import 'package:movies_app/models/BrowseResponse.dart';
import 'package:movies_app/screens/browse/browse_item.dart';
import 'package:movies_app/shared/netwoek/remote/api_manager.dart';

class browseScreen extends StatelessWidget {

  List<Genres> genres = [];
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 40),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text(
                'Browse Category',
                 style: TextStyle(
                   fontSize: 20,
                   color: Colors.white,
                   fontWeight: FontWeight.bold
                 ),
            ),
             ),
            FutureBuilder<BrowseResponse>(
                future: ApiManager.getBrowseCategory(),
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
                  var browseMovie = snapshot.data?.genres ?? [];
                  return Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.all(8),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: browseMovie.length,
                      itemBuilder: (context, index) {
                        return MovieCategories(browseMovie[index]);
                      },
                    ),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
 
}