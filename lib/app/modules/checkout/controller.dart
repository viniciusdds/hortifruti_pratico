import 'package:app_hortifruti_pratico/app/data/models/address.dart';
import 'package:app_hortifruti_pratico/app/data/models/payment_method.dart';
import 'package:app_hortifruti_pratico/app/data/models/shipping_by_city.dart';
import 'package:app_hortifruti_pratico/app/data/services/auth/service.dart';
import 'package:app_hortifruti_pratico/app/data/services/cart/service.dart';
import 'package:app_hortifruti_pratico/app/modules/checkout/repository.dart';
import 'package:app_hortifruti_pratico/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {

  final CheckoutRepository _repository;
  final _cartService = Get.find<CartService>();
  final _authService = Get.find<AuthService>();

  CheckoutController(this._repository);

  final loading = true.obs;

  num get totalCart => _cartService.total;
  String get deliveryCost {
    if(getShippingByCity != null){
      print('teste: ${getShippingByCity!.cost}');
      return getShippingByCity!.cost;
    }

    return '0';
  }
  ShippingByCityModel? get getShippingByCity {
    if(addressSelected.value == null){
      return null;
    }

    return _cartService.store.value!.shippingByCity
              .firstWhereOrNull((shippingByCity) => shippingByCity.id == addressSelected.value!.city!.id);
  }
  num get totalOrder => totalCart + num.parse(deliveryCost);

  List<PaymentMethodModel> get paymentMethods => _cartService.store.value!.paymentMethod;

  final paymentMethod = Rxn<PaymentMethodModel>();
  bool get isLogged => _authService.isLogged;
  final addresses = RxList<AddressModel>();
  final addressSelected = Rxn<AddressModel>();
  bool get deliveryToMyAddress => getShippingByCity != null;

  @override
  void onInit() {
    fetchAddresses();

    super.onInit();
  }

  void changePaymentMethod(PaymentMethodModel? newPaymentMethod){
    paymentMethod.value = newPaymentMethod;
  }

  void goToNewAddress(){
    Get.toNamed(Routes.userAddress);
  }

  void goToLogin(){
    Get.toNamed(Routes.login);
  }

  fetchAddresses(){
    _repository.getUserAddresses()
      .then((value) {
       // addresses.addAll(value);

        if(addresses.isNotEmpty){
         // addressSelected.value = addresses.first;
        }

        loading(false);
      }, onError: (error){
       loading(false);
    });
  }

  void showAddressList(){
    Get.dialog(
     SimpleDialog(
       title: Text('Selecione um endereço'),
       children: [
         for(var address in addresses)
           SimpleDialogOption(
             child: Text('${address.street}, n° ${address.number}, ${address.neighborhood}'),
             onPressed: (){
                addressSelected.value = address;
                Get.back();
             },
           ),
           TextButton(
             onPressed: (){
               Get.back();
               goToNewAddress();
             },
             child: const Text('Cadastrar um endereço'),
           )

       ],
     )
    );
  }
}