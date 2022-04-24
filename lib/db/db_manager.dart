import 'dart:io';
import 'package:firebase_9_app/models/product_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {
  static Database? _database;
  static final DBManager db = DBManager._();
  DBManager._();
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'ecommerce.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE Product(id INTEGER , brand TEXT, name TEXT, price REAL, quantity INTEGER, image TEXT)");
    });
  }

  Future<int> insertRaw(ProductModel productHModel) async {
    final db = await database;
    final int res = await db!.rawInsert(
        "INSERT INTO Product(id,brand,name,price,quantity,image) VALUES "
        "(${productHModel.id},'${productHModel.marca}','${productHModel.name}', ${productHModel.price},${productHModel.quantity},'${productHModel.image}' )");
    print(res);
    return res;
  }

  Future<int> insertModel(ProductModel productModel) async {
    final db = await database;
    // int res = await db!.insert("Product", productModel.toJson());
    int res = await db!.rawInsert(
        "INSERT INTO Product(id, brand, name, price, quantity, image) VALUES (${productModel.id}, '${productModel.marca}', '${productModel.name}', ${productModel.price}, ${productModel.quantity}, '${productModel.image}')");
    print(res);
    return res;
  }

  Future<int> deleteProduct(int id) async {
    final db = await database;
    final int res = await db!.delete("Product", where: "id = $id");
    print("Eliminado ${res}");
    return res;
  }

  Future<int> deleteProduct2() async {
    final db = await database;
    final int res = await db!.delete("Product");
    print("Eliminado ${res}");
    return res;
  } 
   
   Future<List<ProductModel>> getAllProducts() async {
    final db = await database;
    List<Map<String, dynamic>> res = await db!.query("Product");
    List<ProductModel> listProductModel = res.isNotEmpty
        ? res.map((e) => ProductModel.fromJson(e)).toList()
        : [];
    // print(listProductModel);
    print(res);
    return listProductModel;
  }

}
  // Future<List<ProductModel>> getProduct() async {
  //   final db = await database;
  //   List<Map<String, dynamic>> res = await db!.query("Product");
  //   List<ProductModel> listProductModel =
  //       res.isNotEmpty ? res.map((e) => ProductModel.fromJson(e)).toList() : [];
  //   //print(listProductModel);
  //   print("LISTA DE PRODUCTOS  ---------> ${res}");
  //   return listProductModel;
  // }
 
   // Future<void> insertOjala(ProductModel productoPorfa) async {
  //   final db = await database;
  //   int res = await db!.insert("Product", productoPorfa.toJson());
  //   // return res;
  // }

  // insertProduct() async {
  //   final db = await database;
  //   // int res = await db!.insert("Product", productModel.toJson());
  //   int res = await db!.rawInsert(
  //       "INSERT INTO Product(id, brand, name, price, quantity, image) VALUES "
  //       " )");

  //   print(res);
  //   return res;
  // }
  
//   Future getAllProducts() async {
//     final db = await database;
//     final List res = await db!.rawQuery("select *from Product");
// //    print("LISTA DE BASE DE DATOSSSSSSSSSSSS ${res}");
  // }

// }
