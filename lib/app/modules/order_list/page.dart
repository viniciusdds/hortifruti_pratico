import 'package:app_hortifruti_pratico/app/modules/order_list/controller.dart';
import 'package:app_hortifruti_pratico/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderListPage extends GetView<OrderListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus Pedidos')),
      body: Container(
        child: Center(
          child: ElevatedButton(
            onPressed: () => Get.toNamed(Routes.login),
            child: const Text('Entre com sua conta para ver os pedidos'),
          ),
        ),
      ),
    );
  }
}