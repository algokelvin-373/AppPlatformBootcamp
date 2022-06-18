part of 'api_service.dart';

class _$ApiService extends ApiService {

  _$ApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  Type get definitionType => ApiService;

  @override
  Future<Response<ListMovie>> getMoviePopular(String apiKey, String lang) {
    final $url = '3/movie/popular?api_key=$apiKey&language=$lang';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<ListMovie, ListMovie>($request);
  }

}