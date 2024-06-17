import 'package:app_hortifruti_pratico/app/modules/dashboard/binding.dart';
import 'package:app_hortifruti_pratico/app/modules/dashboard/page.dart';
import 'package:app_hortifruti_pratico/app/modules/home/binding.dart';
import 'package:app_hortifruti_pratico/app/modules/home/page.dart';
import 'package:get/get.dart';
import 'routes.dart';

abstract class AppPages {
  
  static final pages = [
    GetPage(
        name: Routes.dashboard,
        page: ()=> DashboardPage(),
        binding: DashboardBinding()
    )
  ];
  
}