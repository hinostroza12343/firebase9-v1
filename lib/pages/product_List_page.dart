import 'package:firebase_9_app/models/product_model.dart'; 
import 'package:firebase_9_app/pages/producl_Detail_page.dart';
import 'package:firebase_9_app/services/firebase_services.dart';
import 'package:firebase_9_app/widgets/ItemAll_Product_ID.dart';
import 'package:firebase_9_app/widgets/Item_Product_ID.dart';
import 'package:firebase_9_app/widgets/app_bar.dart';
import 'package:firebase_9_app/widgets/category_widget.dart';
import 'package:flutter/material.dart';

class   ProductListPage extends StatefulWidget {
  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  FirestoreService collectionProduc =
      FirestoreService(collection: "productos");

  @override
  void initState() {
    super.initState();
  }

  bool loading = true;
  List banner = [];
  List brand = []; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0A0D15),
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(45),
        child: AppBarWidget( titulo: "Gymshark"),),
      body: loading == false
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xffE42165),
              ),
            )
          : Stack(
            children:[
               SingleChildScrollView(
              primary: true,
              child: Column(
                children: [
                const  SizedBox(height: 50,),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: SafeArea(
                        child: FutureBuilder(
                          future: collectionProduc.getProductModel(),
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
                ],
              ),
            ),Container(
                  height: 55,
                  decoration: const BoxDecoration(color: Color(0xff0A0D15)),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const ScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        child: Row(
                          children: [
                            Category_widget(
                                categoria: "TODOS", goTo: ProductListPage()),
                            Category_widget(
                                categoria: "EQUIPAMIENTO",
                                goTo: ItemAllProductID(
                                  futuro: collectionProduc.getProductModelID(
                                      id: "lZEJErlTGD8R3bmhH6Ra"),
                                )),
                            Category_widget(
                                categoria: "RACKS Y JAULAS",
                                goTo: ItemAllProductID(
                                  futuro: collectionProduc.getProductModelID(
                                      id: "m0uLlO3auZRUSAlZ5a7b"),
                                )),
                            Category_widget(
                                categoria: "SUELO",
                                goTo: ItemAllProductID(
                                  futuro: collectionProduc.getProductModelID(
                                      id: "xZ9jQSveAfchJc5hju6O"),
                                )),
                            Category_widget(
                                categoria: "CARDIO",
                                goTo: ItemAllProductID(
                                  futuro: collectionProduc.getProductModelID(
                                      id: "rxXC3GceXVcuEvnCz0PX"),
                                )),
                            Category_widget(
                                categoria: "COMPLEMENTOS",
                                goTo: ItemAllProductID(
                                  futuro: collectionProduc.getProductModelID(
                                      id: "Xa88OclLjwu80qIfpYDY"),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
    );
  }
}
