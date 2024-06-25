import 'package:app_hortifruti_pratico/app/data/models/cart_product.dart';
import 'package:app_hortifruti_pratico/app/data/models/product.dart';
import 'package:app_hortifruti_pratico/app/data/models/store.dart';
import 'package:app_hortifruti_pratico/app/data/services/cart/service.dart';
import 'package:app_hortifruti_pratico/app/modules/product/widgets/quantity_and_weight_widget/quantity_and_weight_widget_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {

  final product = Rxn<ProductModel>();
  final store = Rxn<StoreModel>();
  final observationController = TextEditingController();
  final _cartService = Get.find<CartService>();

  @override
  void onInit() {
     product.value = Get.arguments['product'];
     store.value = Get.arguments['store'];

     super.onInit();
  }

  void addToCart() async {
     var quantity = Get.find<QuantityAndWeightController>().quantity;

     if(_cartService.isANewStore(store.value!)){
        var startNewCart = await showDialogNewCart();

        if(startNewCart == true){
          _cartService.clearCart();
        }else{
          return;
        }
     }

     if(_cartService.products.isEmpty){
        _cartService.newCart(store.value!);
     }

     _cartService.addProductToCart(
       CartProductModel(
           product: product.value!,
           quantity: quantity.toStringAsFixed(2),
           observation: observationController.text
       )
     );

     ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(
       SnackBar(
         content: Text('o item  ${product.value!.name}  foi adicionado no carrinho'),
       )
     );

     Future.delayed(
         const Duration(milliseconds:  1000),
         () => Get.back()
     );
  }

  Future<dynamic> showDialogNewCart() {
    return Get.dialog(
       AlertDialog(
        content: const Text('Seu carrinho será perdido se adicionar produtos de um novo estabelecimento.'),
        actions: [
          TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('Voltar')
          ),
          TextButton(
              onPressed: () => Get.back(result: true),
              child: const Text('Continuar')
          ),
        ],
      )
    );
  }

}