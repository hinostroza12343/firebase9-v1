import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FirestoreService {
  bool? loading;
  String collection;
  FirestoreService({required this.collection,this.loading});
  late CollectionReference firestoreReferences =
      FirebaseFirestore.instance.collection(collection);

  Future<List<Map<String, dynamic>>> getCategorias1() async {
    List<Map<String, dynamic>> listcategorias = [];
    QuerySnapshot collectionReferences =
        await firestoreReferences.orderBy('order', descending: false).get();
    collectionReferences.docs.forEach((element) {
      Map<String, dynamic> categorias = element.data() as Map<String, dynamic>;

      categorias["id"] = element.id;
      listcategorias.add(categorias);
    });
    return listcategorias;
  }

  Future<List<Map<String, dynamic>>> getProduct(
      {required String category}) async {
    List<Map<String, dynamic>> allproduct = [];
    QuerySnapshot collectionReferences =
        await firestoreReferences.where('categoria', isEqualTo: category).get();
    collectionReferences.docs.forEach((element) {
      Map<String, dynamic> product = element.data() as Map<String, dynamic>;
      product["id"] = element.id;
      allproduct.add(product);
    });
    return allproduct;
  }

  Future<List<Map<String, dynamic>>> getAllProduct() async {
    List<Map<String, dynamic>> allproduct = [];
    QuerySnapshot collectionReferences = await firestoreReferences.get();
    collectionReferences.docs.forEach((element) {
      Map<String, dynamic> product = element.data() as Map<String, dynamic>;
      product["id"] = element.id;
      allproduct.add(product);
    });
    return allproduct;
  }
}
