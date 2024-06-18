import 'package:app_hortifruti_pratico/app/modules/home/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hortifruti Prático'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: controller.obx((state) => ListView(
             children: [
                for(var store in state!)
                  ListTile(
                     title:  Text(store.name),
                     leading: FlutterLogo(),
                     trailing: Text(store.isOnline ? 'Aberto' : 'Fechado'),
                   )
               ],
            ),
            onEmpty: Center(
                child: Text(
                    'Não tem nenhum estabelecimento disponível para a sua cidade.',
                    textAlign: TextAlign.center,
                )
            ),
          ),
      ),
    );
  }
}
