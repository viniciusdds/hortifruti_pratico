import 'package:app_hortifruti_pratico/app/modules/store/controller.dart';
import 'package:app_hortifruti_pratico/app/routes/routes.dart';
import 'package:app_hortifruti_pratico/app/widgets/store_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

class StorePage extends GetView<StoreController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx(
          (store) => CustomScrollView(
            slivers: [
              const SliverAppBar(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 8,
                    right: 16,
                    bottom: 16
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 96,
                        height: 96,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: store!.image),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                store.name,
                                style: Get.textTheme.titleLarge,
                            ),
                            SizedBox(height: 8),
                            StoreStatus(isOnline: store.isOnline)
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    ((context, index){
                      var category = store.categories[index];
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Container(
                                    color: Colors.grey.shade200,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 16
                                    ),
                                    child: Text(
                                      category.name,
                                      style: Get.textTheme.titleMedium!.copyWith(
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  )
                              )
                            ],
                          ),
                          for (var product in category.products)
                            ListTile(
                              title: Text(product.name),
                              subtitle: Text(NumberFormat.simpleCurrency().format(double.parse(product.price)) + (product.isKg ? '/kg' : '')),
                              leading: product.image != null
                                ? SizedBox(
                                    width: 56,
                                    height: 56,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: FadeInImage.memoryNetwork(
                                          placeholder: kTransparentImage,
                                          image: product.image!
                                      ),
                                    ),
                                ) : null,
                               onTap: () => Get.toNamed(
                                   Routes.product,
                                   arguments: {
                                     'product': product,
                                     'store': store
                                   }
                               ),
                            )
                        ],
                      );
                    }),
                  childCount: store.categories.length,
                ),
              ),
            ],
          )
      ),
    );
  }
}
