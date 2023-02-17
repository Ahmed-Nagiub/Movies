import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/TopSideResponse.dart';
import 'package:movies_app/screens/home/popular_view/popular_item.dart';
import 'package:movies_app/shared/netwoek/remote/api_manager.dart';

class popularViewer extends StatefulWidget {
  @override
  State<popularViewer> createState() => _popularViewerState();
}

class _popularViewerState extends State<popularViewer> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Container(
      height: h*0.35,
      width: double.infinity,
      child: FutureBuilder<TopSideSectionResponse>(
        future: ApiManager.getTopRelated(),
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
          var popular = snapshot.data?.results ?? [];
          print("hereeeee${popular.length}");
           return CarouselSlider.builder(
               itemCount: popular.length,
               itemBuilder: (context, index, realIndex) {
                 return popularItem(popular[index]);
               },
               options: CarouselOptions(
                 height: h * 0.35,
                 aspectRatio: 16 / 9,
                 viewportFraction: 0.9,
                 initialPage: 0,
                 enableInfiniteScroll: true,
                 reverse: false,
                 autoPlay: true,
                 autoPlayInterval: Duration(seconds: 3),
                 autoPlayAnimationDuration: Duration(milliseconds: 800),
                 autoPlayCurve: Curves.fastOutSlowIn,
                 enlargeCenterPage: true,
                 enlargeFactor: 0.3,
                 scrollDirection: Axis.horizontal,
               ));
        },
      ),
    );
  }
}
