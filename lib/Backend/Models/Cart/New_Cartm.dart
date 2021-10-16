import 'dart:convert';
import 'package:uiecom/Backend/Models/Product/New_Product_m.dart';

MainCart mainCartFromJson(String str) => MainCart.fromJson(json.decode(str));

String mainCartToJson(MainCart data) => json.encode(data.toJson());

class MainCart {
  List<NewCart> cartData;
  MainCart({required this.cartData});

  factory MainCart.fromJson(Map<String, dynamic> json) => MainCart(
        cartData: List<NewCart>.from(
            json["cartData"].map((x) => NewCart.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cartData": List<dynamic>.from(cartData.map((x) => x.toJson())),
      };
}

/* -------------------------------------------------------------------------- */
/*                           // ! 1. CART MAIN LIST                           */
/* -------------------------------------------------------------------------- */

List<NewCart> newCartFromJson(String str) =>
    List<NewCart>.from(json.decode(str).map((x) => NewCart.fromJson(x)));

String newCartToJson(List<NewCart> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewCart {
  NewCart({
    this.id,
    this.quantity,
    this.ammount,
    this.shipPrice,
    this.totalAmmount,
    this.disPrice,
    this.date,
    this.uplod,
    this.product,
  });

  String? id;
  int? quantity;
  int? ammount;
  int? shipPrice;
  int? disPrice;
  int? totalAmmount;
  DateTime? date;
  Uplod? uplod;
  ProductC? product;

  factory NewCart.fromJson(Map<String, dynamic> json) => NewCart(
        id: json["id"],
        quantity: json["quantity"],
        ammount: json["ammount"],
        shipPrice: json["shipPrice"],
        totalAmmount: json["totalAmmount"],
        date: DateTime.parse(json["date"]),
        uplod: Uplod.fromJson(json["uplod"]),
        product: ProductC.fromJson(json["product"]),
        disPrice: json["disPrice"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "ammount": ammount,
        "shipPrice": shipPrice,
        "totalAmmount": totalAmmount,
        "uplod": uplod!.toJson(),
        "product": product!.toJson(),
        "disPrice": disPrice
      };
}
