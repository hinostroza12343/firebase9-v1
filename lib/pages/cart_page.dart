import 'package:firebase_9_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double total = 0;

  List<ProductModel> listproduct = [];
  // APIService apiService = APIService();
  // SaleModel saleModel = SaleModel(total: 0, saleDetail: []);
  // final preferences = CartPreference();

  @override
  void initState() {
    // TODO: implement initState
    // getdata();
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

  // getdata() {
  //   DBManager.db.getallProduct().then((value) {
  //     listproduct = value;
  //     total = 0;
  //     listproduct.forEach((element) {
  //       total = total + element.quantity! * element.price;
  //       SaleDetail saleDetail =
  //           SaleDetail(quantity: element.quantity!, product: element.id);
  //       saleModel.saleDetail.add(saleDetail);
  //     });
  //     saleModel.total = total;
  //     setState(() {});
  //   });

  //   // apiService.getProduct().then((value) {
  //   //   listproduct = value;
  //   //   setState(() {});
  //   // });
  // }

  // removeQuantity() {
  //   int q = preferences.quantity;
  //   preferences.quantity = q > 0 ? q - 1 : 0;
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff0A0D15),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: ListTile(
            title: Text(
              "Mi carrito",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ),
        body:
            //  listproduct.length != 0
            listproduct == []
                ? Center(
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
                  )
                : Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                              primary: true,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: 15,
                              itemBuilder: (BuildContext context, int index) {
                                return Dismissible(
                                  // onDismissed: (DismissDirection) {
                                  //     DBManager.db.deleteProduct(
                                  //                     listproduct[index].id);
                                  //                 setState(() {
                                  //                   getdata();
                                  //                 });
                                  //    removeQuantity();
                                  // },
                                  key: UniqueKey(),
                                  direction: DismissDirection.endToStart,
                                  background: Container(),
                                  secondaryBackground: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      // color: const Color(0xffE42121).withOpacity(0.75),
                                      color: const Color(0xffE42165)
                                          .withOpacity(0.05),
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 35),
                                        child: Text(
                                          "Eliminar",
                                          style: TextStyle(
                                              color: Colors.white
                                                  .withOpacity(0.85),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
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
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 100,
                                          margin:const  EdgeInsets.only(right: 6.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14.0),
                                            image:const  DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                "https://getstrong.es/wp-content/uploads/2021/10/dumbell-black-general.jpg",
                                                // listproduct[index].image
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                            "Mancuernas",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.85),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Text(
                                              "Active Life",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.85),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                             "S/212",
                                                    
                                                    // .toStringAsFixed(2),
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.85),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                             const  SizedBox(
                                                height: 4.0,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  // DBManager.db.deleteProduct(
                                                  //     listproduct[index].id);
                                                  // setState(() {
                                                  //   getdata();
                                                  // });
                                                },
                                                child: Text(
                                                  "Remover",
                                                  style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(0.85),
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      decoration: TextDecoration
                                                          .underline),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Cant.",
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.85),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                "5",
                                                // listproduct[index]
                                                //     .quantity
                                                //     .toString(),
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.85),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Total",
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.85),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                // "S/${listproduct[index].price * listproduct[index].quantity!}",
                                                "S/135",
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.85),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
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
                          margin: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 8),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // print(saleModel.toJson());
                              // apiService.saveSale(saleModel);
                              // getmodal();
                              // DBManager.db.deleteAllProduct();
                              // getdata();
                              //        removeQuantity();

                              setState(() {});
                            },
                            icon: const Icon(Icons.payment),
                            label: Text(
                                "Total a pagar S/${total.toStringAsFixed(2)}"),
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xff121212),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ));
  }
}
