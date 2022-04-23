
import 'dart:convert';


class BrandModel {

  BrandModel({
    required this.id,
    required this.image,
    required this.brand,
    required this.activated,
  });

  int id;
  String image;
  String brand;
  bool activated;

  factory BrandModel.fromJson(Map<String, dynamic> perrito) => BrandModel(
    id: perrito["id"],
    image: perrito["image"],
    brand: perrito["brand"],
    activated: perrito["activated"],
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "brand": brand,
    "activated": activated,
  };


}