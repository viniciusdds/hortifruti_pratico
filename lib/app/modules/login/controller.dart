import 'package:app_hortifruti_pratico/app/data/models/user_login_request.dart';
import 'package:app_hortifruti_pratico/app/data/services/auth/service.dart';
import 'package:app_hortifruti_pratico/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  final formKey = GlobalKey<FormState>();
  final _authService = Get.find<AuthService>();
  var emailController = TextEditingController(text: 'cliente@email.com');
  var passwordController = TextEditingController(text: '123456');

  void login(){
    Get.focusScope!.unfocus();

    if(!formKey.currentState!.validate()){
      return;
    }

    var userLogRequestModel = UserLoginRequestModel(
        email: emailController.text,
        password: passwordController.text
    );

    _authService
        .login(userLogRequestModel)
        .then((value) {
          Get.back();
        }, onError: (error){
          Get.dialog(
            AlertDialog(
              title: Text(error.toString()),
            )
          );
        });
  }
}