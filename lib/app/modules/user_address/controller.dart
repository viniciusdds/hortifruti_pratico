import 'package:app_hortifruti_pratico/app/data/services/auth/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UserAddressController extends GetxController {

  final _authService = Get.find<AuthService>();
  var streetController = TextEditingController(text: 'Rua Bosta');
  var numberController = TextEditingController(text: '69');
  var neighborhoodController = TextEditingController(text: 'Zona');
  var referencePointController = TextEditingController(text: 'Perto do puteiro');
  var complementController = TextEditingController(text: '');

  void submit(){

  }
}