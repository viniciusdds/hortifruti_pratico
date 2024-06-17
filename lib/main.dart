import 'package:app_hortifruti_pratico/app/routes/pages.dart';
import 'package:app_hortifruti_pratico/app/routes/routes.dart';
import 'package:flutter/material.dart'; 
import 'package:get/get.dart'; 

void main() {
  runApp(GetMaterialApp(   
    debugShowCheckedModeBanner: false,   
    initialRoute: Routes.INITIAL,   
    theme: ThemeData(
      primarySwatch: Colors.blue
    ),
    defaultTransition: Transition.fade,   
    getPages: AppPages.pages,
  ));   
}



