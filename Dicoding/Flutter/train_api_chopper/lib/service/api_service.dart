import 'package:chopper/chopper.dart';

import '../utils/model_converter.dart';

part 'api_service_chopper.dart';

@ChopperApi()
abstract class ApiService extends ChopperService {

  static ApiService create(String url) {
    final client = ChopperClient(
      baseUrl: 'https://api.themoviedb.org/',
      services: [
        _$ApiService(),
      ],
      interceptors: [HttpLoggingInterceptor()],
      converter: ModelConverter(),
      errorConverter: const JsonConverter(),
    );

    return _$ApiService(client);
  }

}