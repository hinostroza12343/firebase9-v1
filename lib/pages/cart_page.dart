import 'package:firebase_9_app/db/db_manager.dart';
import 'package:firebase_9_app/models/product_model.dart';
import 'package:firebase_9_app/models/sale_model.dart';
import 'package:firebase_9_app/services/firebase_services.dart';
import 'package:firebase_9_app/utils/preferences.dart';
import 'package:firebase_9_app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double total = 0;
  int quantity = 1;
  bool loading = false;
  ProductModel? productModel;
  List<ProductModel> listproduct = [];
  FirestoreService saleService = FirestoreService(collection: "SaleDetail");
  FirestoreService firestoreService = FirestoreService(collection: "productos");
  // APIService apiService = APIService();
  final preferences = CartPreference();
  SaleModel saleModel = SaleModel(total: 0, saleDetail: []);
  // final preferences = CartPreference();
  int aux = 0;
  @override
  void initState() {
    // TODO: implement initState
    getdata();
    // removeQuantity();
    loading = true;
    super.initState();
  }

  getmodal() {
    return showDialog(
        context: context,
        builder: (
          BuildContext context,
        ) {
          return AlertDialog(
            backgroundColor: const Color(0xff0A0D15),
            title: Center(
                child: Text(
              "Good lift..!",
              style: TextStyle(
                  color: Colors.white.withOpacity(0.90),
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            )),
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/weightlifting.svg",
                    // color:const Color(0xff4C1F39),
                    color: Colors.white,

                    fit: BoxFit.cover,
                    height: 100,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Aceptar",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w700,
                      fontSize: 15),
                ),
              ),
              // Text("Cancelar"),
            ],
          );
        });
  }

  String? img;
  String? name;
  String? marca;
  double? price2;
  getdata() {
    DBManager.db.getAllProducts().then((value) {
      listproduct = value;

      total = 0;
      listproduct.forEach((element) {
        total = total + element.quantity! * element.price;

        img = element.image.toString();
        name = element.name.toString();
        price2 = element.price;
        // marca = element.marca.toString();
        SaleDetail saleDetail = SaleDetail(
            // marca: element.marca.toString(),
            price2: element.price,
            image: element.image.toString(),
            name: element.name.toString(),
            quantity: element.quantity!,
            product: element.id!);
        saleModel.saleDetail.add(saleDetail);
      });
      saleModel.total = total;
      setState(() {});
    });
  }

  int counter = 0;

  saveQuantity() {
    productModel!.quantity = counter;
    DBManager.db.insertModel(productModel!).then((value) {
      print(productModel!.toJson());
      // getmodal();
      counter = preferences.quantity;
      preferences.quantity = counter - productModel!.quantity!;
      // saveQuantity();
      // setState(() {});
    });
    // widget.productModel!.quantity = counter;
    // print(widget.productModel!.toJson());

    // counter = preferences.quantity;
    // preferences.quantity = counter + 1;
    // setState(() {});
  }
 
  List<ProductModel> auxls = [];

  removeQuantity1() {
    // DBManager.db.getAllProducts2(1).then((value) {
    // productModel!.quantity = counter;
    DBManager.db.getAllProducts().then((value) {
      value.forEach((element) { 
        //   element.quantity;
        // preferences.quantity; 
        // preferences.quantity =
 preferences.quantity=preferences.quantity-element.quantity!-1 ;
        // element.quantity! > 0 ?
        // element.quantity! - preferences.quantity
        //     : 0;
        // print("-------VAMO ------> ${preferences.quantity}");
        // print("-xxx--VAMO ------> ${cantidad.toString()}");
              print("-xxx--VAMO ------> ${preferences.quantity.toString()}");
      });
    });
    // int q = preferences.quantity;
    // counter = preferences.quantity;
    // // preferences.quantity = q > 0 ? q - 1 : 0;
    // preferences.quantity = counter - productModel!.quantity!;
    // preferences.quantity = counter > 0 ? counter = aux : 0;
    setState(() {});
    // });
  } 

  removeQuantity2() {
    int q = preferences.quantity;
    preferences.quantity = q > 0 ? q=0  : 0;
    setState(() {});
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      backgroundColor: Color(0xff0A0D15),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45),
        child: AppBarWidget(
          titulo: "Mi carrito",
        ),
      ),
   
      body: listproduct.length != 0
          ? Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      FutureBuilder(
                        future: firestoreService.getProductModel(),
                        builder: (BuildContext context, AsyncSnapshot snap) {
                          if (snap.hasData) {
                            // List<ProductModel> aux=snap.data;
                            // return ListView.builder(
                            return ListView(
                                primary: true,
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                // itemCount:listproduct.length,
                                // itemBuilder: (BuildContext context, int index) {
                                children: listproduct
                                    .map(
                                      (e) => Dismissible(
                                        onDismissed: (DismissDirection) {
                                          DBManager.db.deleteProduct(e.id!);
                                          setState(() {
                                            getdata();
                                            removeQuantity2();
                                          });
                                          //  removeQuantity();
                                        },
                                        key: UniqueKey(),
                                        direction: DismissDirection.endToStart,
                                        background: Container(),
                                        secondaryBackground: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            // color: const Color(0xffE42121).withOpacity(0.75),
                                            color: const Color(0xffE42165)
                                                .withOpacity(0.05),
                                          ),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 35),
                                              child: Text(
                                                "Eliminar",
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.85),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 6.0, vertical: 7.0),
                                          decoration: BoxDecoration(
                                              color: const Color(0xff4C1F39),
                                              borderRadius:
                                                  BorderRadius.circular(14.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black12
                                                      .withOpacity(0.07),
                                                  blurRadius: 10,
                                                  offset: const Offset(0, 4),
                                                ),
                                              ]),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 100,
                                                height: 100,
                                                margin: const EdgeInsets.only(
                                                    right: 6.0),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          14.0),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        // "https://getstrong.es/wp-content/uploads/2021/10/dumbell-black-general.jpg",
                                                        e.image),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                               
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 12),
                                                      child: Text(
                                                        e.name,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.85),
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    Text(
                                                      e.price
                                                          .toStringAsFixed(2),
                                                      style: TextStyle(
                                                          color: Colors.white
                                                              .withOpacity(
                                                                  0.85),
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const SizedBox(
                                                      height: 4.0,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        DBManager.db
                                                            .deleteProduct(
                                                                e.id!);
                                                        setState(() {
                                                          getdata();
                                                          // removeQuantity1();
                                                          removeQuantity2();
                                                        });
                                                      },
                                                      child: Text(
                                                        "Remover",
                                                        style: TextStyle(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.85),
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                child: Column(
                                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 12),
                                                      child: Text(
                                                        "Cant.",
                                                        style: TextStyle(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.85),
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    Text(
                                                      e.quantity.toString(),
                                                      style: TextStyle(
                                                          color: Colors.white
                                                              .withOpacity(
                                                                  0.85),
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 12),
                                                      child: Text(
                                                        "Total",
                                                        style: TextStyle(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.85),
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 30,
                                                      width: 80,
                                                      child: Text(
                                                        "S/${e.price * e.quantity!.toDouble()}",
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        // "S/135",
                                                        style: TextStyle(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.85),
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList()

                                // },
                                );
                          }
                          return const SizedBox(
                            height: 250,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Color(0xffE42165),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 70.0,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
                    margin:
                        const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                    child: ElevatedButton.icon(
                      onPressed: quantity != 0
                          ? () {
                              print(saleModel.toJson());

                              saleService.saveSale(saleModel.toJson());

                              DBManager.db.deleteProduct2();
                              getdata();
                              getmodal();
                              removeQuantity2();

                              setState(() {
                                // loading = false;
                              });
                            }
                          : () {
                              // loading = false;
                            },
                      icon: const Icon(Icons.payment),
                      label:
                          Text("Total a pagarS/ ${total.toStringAsFixed(2)}"),
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff121212),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/weightlifting.svg',
                    color: Colors.white,
                    height: 130.0,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "No hay productos agregados",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
    );
  }
}
