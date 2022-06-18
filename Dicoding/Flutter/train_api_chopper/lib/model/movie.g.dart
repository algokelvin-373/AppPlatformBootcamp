part of 'movie.dart';

ListMovie _$ListMovieFromJson(Map<String, dynamic> json) {
  return ListMovie(
    data: (json['results'] as List<Movie>)
        .map((e) => e == null ? null : Movie.fromJson(e))
        .toList()
  );
}

Map<String, dynamic> _$ListMovieToJson(ListMovie listMovie) => <String, dynamic> {
  'results': listMovie.data,
};

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie(
    id: json['id'] as int,
    title: json['title'] as String,
    overview: json['overview'] as String,
    date: json['date'] as String,
    poster: json['poster_path'] as String,
    backdrop: json['backdrop_path'] as String,
    average: json['vote_average'] as int,
    count: json['vote_count'] as int,
  );
}

Map<String, dynamic> _$MovieToJson(Movie movie) => <String, dynamic> {
  'id': movie.id,
  'title': movie.title,
  'overview': movie.overview,
  'date': movie.date,
  'poster_path': movie.poster,
  'backdrop_path': movie.backdrop,
  'vote_average': movie.average,
  'vote_count': movie.count,
};