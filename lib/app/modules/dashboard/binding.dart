import 'package:app_hortifruti_pratico/app/modules/dashboard/controller.dart';
import 'package:get/get.dart';
 
class DashboardBinding extends Bindings { 
  @override
  void dependencies() { 
    Get.lazyPut<DashboardController>(() => DashboardController());
  } 
}