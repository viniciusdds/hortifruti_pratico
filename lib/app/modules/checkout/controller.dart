import 'package:app_hortifruti_pratico/app/data/models/address.dart';
import 'package:app_hortifruti_pratico/app/data/models/order_request.dart';
import 'package:app_hortifruti_pratico/app/data/models/payment_method.dart';
import 'package:app_hortifruti_pratico/app/data/models/shipping_by_city.dart';
import 'package:app_hortifruti_pratico/app/data/services/auth/service.dart';
import 'package:app_hortifruti_pratico/app/data/services/cart/service.dart';
import 'package:app_hortifruti_pratico/app/modules/checkout/repository.dart';
import 'package:app_hortifruti_pratico/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckoutController extends GetxController {

  final formKey = GlobalKey<FormState>();
  final CheckoutRepository _repository;
  final _cartService = Get.find<CartService>();
  final _authService = Get.find<AuthService>();

  CheckoutController(this._repository);

  final loading = true.obs;

  num get totalCart => _cartService.total;
  String get deliveryCost {
    if(getShippingByCity != null){
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
  bool get canSendOrder => isLogged && deliveryToMyAddress;
  final temTroco = false.obs;
  TextEditingController trocoController = TextEditingController();

  @override
  void onInit() {
    fetchAddresses();

    ever(_authService.user, (_) => fetchAddresses());

    super.onInit();
  }

  void changePaymentMethod(PaymentMethodModel? newPaymentMethod){
    paymentMethod.value = newPaymentMethod;
    temTroco.value = false;

    if(paymentMethod.value!.name.toUpperCase() == 'DINHEIRO') {
      Get.dialog(
          AlertDialog(
            title: Text(
              'Pagamento em ${paymentMethod.value!.name}',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
            content: const Text(
              'Precisa de troco?',
              style: TextStyle(
                  fontSize: 15
              ),
            ),
            actions: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   TextButton(
                     onPressed: () {
                       temTroco.value = false;
                       trocoController.text = "";
                       Get.back();
                     },
                     child: const Text('NÃO'),
                   ),
                   TextButton(
                     onPressed: () {
                       temTroco.value = true;
                     },
                     child: const Text('SIM'),
                   ),
                 ],
               ),

               Obx(() => Visibility(
                 visible: temTroco.value,
                 child: Form(
                   key: formKey,
                   child: Column(
                     children: [
                       TextFormField(
                         controller: trocoController,
                         decoration: const InputDecoration(
                             hintText: 'Informe valor para o troco'
                         ),
                         validator: (text){
                           if (text == null || text.isEmpty) {
                             return 'Informe um valor';
                           }
                           final trocoValue = double.tryParse(text);
                           final totalOrderValue = double.parse(totalOrder.toString());
                           // if (trocoValue == null || totalOrderValue == null) {
                           //   return 'Informe um valor válido';
                           // }
                           print("valor: ${totalOrderValue}");
                           if (trocoValue! <= totalOrderValue) {
                             return 'Informe um valor maior que o total';
                           }
                           return null;
                         },
                       ),

                       Padding(
                         padding: const EdgeInsets.symmetric(vertical: 6),
                         child: ElevatedButton(
                             onPressed: (){
                               if(formKey.currentState!.validate()){
                                 Get.back();
                               }
                             },
                             child: Text(
                               'Confirmar valor',
                             )
                         ),
                       )
                     ],
                   ),
                 ),
               ),
                   )

            ],
          )
      );
    }else{
      trocoController.text = "";
    }
  }

  void goToNewAddress() async {
    var result = await Get.toNamed(Routes.userAddress);

    if(result is bool && result){
      fetchAddresses();
    }
  }

  void goToLogin() {
    Get.toNamed(Routes.login);
  }

  void fetchAddresses(){
    loading(true);
    _repository.getUserAddresses()
      .then((data) {
        addresses.assignAll(data);

        if(addresses.isNotEmpty){
          addressSelected.value = addresses.first;
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

  void sendOrder(){
    if(paymentMethod.value == null){
      ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(
        SnackBar(content: Text('Escolha a forma de pagamento do seu pedido.'))
      );

      return;
    }

    print('Valor para troco é '+trocoController.text);

    var orderRequest = OrderRequestModel(
        store:  _cartService.store.value!,
        paymentMethod: paymentMethod.value!,
        cartProducts: _cartService.products,
        address: addressSelected.value!,
        observation: _cartService.observation.value,
        trocoPara: double.tryParse(trocoController.text)
    );

    _repository.postOrder(orderRequest).then((value){
      Get.dialog(
        AlertDialog(
          title: Text('Pedido enviado'),
          actions: [
            TextButton(
                onPressed: (){
                  _cartService.finalizeCart();
                  Get.offAllNamed(Routes.dashboard, arguments: 2);
                },
                child: Text('Ver Meus Pedidos')
            )
          ],
        ),
        barrierDismissible: false,
      );
    });
  }

}