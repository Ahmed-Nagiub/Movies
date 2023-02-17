import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:movies_app/models/BrowseResponse.dart';
import 'package:movies_app/models/MoreLikeThisResponse.dart';
import 'package:movies_app/models/MoviesResponse.dart';
import 'package:movies_app/models/NewReleasesResponse.dart';
import 'package:movies_app/models/SearchResponse.dart';
import 'package:movies_app/models/TopRelatedResponse.dart';
import 'dart:convert';
import '../../../models/TopSideResponse.dart';
import '../../components/constants.dart';

class ApiManager {

  static Future<TopSideSectionResponse> getTopRelated() async {
    // /3/movie/popular
    Uri URL = Uri.https(BASE, '/3/movie/popular', {
      'api_key': APIKEY,
      // 'imdb_id': imdb_id,
    });
    Response top = await http.get(URL);
    try {
      var json = jsonDecode(top.body);
      TopSideSectionResponse topSide = TopSideSectionResponse.fromJson(json);
      return topSide;
    } catch (e) {
      print('erorrrr:::$e');
      throw e;
    }
  }

  static Future<NewReleases> gotNewReleases() async {
    Uri URL = Uri.https(BASE, '/3/movie/upcoming', {
      'api_key': APIKEY,
    });
    Response release = await http.get(URL);
    try {
      var json = jsonDecode(release.body);
      NewReleases newRelease = NewReleases.fromJson(json);
      return newRelease;
    } catch (e) {
      print('erorrrr:::$e');
      throw e;
    }
  }

  static Future<TopRelated> gotTopRated() async {
    Uri URL = Uri.https(BASE, '/3/movie/top_rated', {
      'api_key': APIKEY,
    });
    Response top_rated = await http.get(URL);
    try {
      var json = jsonDecode(top_rated.body);
      TopRelated topRelated = TopRelated.fromJson(json);
      return topRelated;
    } catch (e) {
      print('erorrrr:::$e');
      throw e;
    }
  }

  static Future<MoreLikeThisResponse> getMoreLikeThis(num Movie_ID)async{
    Uri URL=Uri.https(BASE,'/3/movie/${Movie_ID.toString()}/similar',{
      'api_key':APIKEY,
    });
    Response more=await http.get(URL);
    try{
      var json=jsonDecode(more.body);
      MoreLikeThisResponse moreLikeThis=MoreLikeThisResponse.fromJson(json);
      return moreLikeThis;
    }
    catch(e){
      print(e);
      throw e;
    }

  }

  static Future<SearchModel> getSearch(String query)async{
    Uri URL=Uri.https(BASE,'/3/search/movie',{
      'api_key':APIKEY,
      'query':query,
    });
    Response search=await http.get(URL);
    try{
      var json=jsonDecode(search.body);
      SearchModel searchModel=SearchModel.fromJson(json);
      return searchModel;
    }
    catch(e){
      print(e);
      throw e;
    }
  }
  
  static Future<BrowseResponse> getBrowseCategory()async{
    Uri URL=Uri.https(BASE,'/3/genre/movie/list',{
      'api_key':APIKEY,
    });
    Response movieList = await http.get(URL);
    try{
      var json=jsonDecode(movieList.body);
      BrowseResponse browseResponse = BrowseResponse.fromJson(json);
      return browseResponse;
    }
    catch(e){
      print(e);
      throw e;
    }
  }

  static Future<Movies> getMoviesByList(num genreId) async {
    var response = await http.get(
      Uri.parse("https://$BASE/3/discover/movie?api_key=$APIKEY&adult=false&language=en-US&with_genres=$genreId"),
    );
    var movieResponse = Movies.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return movieResponse;
    } else {
      throw Exception('Failed to load album');
    }
  }

}
