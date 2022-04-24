import 'dart:convert';

class BannerModel {
  BannerModel({
    this.id,
    required this.image,
    this.description,
    this.activated,
  });

  int? id;
  String image;
  String? description;
  bool? activated;

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json["id"],
        image: json["image"],
        description: json["description"],
        activated: json["activated"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "description": description,
        "activated": activated,
      };
}
