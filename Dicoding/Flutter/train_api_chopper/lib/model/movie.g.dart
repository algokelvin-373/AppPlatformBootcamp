// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListMovie _$ListMovieFromJson(Map<String, dynamic> json) {
  return ListMovie(
    results: (json['results'] as List<dynamic>)
        .map((e) => Movie.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ListMovieToJson(ListMovie instance) => <String, dynamic>{
      'results': instance.results,
    };

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie(
    id: json['id'] as int,
    title: json['title'] as String,
    overview: json['overview'] as String,
    date: json['release_date'] as String,
    poster: json['poster_path'] as String,
    backdrop: json['backdrop_path'] as String,
    average: (json['vote_average'] as num).toDouble(),
    count: (json['vote_count'] as num).toDouble(),
  );
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'overview': instance.overview,
      'release_date': instance.date,
      'poster_path': instance.poster,
      'backdrop_path': instance.backdrop,
      'vote_average': instance.average,
      'vote_count': instance.count,
    };
