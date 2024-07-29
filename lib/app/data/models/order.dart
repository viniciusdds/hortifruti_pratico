import 'package:app_hortifruti_pratico/app/data/models/address.dart';
import 'package:app_hortifruti_pratico/app/data/models/order_product.dart';
import 'package:app_hortifruti_pratico/app/data/models/order_status.dart';
import 'package:app_hortifruti_pratico/app/data/models/payment_method.dart';
import 'package:app_hortifruti_pratico/app/data/models/store.dart';
import 'package:intl/intl.dart';

class OrderModel {

  String hashId;
  StoreModel store;
  String value;
  String deliveryCost;
  AddressModel? address;
  PaymentMethodModel? paymentMethod;
  String? trocoPara;

  List<OrderProductModel> productList;
  List<OrderStatusModel> statusList;
  String? observation;
  DateTime createAt;

  OrderModel({
    required this.hashId,
    required this.store,
    required this.value,
    required this.deliveryCost,
    this.address,
    this.paymentMethod,

    required this.productList,
    required this.statusList,
    this.observation,
    required this.createAt,
    this.trocoPara
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    hashId: json['hash_id'],
    store: StoreModel.fromJson(json['estabelecimento']),
    value: json['valor'],
    deliveryCost: json['custo_entrega'],
    address: json['endereco'] == null ? null : AddressModel.fromJson(json['endereco']),
    paymentMethod: json['meio_pagamento'] == null ? null : PaymentMethodModel.fromJson(json['meio_pagamento']),
    productList: json['produtos'] == null
       ? []
       : List<OrderProductModel>.from(
            json['produtos'].map((product) => OrderProductModel.fromJson(product))
         ),
    statusList: json['pedido_status'] == null
       ? []
       : List<OrderStatusModel>.from(
            json['pedido_status'].map((status) => OrderStatusModel.fromJson(status))
         ),
    observation: json['observacao'],
    createAt: DateTime.parse(json['created_at']),
    trocoPara: json['troco_para']
  );
}