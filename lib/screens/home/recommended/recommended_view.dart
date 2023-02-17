import 'package:flutter/material.dart';
import 'package:movies_app/models/NewReleasesResponse.dart';
import 'package:movies_app/models/TopRelatedResponse.dart';
import 'package:movies_app/screens/home/recommended/recommended_item.dart';
import 'package:movies_app/shared/netwoek/remote/api_manager.dart';
import 'package:movies_app/shared/styles/theme_app.dart';

class recommendedView extends StatefulWidget {

  @override
  State<recommendedView> createState() => _recommendedViewState();
}

class _recommendedViewState extends State<recommendedView> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Container(
      height: h*0.29,
      width: double.infinity,
      color: AppStyle.grayColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              "Recommended",
              style: TextStyle(
                  color: Colors.white
              ),
            ),
          ),
          FutureBuilder<TopRelated>(
            future: ApiManager.gotTopRated(),
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
              var topRelated = snapshot.data?.results ?? [];
              print("hereeeee${topRelated.length}");
              return Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: topRelated.length,
                  itemBuilder: (context, index) {
                    return recommendedItem(topRelated[index]);
                  },),
              );
            },
          ),
        ],
      ),
    );
  }
}
