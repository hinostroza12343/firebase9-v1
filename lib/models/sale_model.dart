import 'package:meta/meta.dart';
import 'dart:convert';

SaleModel saleModelFromJson(String str) => SaleModel.fromJson(json.decode(str));

String saleModelToJson(SaleModel data) => json.encode(data.toJson());

class SaleModel {
  SaleModel({
    required this.total,
    required this.saleDetail,
  });

  double total;
  List<SaleDetail> saleDetail;

  factory SaleModel.fromJson(Map<String, dynamic> json) => SaleModel(
        total: json["total"],
        saleDetail: List<SaleDetail>.from(
            json["sale_detail"].map((x) => SaleDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "sale_detail": List<dynamic>.from(saleDetail.map((x) => x.toJson())),
      };
}

class SaleDetail {
  SaleDetail({
    this.image,
    required this.name,
    this.price2,
    // this.marca,
    required this.quantity,
    required this.product,
  });

  int quantity;
  int product;
  // String? marca;
  String name;
  String? image;
  double? price2;

  factory SaleDetail.fromJson(Map<String, dynamic> json) => SaleDetail(
        // marca: json["marca"]??"",
      
        image: json["image"]??"",
        name: json["name"]??"",
        price2:json["price"]??0.0,
        quantity: json["quantity"]??0,
        product: json["product"]??0,
      );

  Map<String, dynamic> toJson() => {
        // "marca": marca,
        "image": image,
        "price":price2,
        "name": name,
        "quantity": quantity,
        "product": product,
      };
}
