import 'dart:convert';

import 'package:app_hortifruti_pratico/app/data/models/store.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class Api extends GetConnect {

  @override
  void onInit() {
    super.onInit();

    httpClient.baseUrl = 'http://10.101.2.71:3333/';

    httpClient.addRequestModifier((Request request) {
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'application/json';

      return request;
    });

    super.onInit();
  }
  
  Future<List<StoreModel>> getStores() async {
     var response = _errorHandler(await get('cidades/1/estabelecimentos'));

     List<StoreModel> data = [];
     for(var store in response.body){
       data.add(StoreModel.fromJson(store));
     }
     
     return data;
  }

  Future<StoreModel> getStore(int id) async {
    var response = _errorHandler(await get('estabelecimentos/$id'));

    print("teste:  ${response.body}");

    return StoreModel.fromJson(response.body);
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