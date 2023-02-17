import 'package:flutter/material.dart';
import 'package:movies_app/models/NewReleasesResponse.dart';
import 'package:movies_app/screens/home/new_releases/new_releases_item.dart';
import 'package:movies_app/shared/netwoek/remote/api_manager.dart';
import 'package:movies_app/shared/styles/theme_app.dart';

class newReleasesView extends StatefulWidget {

  @override
  State<newReleasesView> createState() => _newReleasesViewState();
}

class _newReleasesViewState extends State<newReleasesView> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Container(
      height: h*0.25,
      width: double.infinity,
      color: AppStyle.grayColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
                "New Releases",
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
          FutureBuilder<NewReleases>(
            future: ApiManager.gotNewReleases(),
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
              var newRelease = snapshot.data?.results ?? [];
              print("hereeeee${newRelease.length}");
              return Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: newRelease.length,
                    itemBuilder: (context, index) {
                      return newReleasesItem(newRelease[index]);
                    },),
              );
            },
          ),
        ],
      ),
    );
  }
}
