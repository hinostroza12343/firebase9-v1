import 'package:meta/meta.dart';
import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.id,
    required this.brand,
    required this.category,
    required this.name,
    required this.description,
    required this.price,
    this.quantity,
    required this.stock,
    required this.image,
    required this.activated,
  });

  int id;
  String brand;
  String category;
  String name;
  String description;
  double price;
  int? quantity;
  int stock;
  String image;
  bool activated;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    brand: json["brand"],
    category: json["category"] ?? "",
    name: json["name"],
    description: json["description"] ?? "",
    price: json["price"],
    quantity: json["quantity"] ?? 0,
    stock: json["stock"] ?? 0,
    image: json["image"],
    activated: json["activated"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "brand": brand,
    "category": category,
    "name": name,
    "description": description,
    "price": price,
    "quantity": quantity ?? 0,
    "stock": stock,
    "image": image,
    "activated": activated,
  };
}