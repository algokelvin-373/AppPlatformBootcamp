import 'dart:async';
import 'dart:convert';
import 'package:train_api_chopper/model/movie.dart';
import 'package:chopper/chopper.dart';

class ModelConverter implements Converter{
  @override
  FutureOr<Request> convertRequest(Request request) {
    final req = applyHeader(
        request,
        contentTypeKey,
        jsonHeaders,
        override: false
    );

    return encodeJson(req);
  }

  @override
  FutureOr<Response<BodyType>> convertResponse<BodyType, InnerType>(Response<dynamic> response) {
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

    if(contentType != null && contentType.contains(jsonHeaders)){
      body = utf8.decode(response.bodyBytes);
    }

    try{
      var mapData = json.decode(body);
      var newsModel = ListMovie.fromJson(mapData);

      return response.copyWith<BodyType>(body: newsModel as BodyType);
    } catch(e){
      chopperLogger.warning(e);
      return response.copyWith<BodyType>(body: body);
    }
  }

}