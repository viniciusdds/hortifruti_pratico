import 'package:app_hortifruti_pratico/app/data/models/order_product.dart';
import 'package:app_hortifruti_pratico/app/modules/order/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderPage extends GetView<OrderController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalhes do pedido')),
      body: controller.obx(
          (state) {
            print(state?.deliveryCost);
            return ListView
              (
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state!.store.name,
                        style: Get.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 2
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '#${state.hashId}',
                                style: Get.textTheme.titleMedium,
                              ),
                            ),
                            Text(
                                'Data: ${DateFormat("dd/MM/y 'às' HH:mm").format(
                                    state.createAt)}'
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16
                  ),
                  child: Text(
                    'Endereço de entrega'.toUpperCase(),
                    style: Get.textTheme.titleMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16
                  ),
                  child: Text('${state.address!.street}, n° ${state.address!
                      .number}, ${state.address!.neighborhood} '),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16
                  ),
                  child: Text(
                    'Andamento do pedido'.toUpperCase(),
                    style: Get.textTheme.titleMedium,
                  ),
                ),
                for(var status in state.statusList)
                  ListTile(
                    title: Text(status.name),
                    trailing: Text(DateFormat.Hm().format(status.createAt)),
                  ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16
                  ),
                  child: Text(
                    'Produtos'.toUpperCase(),
                    style: Get.textTheme.titleMedium,
                  ),
                ),
                for(var orderProduct in state.productList)
                  ListTile(
                      title: Text(orderProduct.product.name),
                      leading: _buildProductQuantity(orderProduct),
                      trailing: Text(NumberFormat.simpleCurrency().format(
                          orderProduct.total))
                  ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16
                  ),
                  child: Row(
                    children: [
                      const Expanded(child: Text('Custo de entrega')),
                      Text(NumberFormat.simpleCurrency().format(
                         double.tryParse(state.deliveryCost)))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8
                  ),
                  child: Row(
                    children: [
                      const Expanded(child: Text('Troco para')),
                      Text(state.trocoPara == null ? '' : NumberFormat.simpleCurrency().format(
                          double.tryParse(state.trocoPara!)))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                            'Total',
                            style: Get.textTheme.titleMedium,
                          )
                      ),
                      Text(
                        NumberFormat.simpleCurrency().format(double.tryParse(state.value)),
                        style: Get.textTheme.titleMedium,
                      )
                    ],
                  ),
                ),
              ],
            );
          }
      ),
    );
  }

  Widget _buildProductQuantity(OrderProductModel orderProduct){
    return Text(NumberFormat.decimalPattern().format(double.parse(orderProduct.quantity))
        + (orderProduct.product.isKg ? 'kg' : 'x')
    );
  }
}