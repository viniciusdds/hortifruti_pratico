import 'package:app_hortifruti_pratico/app/data/models/cart_product.dart';
import 'package:app_hortifruti_pratico/app/modules/cart/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
class CartPage extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart Page')),
      body: SingleChildScrollView(
        child: Obx(() => Column(
            children: [
              for(var cartProduct in controller.products)
                  ListTile(
                    title: Text(cartProduct.product.name),
                    subtitle: Text(
                        "${NumberFormat.simpleCurrency().format(cartProduct.total)}  "
                        "(${NumberFormat.simpleCurrency().format(double.parse(cartProduct.product.price))})",
                    ),
                    leading: _buildProductQuantity(cartProduct),
                    trailing: IconButton(
                      onPressed: () => controller.removeProduct(cartProduct),
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                    ),
                  )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductQuantity(CartProductModel cartProduct){
    return Text(NumberFormat.decimalPattern().format(double.parse(cartProduct.quantity)) + (cartProduct.product.isKg ? 'kg' : 'x'));
  }
}
