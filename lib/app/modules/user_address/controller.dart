import 'package:app_hortifruti_pratico/app/data/models/city.dart';
import 'package:app_hortifruti_pratico/app/data/services/auth/service.dart';
import 'package:app_hortifruti_pratico/app/modules/user_address/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UserAddressController extends GetxController with StateMixin<List<CityModel>> {

  final UserAddressRepository _repository;

  UserAddressController(this._repository);

  final _authService = Get.find<AuthService>();
  var streetController = TextEditingController(text: 'Rua Bosta');
  var numberController = TextEditingController(text: '69');
  var neighborhoodController = TextEditingController(text: 'Zona');
  var referencePointController = TextEditingController(text: 'Perto do puteiro');
  var complementController = TextEditingController(text: '');
  final cityId = RxnInt();

  @override
  void onInit() {
    _repository.getCities()
      .then((data){
        change(data, status: RxStatus.success());
      }, onError: (error) {
        change(null, status: RxStatus.error(error));
      });

    super.onInit();
  }

  void submit(){

  }

  void changeCity(int? cityIdSelected){
    cityId.value = cityIdSelected;
  }
}