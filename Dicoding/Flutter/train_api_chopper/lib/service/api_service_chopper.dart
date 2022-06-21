part of 'api_service.dart';

class _$ApiService extends ApiService {

  _$ApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  Type get definitionType => ApiService;

  @override
  Future<Response<String>> getMoviePopular(String apiKey, String lang) {
    final $url = 'movie/popular?api_key=$apiKey&language=$lang';
    final request = Request('GET', $url, client.baseUrl);
    print("Request => $request");
    return client.send<String, String>(request);
  }

}