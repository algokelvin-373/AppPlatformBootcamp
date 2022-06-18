import 'package:chopper/chopper.dart';
import 'package:train_api_chopper/model/movie.dart';
import 'package:train_api_chopper/service/api_service.dart';

abstract class MovieService extends ApiService {
  @override
  Type get definitionType => throw UnimplementedError();

  @Get(path: '/3/movie/popular?api_key={apiKey}&language=en-US')
  Future<Response<ListMovie>> getMoviePopular(
      @Query('api_key') String apiKey,
      @Query('language') String lang);

}