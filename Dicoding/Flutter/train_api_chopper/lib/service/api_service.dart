import 'package:chopper/chopper.dart';
import 'package:train_api_chopper/model/movie.dart';

import '../utils/model_converter.dart';

part 'api_service_chopper.dart';

@ChopperApi()
abstract class ApiService extends ChopperService {

  static ApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://api.themoviedb.org/3',
      interceptors: [HttpLoggingInterceptor()],
      converter: ModelConverter(),
      errorConverter: JsonConverter(),
      services: [
        _$ApiService(),
      ],
    );

    return _$ApiService(client);
  }

  @Get(path: 'movie/popular')
  Future<Response<ListMovie>> getMoviePopular(
      @Query('api_key') String apiKey,
      @Query('language') String lang);

}