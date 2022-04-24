import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_9_app/models/bnner_model.dart';
import 'package:firebase_9_app/models/product_model.dart';
import 'package:flutter/cupertino.dart';

class FirestoreService {
  bool? loading;
  String collection;
  FirestoreService({required this.collection, this.loading});
  late CollectionReference firestoreReferences =
      FirebaseFirestore.instance.collection(collection);

  Future saveSale(Map<String, dynamic> saleModel) async {
    firestoreReferences.add(saleModel).then((value) {
      print("Datos Registrados33");
    });
  }
  

  Future<List<Map<String, dynamic>>> getCategorias1() async {
    List<Map<String, dynamic>> listcategorias = [];
    QuerySnapshot collectionReferences =
        await firestoreReferences.orderBy('order', descending: false).get();
    collectionReferences.docs.forEach((element) {
      Map<String, dynamic> categorias = element.data() as Map<String, dynamic>;

      categorias["pk"] = element.id;
      listcategorias.add(categorias);
    });
    return listcategorias;
  }

  // Future<List<Map<String, dynamic>>> getProduct(
  //     {required String category}) async {
  //   List<Map<String, dynamic>> allproduct = [];
  //   QuerySnapshot collectionReferences =
  //       await firestoreReferences.where('categoria', isEqualTo: category).get();
  //   collectionReferences.docs.forEach((element) {
  //     Map<String, dynamic> product = element.data() as Map<String, dynamic>;
  //     product["pk"] = element.id;
  //     allproduct.add(product);
  //   });
  //   return allproduct;
  // }
  Future<List<ProductModel>> getProductModelID({required String id}) async {
    List<ProductModel> productModel = [];
    QuerySnapshot collectionReferences =
        await firestoreReferences.where('categoria', isEqualTo: id).get();
    collectionReferences.docs.forEach((element) {
      Map<String, dynamic> mymap = element.data() as Map<String, dynamic>;
      mymap["pk"] = element.id;
      productModel.add(ProductModel.fromJson(mymap));
    });

    return productModel;
  }

  Future<List<ProductModel>> getProductModel() async {
    List<ProductModel> productModel = [];
    QuerySnapshot collectionReferences = await firestoreReferences.get();
    collectionReferences.docs.forEach((element) {
      Map<String, dynamic> mymap = element.data() as Map<String, dynamic>;
      mymap["pk"] = element.id;
      productModel.add(ProductModel.fromJson(mymap));
    });

    return productModel;
  }

  // Future<List<Map<String, dynamic>>> getAllProduct() async {
  //   List<Map<String, dynamic>> allproduct = [];
  //   QuerySnapshot collectionReferences = await firestoreReferences.get();
  //   collectionReferences.docs.forEach((element) {
  //     Map<String, dynamic> product = element.data() as Map<String, dynamic>;
  //     product["pk"] = element.id;
  //     allproduct.add(product);
  //   });
  //   return allproduct;
  // }

  // Future<List<Map<String, dynamic>>> getBanner() async {
  //   List<Map<String, dynamic>> banner = [];
  //   QuerySnapshot collectionReference = await firestoreReferences.get();
  //   collectionReference.docs.forEach((element) {
  //     Map<String, dynamic> map = element.data() as Map<String, dynamic>;
  //     map["pk"] = element.id;
  //     banner.add(map);
  //     // print(banner);
  //   });
  //   return banner;
  // }

  Future<List<BannerModel>> getBannerModel() async {
    List<BannerModel> bannerModel = [];
    QuerySnapshot collectionReference = await firestoreReferences.get();
    collectionReference.docs.forEach((element) {
      Map<String, dynamic> mymap = element.data() as Map<String, dynamic>;
      bannerModel.add(BannerModel.fromJson(mymap));
    });
    return bannerModel;
  }
}
