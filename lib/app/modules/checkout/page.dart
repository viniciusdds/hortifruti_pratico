import 'package:app_hortifruti_pratico/app/modules/checkout/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckoutPage extends GetView<CheckoutController> {

  @override
  Widget build(BuildContext context) {

    print(controller.isLogged);

    return Scaffold(
      appBar: AppBar(
          title: Text('Checkout'),
          centerTitle: true,
      ),
      body: Obx(() {

        if(controller.loading.isTrue){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SingleChildScrollView(
        child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16
                ),
                child: Text(
                  'Endereço',
                  style: Get.textTheme.titleLarge,
                ),
              ),
              Visibility(
                visible: !controller.isLogged,
                replacement: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      if(controller.addresses.isNotEmpty) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                  Expanded(child: _buildAddress()),
                                  TextButton(
                                    onPressed: controller.showAddressList,
                                    child: const Text('Alterar'),
                                  ),
                              ],
                          ),
                          if(!controller.deliveryToMyAddress)
                              Text(
                                'O endereço selecionado não é atendido',
                                textAlign: TextAlign.center,
                                style: Get.textTheme.bodyLarge!.copyWith(color: Colors.red),
                              )
                      ]
                      else
                         Center(
                           child: OutlinedButton(
                              onPressed: controller.goToNewAddress,
                              child: const Text('Cadastrar um endereço'),
                           ),
                         ),
                    ],
                  ),
                ),
                child:  Center(
                  child:  OutlinedButton(
                      onPressed: controller.goToLogin,
                      child: const Text('Entre com a sua conta para cadastrar')
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16
                ),
                child: Text(
                    'Forma de pagamento',
                    style: Get.textTheme.titleLarge,
                ),
              ),
              for(var paymentMethod in controller.paymentMethods)
                RadioListTile(
                    title: Text(paymentMethod.name),
                    value: paymentMethod,
                    groupValue: controller.paymentMethod.value,
                    onChanged: controller.changePaymentMethod
                ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                          'Produtos: ',
                           style: Get.textTheme.titleMedium,
                      ),
                    ),
                    Text(
                        NumberFormat.simpleCurrency().format(controller.totalCart),
                        style: Get.textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Custo de entrega: ',
                        style: Get.textTheme.titleMedium,
                      ),
                    ),
                    Text(
                      NumberFormat.simpleCurrency().format(num.parse(controller.deliveryCost)),
                      style: Get.textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Total: ',
                        style: Get.textTheme.titleLarge,
                      ),
                    ),
                    Text(
                      NumberFormat.simpleCurrency().format(controller.totalOrder),
                      style: Get.textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              Align(
                child: ElevatedButton(
                    onPressed: controller.canSendOrder ? controller.sendOrder : null,
                    child: Text('Enviar pedido')
                ),
              )
            ],
          ),
        );

      }),
    );
  }

  _buildAddress(){
    var address = controller.addressSelected.value!;
    return Text('${address.street}, n° ${address.number}, ${address.neighborhood}');
  }
}
