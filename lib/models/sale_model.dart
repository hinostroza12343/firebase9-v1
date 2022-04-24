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
    this.name,
    // this.marca,
    required this.quantity,
    required this.product,
  });

  int quantity;
  int product;
  // String? marca;
  String? name;
  String? image;

  factory SaleDetail.fromJson(Map<String, dynamic> json) => SaleDetail(
        // marca: json["marca"]??"",
        image: json["image"],
        name: json["name"],
        quantity: json["quantity"],
        product: json["product"],
      );

  Map<String, dynamic> toJson() => {
        // "marca": marca,
        "image": image,
        "name": name,
        "quantity": quantity,
        "product": product,
      };
}
