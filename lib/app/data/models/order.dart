import 'package:app_hortifruti_pratico/app/data/models/order_status.dart';
import 'package:app_hortifruti_pratico/app/data/models/store.dart';

class OrderModel {

  String hashId;
  StoreModel store;
  String value;
  String deliveryCost;
  List<OrderStatusModel> statusList;
  String? observation;
  DateTime createAt;

  OrderModel({
    required this.hashId,
    required this.store,
    required this.value,
    required this.deliveryCost,
    required this.statusList,
    this.observation,
    required this.createAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    hashId: json['hash_id'],
    store: StoreModel.fromJson(json['estabelecimento']),
    value: json['valor'],
    deliveryCost: json['custo_entrega'],
    statusList: json['pedido_status'] == null
       ? []
       : List<OrderStatusModel>.from(
            json['pedido_status'].map((status) => OrderStatusModel.fromJson(status))
         ),
    observation: json['observacao'],
    createAt: DateTime.parse(json['created_at']),
  );
}