
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
    saleDetail: List<SaleDetail>.from(json["sale_detail"].map((x) => SaleDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "sale_detail": List<dynamic>.from(saleDetail.map((x) => x.toJson())),
  };
}



class SaleDetail {
  SaleDetail({
    required this.quantity,
    required this.product,
  });

  int quantity;
  int product;

  factory SaleDetail.fromJson(Map<String, dynamic> json) => SaleDetail(
    quantity: json["quantity"],
    product: json["product"],
  );

  Map<String, dynamic> toJson() => {
    "quantity": quantity,
    "product": product,
  };
}