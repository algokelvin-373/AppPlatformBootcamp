import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class ListMovie {
  @JsonKey(name: 'results') List<Movie?>? data;

  ListMovie({
    this.data
  });

  factory ListMovie.fromJson(Map<String, dynamic> json) => _$ListMovieFromJson(json);

  Map<String, dynamic> toJson() => _$ListMovieToJson(this);

}

@JsonSerializable()
class Movie {
  @JsonKey(name: 'id') int? id;
  @JsonKey(name: 'title') String? title;
  @JsonKey(name: 'overview') String? overview;
  @JsonKey(name: 'release_date') String? date;
  @JsonKey(name: 'poster_path') String? poster;
  @JsonKey(name: 'backdrop_path') String? backdrop;
  @JsonKey(name: 'vote_average') int? average;
  @JsonKey(name: 'vote_count') int? count;

  Movie({
    this.id,
    this.title,
    this.overview,
    this.date,
    this.poster,
    this.backdrop,
    this.average,
    this.count
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);

}
