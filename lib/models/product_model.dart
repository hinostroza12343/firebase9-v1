import 'package:meta/meta.dart';
import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
       this.id,
     required  this.marca,
      this.rate,
    required this.category,
    required this.name,
    required this.description,
    required this.price,
    this.quantity,
      this.stock,
    required this.image,
      this.activated,
        this.pk
  }); 

  String? pk;
  int? id;
  int? rate;
  String marca;
  String category;
  String name;
  String description;
  double price;
  int? quantity;
  int? stock;
  String image;
  bool? activated;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"]??0,
    rate:json["rate"]??0,
    marca: json["marca"]??"",
    category: json["categoria"]?? "",
    name: json["name"]??"",
    description: json["descripcion"] ?? "",
    price: json["price"]??0,
    quantity: json["quantity"] ?? 0,
    stock: json["stock"] ?? 0,
    image: json["image"]??"",
    activated: json["activated"] ?? false,
    pk: json["pk"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rate":rate,
    "marca": marca,
    "categoria": category,
    "name": name,
    "descripcion": description,
    "price": price,
    "quantity": quantity ?? 0,
    "stock": stock,
    "image": image,
    "activated": activated,
    "pk":pk,
  };
}