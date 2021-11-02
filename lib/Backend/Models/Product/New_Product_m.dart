import 'dart:convert';

MainProduct mainProductMFromJson(String str) =>
    MainProduct.fromJson(json.decode(str));

String mainProductMToJson(MainProduct data) => json.encode(data.toJson());

class MainProduct {
  MainProduct({
    required this.productData,
  });

  List<ProductC> productData;

  factory MainProduct.fromJson(Map<String, dynamic> json) => MainProduct(
        productData: List<ProductC>.from(
            json["productData"].map((x) => ProductC.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "productData": List<dynamic>.from(productData.map((x) => x.toJson())),
      };
}

/* -------------------------------------------------------------------------- */
/*                        // ! PRODUCT MODEL WITH DEPTH                       */
/* -------------------------------------------------------------------------- */

ProductC productCFromJson(String str) => ProductC.fromJson(json.decode(str));

String productCToJson(ProductC data) => json.encode(data.toJson());

class ProductC {
  ProductC({
    this.id,
    this.title,
    this.description,
    this.salesPrice,
    this.discountPrice,
    this.ourPrice,
    this.category,
    this.date,
    this.stock,
    this.pic,
    this.offers,
    this.quantity,
    this.ammount,
    this.uplod,
  });

  String? id;
  String? title;
  String? description;
  double? salesPrice;
  double? discountPrice;
  double? ourPrice;
  dynamic? category;
  DateTime? date;
  int? stock;
  String? pic;
  int? offers;
  int? quantity;
  int? ammount;
  Uplod? uplod;

  factory ProductC.fromJson(Map<String, dynamic> json) => ProductC(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        salesPrice: json["salesPrice"],
        discountPrice: json["discountPrice"],
        ourPrice: json["ourPrice"],
        category: json["category"],
        date: DateTime.parse(json["date"]),
        stock: json["stock"],
        pic: json["pic"],
        offers: json["offers"],
        quantity: json["quantity"],
        ammount: json["ammount"],
        uplod: Uplod.fromJson(json["uplod"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "salesPrice": salesPrice,
        "discountPrice": discountPrice,
        "ourPrice": ourPrice,
        "category": category,
        "stock": stock,
        "pic": pic,
        "offers": offers,
        "quantity": quantity,
        "ammount": ammount,
        "uplod": uplod?.toJson(),
      };
}

class Uplod {
  Uplod({
    this.id,
    this.phone,
    this.fullname,
    this.email,
    this.isCustomer,
  });

  String? id;

  String? phone;
  String? fullname;

  String? email;

  bool? isCustomer;

  factory Uplod.fromJson(Map<String, dynamic> json) => Uplod(
        id: json["id"],
        phone: json["phone"],
        fullname: json["fullname"],
        email: json["email"],
        isCustomer: json["isCustomer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "fullname": fullname,
        "email": email,
        "isCustomer": isCustomer,
      };
}
