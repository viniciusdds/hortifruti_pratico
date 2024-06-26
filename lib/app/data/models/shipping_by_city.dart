class ShippingByCityModel {

  int id;
  String cidade;
  String cost;


  ShippingByCityModel({
    required this.id,
    required this.cidade,
    required this.cost
  });

  factory ShippingByCityModel.fromJson(Map<String, dynamic> json) => ShippingByCityModel(
    id: json['id'],
    cidade: json['cidade'],
    cost: json['custo_entrega'],
  );
}