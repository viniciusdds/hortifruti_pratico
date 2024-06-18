import 'dart:convert';

import 'package:get/get_connect.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class Api extends GetConnect {

  @override
  void onInit() {
    super.onInit();

    httpClient.baseUrl = 'https://dev.hortifruti.174.138.42.25.getmoss.site';

    httpClient.addRequestModifier((Request request) {
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'application/json';

      return request;
    });

    super.onInit();
  }

  Response _errorHandler(Response response) {
    print(response.bodyString);

    switch(response.statusCode){
      case 200:
      case 202:
      case 204:
        return response;
      default:
        throw 'Ocorreu um erro';
    }
  }

}