import 'package:movies_app/models/TopRelatedResponse.dart';

class Movies {
  int? page;
  List<Results>? results;
  bool? success;
  String? message;
//
  Movies.fromJson(Map<String, dynamic> json) {
    page = json["page"];
    success = json["success"];
    message = json["status_message"];
    if (json["results"] != null) {
      results = [];
      json["results"].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
  }
}