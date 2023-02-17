import 'package:flutter/material.dart';
import 'package:movies_app/models/MoreLikeThisResponse.dart';
import 'package:movies_app/provider/my_provider.dart';
import 'package:movies_app/screens/movie_details_screen/more_like_this_Item.dart';
import 'package:movies_app/shared/netwoek/remote/api_manager.dart';
import 'package:movies_app/shared/styles/theme_app.dart';
import 'package:provider/provider.dart';

class moreLikeThisView extends StatefulWidget {

  @override
  State<moreLikeThisView> createState() => _moreLikeThisViewState();
}

class _moreLikeThisViewState extends State<moreLikeThisView> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var provider = Provider.of<myProvider>(context);
    return Container(
      height: h * 0.29,
      width: double.infinity,
      color: AppStyle.grayColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              "More Like This",
              style: TextStyle(
                  color: Colors.white
              ),
            ),
          ),
          FutureBuilder<MoreLikeThisResponse>(
            future: ApiManager.getMoreLikeThis(provider.result_ID),
            builder: (context, snapshot) {
              print('123456${provider.result_ID}');
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
                          setState(() {

                          });
                          print(snapshot.error);
                        },
                        child: Text('Try Again'),
                      ),
                    ],
                  ),
                );
              }
              var moreLikeThis = snapshot.data?.results ?? [];
              print('hghguuieu${moreLikeThis.length}');
              return Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: moreLikeThis.length,
                  itemBuilder: (context, index) {
                    return moreLikeThisItem(moreLikeThis[index]);
                  },),
              );
            },
          ),
        ],
      ),
    );
  }
}
