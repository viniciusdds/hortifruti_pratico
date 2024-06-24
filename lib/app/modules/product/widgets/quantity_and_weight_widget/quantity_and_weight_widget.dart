import 'package:app_hortifruti_pratico/app/modules/product/widgets/quantity_and_weight_widget/quantity_and_weight_widget_controller.dart';
import 'package:app_hortifruti_pratico/app/modules/product/widgets/quantity_and_weight_widget/quantity_widget.dart';
import 'package:app_hortifruti_pratico/app/modules/product/widgets/quantity_and_weight_widget/weight_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuantityAndWeightWidget extends StatelessWidget {

  bool isKg;

  QuantityAndWeightWidget({this.isKg = false});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<QuantityAndWeightController>(
        init: QuantityAndWeightController(isKg: isKg),
        builder: (controller) => Column(
          children: [
            QuantityWidget(),
            if(isKg)
              WeightWidget()
          ],
        )
    );
  }
}








