import 'package:app_hortifruti_pratico/app/data/models/payment_method.dart';
import 'package:app_hortifruti_pratico/app/data/models/shipping_by_city.dart';
import 'package:app_hortifruti_pratico/app/data/services/cart/service.dart';
import 'package:app_hortifruti_pratico/app/modules/checkout/repository.dart';
import 'package:app_hortifruti_pratico/app/routes/routes.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {

  final CheckoutRepository _repository;
  final _cartService = Get.find<CartService>();

  CheckoutController(this._repository);

  num get totalCart => _cartService.total;
  String get deliveryCost {
    if(getShippingByCity != null){
      return getShippingByCity!.cost;
    }

    return '0';
  }
  ShippingByCityModel? get getShippingByCity {
    var cityId = 1;
    return _cartService.store.value!.shippingByCity.firstWhereOrNull((shippingByCity) => shippingByCity.id == cityId);
  }
  num get totalOrder => totalCart + num.parse(deliveryCost);

  List<PaymentMethodModel> get paymentMethods => _cartService.store.value!.paymentMethod;

  @override
  void onInit() {
    print(_cartService.store.value!.paymentMethod);
    print('teste');
    super.onInit();
  }

  final paymentMethod = Rxn<PaymentMethodModel>();

  void changePaymentMethod(PaymentMethodModel? newPaymentMethod){
    paymentMethod.value = newPaymentMethod;
  }

  void goToLogin(){
    Get.toNamed(Routes.login);
  }
}