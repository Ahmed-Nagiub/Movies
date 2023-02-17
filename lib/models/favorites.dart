class favorites {
  String id;
  num movie_id;
  bool isFavorite;
  String movieName;
  String backdropPath;
  num voteAverage;
  String releaseDate;

  favorites({
    this.id = '',
    this.isFavorite=false ,
    required this.movie_id,
    required this.movieName,
    required this.backdropPath,
    required this.voteAverage,
    required this.releaseDate,
  });

  favorites.fromJson(Map<String, dynamic> json)
      : this(
    id: json['id'],
    movie_id: json['movie_id'],
    isFavorite: json['isFavorite'],
    movieName: json['movieName'],
    backdropPath: json['backdropPath'],
    voteAverage: json['voteAverage'],
    releaseDate: json['releaseDate'],
  );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "movie_id": movie_id,
      "isFavorite": isFavorite,
      "movieName": movieName,
      "backdropPath": backdropPath,
      "voteAverage": voteAverage,
      "releaseDate": releaseDate,
    };
  }

}