// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

import 'package:uiecom/Backend/Models/Product/New_Product_m.dart';
import 'package:uiecom/Backend/Models/Prof_Address/Addressm.dart';

MainOrder mainOrderFromJson(String str) => MainOrder.fromJson(json.decode(str));

String mainOrderToJson(MainOrder data) => json.encode(data.toJson());

class MainOrder {
  List<Order> orderData;
  MainOrder({required this.orderData});

  factory MainOrder.fromJson(Map<String, dynamic> json) => MainOrder(
        orderData:
            List<Order>.from(json["orderData"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orderData": List<dynamic>.from(orderData.map((x) => x.toJson())),
      };
}

/* -------------------------------------------------------------------------- */
/*                            // ! ORDER CLASS PAGE                           */
/* -------------------------------------------------------------------------- */

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({
    this.id,
    this.disPrice,
    this.date,
    this.quantity,
    this.ammount,
    this.shipPrice,
    this.totalAmmount,
    this.status,
    this.uplod,
    this.product,
    this.address,
  });

  String? id;
  int? disPrice;
  DateTime? date;
  int? quantity;
  int? ammount;
  int? shipPrice;
  int? totalAmmount;
  String? status;
  String? uplod;
  String? product;
  String? address;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        disPrice: json["disPrice"],
        date: DateTime.parse(json["date"]),
        quantity: json["quantity"],
        ammount: json["ammount"],
        shipPrice: json["shipPrice"],
        totalAmmount: json["totalAmmount"],
        status: json["status"],
        uplod: json["uplod"],
        product: json["product"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "disPrice": disPrice,
        "quantity": quantity,
        "ammount": ammount,
        "shipPrice": shipPrice,
        "totalAmmount": totalAmmount,
        "status": status,
        "uplod": uplod,
        "product": product,
        "address": address,
      };
}
