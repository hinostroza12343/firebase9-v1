import 'package:firebase_9_app/models/product_model.dart';
import 'package:firebase_9_app/pages/cart_page.dart';
import 'package:firebase_9_app/pages/home_page.dart';
import 'package:firebase_9_app/pages/producl_Detail_page.dart';
import 'package:firebase_9_app/services/firebase_services.dart';
import 'package:firebase_9_app/widgets/Item_Product_ID.dart';
import 'package:flutter/material.dart';

class RackListPage extends StatelessWidget {
 FirestoreService firestoreServiceProduct =
      FirestoreService(collection: "productos");
  @override
  Widget build(BuildContext context) {
  bool loading = true; 
 
    return Scaffold(
      backgroundColor: const Color(0xff0A0D15),
      appBar: AppBar(
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
                "GymShark",
                style: TextStyle(
                    color: Colors.white.withOpacity(0.75),
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ),
          trailing: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartPage(),
                          ));
                    },
                    icon: const Icon(Icons.shopping_cart_sharp,
                        color: Colors.white),
                  ),
                
                ],
              ),
            ],
          ),
        ),
      ),
      body: loading == false
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xffE42165),
              ),
            )
          : Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: SafeArea(
                child: FutureBuilder(
                  future: firestoreServiceProduct.getProductModelID(
                      id: "m0uLlO3auZRUSAlZ5a7b"),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      List<ProductModel> aux = snapshot.data;
                      return GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 1,
                        childAspectRatio: 0.72,
                        primary: true,
                        shrinkWrap: true,
                        // crossAxisSpacing: 10,
                        // mainAxisSpacing: 10,
                        physics: const ScrollPhysics(),
                        children: List.generate(
                            aux.length,
                            (index) => ItemListProductID(
                                name: aux[index].name,
                                image: aux[index].image,
                                price: aux[index].price,
                                goto: ProductDetailPage(
                                  productModel: aux[index],
                                ))),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
    );
  }
}
