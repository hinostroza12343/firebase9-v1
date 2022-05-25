import 'package:firebase_9_app/pages/Prueba.dart';
import 'package:firebase_9_app/pages/cart_page.dart';
import 'package:firebase_9_app/pages/home_page.dart';
import 'package:firebase_9_app/services/firebase_services.dart';
import 'package:firebase_9_app/utils/preferences.dart';
import 'package:firebase_9_app/utils/search_product.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  FirestoreService collectionProduct =
      FirestoreService(collection: "productos");
  bool? activo;
  String titulo;
  AppBarWidget({required this.titulo});
  final preferences = CartPreference();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: ListTile(
        title: Center(
          child: TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return HomePage();
                },
              ));
            },
            child: Text(
              "Gymshark",
              style: TextStyle(
                  color: Colors.white.withOpacity(0.95),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ),
        trailing: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                Icons.search,
                size: 25,
                color: Colors.white.withOpacity(0.95),
              ),
              onPressed: () async {
                final result = await showSearch(
                  context: context,
                  delegate: SearchProduct(
                    productos: await collectionProduct.getProductModel(),
                  ),
                );
              },
            ),
            Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: IconButton(
                    icon: Icon(
                      Icons.shopping_cart_rounded,
                      size: 28,
                      color: Colors.white.withOpacity(0.95),
                    ),
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartPage(),
                          ));
                    },
                  ),
                ),
                preferences.quantity != 0
                    ? 
                    Positioned(
                        right: 11,
                        top: 15,
                        child: CircleAvatar(
                          radius: 7,
                          backgroundColor: const Color(0xffE42165),
                          child: Center(
                              child: 
                              // preferences.quantity != 0
                              //     ?
                                   Text(
                                      preferences.quantity.toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11),
                                    )
                                  // : const Text(
                                  //     "",
                                  //     style: TextStyle(
                                  //       color: Colors.white,
                                  //       fontWeight: FontWeight.bold,
                                  //       fontSize: 11,
                                  //     ),
                                  //   ),
                                    ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
