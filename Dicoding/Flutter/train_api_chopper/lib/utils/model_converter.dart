import 'dart:convert';
import 'package:train_api_chopper/model/movie.dart';
import 'package:chopper/chopper.dart';

class ModelConverter implements Converter{
  @override
  Request convertRequest(Request request) {
    final req = applyHeader(
        request,
        contentTypeKey,
        jsonHeaders,
        override: false
    );

    return encodeJson(req);
  }

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    return decodeJson<BodyType, InnerType>(response);
  }

  Request encodeJson(Request request){
    var contentType = request.headers[contentTypeKey];

    if(contentType != null && contentType.contains(jsonHeaders)){
      return request.copyWith(body: json.encode(request.body));
    }

    return request;
  }

  Response<BodyType> decodeJson<BodyType, InnerType>(Response response){
    var contentType = response.headers[contentTypeKey];
    var body = response.body;
    // print("contentType => $contentType");
    // print("Body => $body}");

    if(contentType != null && contentType.contains(jsonHeaders)){
      // print("Masuk If");
      body = utf8.decode(response.bodyBytes);
    }

    try{
      var mapData = json.decode(body);
      // print("mapData => $mapData}");
      // var newsModel = ListMovie.fromJson(mapData);
      var newsModel = ListMovie.fromJson(mapData);
      // print('type list movie 2 => ${newsModel as ListMovie}');
      // print("newsModel => $newsModel");

      return response.copyWith<BodyType>(body: newsModel as BodyType);
    } catch(e){
      print("Masuk catch => $e");
      chopperLogger.warning(e);
      return response.copyWith<BodyType>(body: body);
    }
  }

}