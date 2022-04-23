import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_9_app/pages/cart_page.dart';
import 'package:firebase_9_app/pages/producl_Detail_page.dart';
import 'package:firebase_9_app/pages/product_List_page.dart';
import 'package:firebase_9_app/services/firebase_services.dart';
import 'package:firebase_9_app/widgets/Item_Text_Titulos.dart';
import 'package:firebase_9_app/widgets/Item_widget.dart';
import 'package:firebase_9_app/widgets/category_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference collection =
      FirebaseFirestore.instance.collection("categorias");
  FirestoreService collectionCategory =
      FirestoreService(collection: "categorias");
  FirestoreService collectionProduc = FirestoreService(collection: "productos");
  List categorias = [];
  List categorias2 = [];

  @override
  void initState() {
    super.initState();
    // getCategorias();
    // getCategorias2();
    // getAllCaterorias();
  }

  // getAllCaterorias() {
  //   _firestoreService.getCategorias1().then((value) {
  //     categorias2 = value;
  //     setState(() {});
  //   });
  // }

  // getCategorias2() {
  //   categorias.clear();
  //   collection.get().then((value) {
  //     value.docs.map((e) {
  //       print(".......--------->${e.data()}");
  //       setState(() {});
  //     }).toList();
  //     // print("xxxxxxxxxx> ${categorias}");
  //   });
  // }

  // getCategorias() {
  //   categorias.clear();
  //   collection.get().then((value) {
  //     value.docs.map((e) {
  //       Map<String, dynamic> myMap = e.data() as Map<String, dynamic>;
  //       categorias.add(myMap);
  //       setState(() {});
  //     }).toList();
  //     print("xxxxxxxx> ${categorias}");
  //   });
  // }

  int _current = 0;
  final CarouselController _controller = CarouselController();
  List<String> imgList = [
    "https://www.lifefitness-latinamerica.com/resource/image/773030/landscape_ratio8x3/1144/429/fd594ba43ca3baf1c4c7ae1289545ebc/ww/male-bench-press-hde-rack-4769-mr.jpg",
    "https://getstrong.es/wp-content/uploads/2020/09/power-rack-jaula-potencia.jpg",
    "https://getstrong.es/wp-content/uploads/2015/11/soporte-barras.jpg",
    "https://getstrong.es/wp-content/uploads/2017/06/HI-TEMP_GENERAL.jpg",
  ];
  bool loading = false;
  List banner = [];
  // List categorias = [];
  List brand = [];
  bool activo = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //    getCategorias();
      // }),
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
              IconButton(
                onPressed: () {
                  // FirestoreService firestoreService = FirestoreService();
                  // firestoreService.getCategorias1();

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => CartPage(),
                  //     ));
                },
                icon: const Icon(Icons.search_outlined, color: Colors.white),
              ),
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
                  activo
                      ? const Positioned(
                          right: 9,
                          top: 8,
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor: Color(0xffE42165),
                            child: Center(
                              child: Text(
                                "",
                                //  "   preferences.quantity.toString(),"
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xff0A0D15),
      drawer: Drawer(
        child: DrawerHeader(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Center(
                    child: Text(
                      "Menu",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 145,
              ),
              const ListTile(
                leading: Icon(Icons.settings_applications_outlined,
                    color: Colors.grey),
                title: Text(
                  "Rutinas",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  "Halterofilia",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.grey),
                ),
                trailing: Icon(Icons.check, color: Colors.grey),
              ),
              const Divider(
                thickness: 0.9,
                color: Colors.grey,
              )
            ],
          ),
        ),
        backgroundColor: Color(0xff0A0D15).withOpacity(0.95),
      ),
      body: loading == true
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xffE42165)),
            )
          : Stack(children: [
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 2,
                      ),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const ScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FutureBuilder(
                              future: collectionCategory.getCategorias1(),
                              builder:
                                  (BuildContext context, AsyncSnapshot snap) {
                                if (snap.hasData) {
                                  List<Map<String, dynamic>> aux123 = snap.data;
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      aux123.length,
                                      (index) => Category_widget(
                                        categoria: aux123[index]["descripcion"],
                                        goTo: ProductListPage(),
                                      ),
                                    ),
                                  );
                                }
                                return Container();

                                // return const LinearProgressIndicator(
                                //    color: Color(0xffE42165),
                              }),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Promociones",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              height: 8,
                              width: 8,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffE42165),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      // FutureBuilder(
                      //     future: getBanner(),
                      //     builder: (BuildContext context, AsyncSnapshot snap) {
                      //       if (snap.hasData) {
                      //         List aux321 = snap.data;
                      //         return
                      //       }
                      //       return Container();
                      //       // const Center(
                      //       //     child: CircularProgressIndicator(
                      //       //   color: Color(0xffE42165),
                      //       // ));
                      //     }),
                      CarouselSlider(
                          items: imgList
                              .map<Widget>(
                                (e) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return ProductListPage();
                                      },
                                    ));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    height: 250,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            "https://getstrong.es/wp-content/uploads/2021/10/dumbell-black-general.jpg"),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          options: CarouselOptions(
                              height: 220,
                              autoPlay: true,
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 1800),
                              onPageChanged: (int index, _) {
                                _current = index;
                                setState(() {});
                              })),
                      // FutureBuilder(
                      //     future: getBanner(),
                      //     builder: (BuildContext context, AsyncSnapshot snap) {
                      //       if (snap.hasData) {
                      //         List auxiliar = snap.data;
                      //         return
                      //       }
                      //       return Container();
                      //     }),

                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: imgList.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => _controller.animateToPage(entry.key),
                              child: Container(
                                width: 8.0,
                                height: 8.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Color(0xffE42165))
                                        .withOpacity(
                                            _current == entry.key ? 0.9 : 0.4)),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      // Container(
                      //   margin:
                      //       const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      //   child: Row(
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     // mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       const Text(
                      //         "Lo mas Comprado",
                      //         style: TextStyle(
                      //             color: Colors.white,
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 20),
                      //       ),
                      //       const SizedBox(
                      //         width: 5,
                      //       ),
                      //       Container(
                      //         height: 8,
                      //         width: 8,
                      //         decoration: const BoxDecoration(
                      //           shape: BoxShape.circle,
                      //           color: Color(0xffE42165),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding:
                      //       const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      //   child: Container(
                      //     constraints: const BoxConstraints(
                      //       maxHeight: 200,
                      //       maxWidth: 330,
                      //     ),
                      //     child: ListView.builder(
                      //         primary: true,
                      //         physics: const ScrollPhysics(),
                      //         scrollDirection: Axis.horizontal,
                      //         shrinkWrap: true,
                      //         itemCount: 10,
                      //         itemBuilder: (BuildContext context, int index) {
                      //           return Container(
                      //             margin: const EdgeInsets.symmetric(horizontal: 10),
                      //             height: 200,
                      //             width: 240,
                      //             decoration: BoxDecoration(
                      //               color: const Color(0xff1E1E2C),
                      //               borderRadius: BorderRadius.circular(12),
                      //             ),
                      //             child: Stack(
                      //               children: [
                      //                 Row(
                      //                   mainAxisAlignment: MainAxisAlignment.center,
                      //                   children: [
                      //                     Center(
                      //                       child: Container(
                      //                         height: 180,
                      //                         width: 200,
                      //                         decoration: BoxDecoration(
                      //                           borderRadius:
                      //                               BorderRadius.circular(12),
                      //                           image: const DecorationImage(
                      //                             fit: BoxFit.cover,
                      //                             image: NetworkImage(
                      //                                 "https://getstrong.es/wp-content/uploads/2015/11/disco-training-color-para-crossfit.jpg"),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 Align(
                      //                   alignment: Alignment.topRight,
                      //                   child: Container(
                      //                     margin: const EdgeInsets.symmetric(
                      //                         vertical: 15, horizontal: 8),
                      //                     decoration: BoxDecoration(
                      //                       color: const Color(0xffE42165),
                      //                       borderRadius: BorderRadius.circular(18),
                      //                     ),
                      //                     child: Container(
                      //                       margin: const EdgeInsets.all(8),
                      //                       child: Text(
                      //                         "S/.1090",
                      //                         style: TextStyle(
                      //                             color:
                      //                                 Colors.white.withOpacity(0.85),
                      //                             fontSize: 16,
                      //                             fontWeight: FontWeight.w700),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           );
                      //         }),
                      //   ),
                      // ),
                      Item_TextTitulos(titulo: "Barras y Discos"),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Container(
                          constraints: const BoxConstraints(
                            maxHeight: 245,
                            maxWidth: double.infinity,
                          ),
                          child: FutureBuilder(
                            future: collectionProduc.getProduct(
                                category: "lZEJErlTGD8R3bmhH6Ra"),
                            builder:
                                (BuildContext context, AsyncSnapshot snap) {
                              if (snap.hasData) {
                                List<Map<String, dynamic>> aux2 = snap.data;
                                return ListView.builder(
                                  primary: true,
                                  physics: const ScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: aux2.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ItemWidget(
                                      image: aux2[index]["image"],
                                      nombre: aux2[index]["name"],
                                      price: aux2[index]["price"],
                                      goTo: ProductDetailPage(
                                        product: aux2[index],
                                      ),
                                    );
                                  },
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                      ),
                      Item_TextTitulos(titulo: "Rack de Potencia"),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Container(
                          constraints: const BoxConstraints(
                            maxHeight: 245,
                            maxWidth: double.infinity,
                          ),
                          child: FutureBuilder(
                            future: collectionProduc.getProduct(
                                category: "m0uLlO3auZRUSAlZ5a7b"),
                            builder:
                                (BuildContext context, AsyncSnapshot snap) {
                              if (snap.hasData) {
                                List<Map<String, dynamic>> aux2 = snap.data;
                                return ListView.builder(
                                  primary: true,
                                  physics: const ScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: aux2.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ItemWidget(
                                      image: aux2[index]["image"],
                                      nombre: aux2[index]["name"],
                                      price: aux2[index]["price"],
                                      goTo: ProductDetailPage(
                                          product: aux2[index]),
                                    );
                                  },
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                      ),
                      Item_TextTitulos(
                          titulo: "Productos que te pueden interesar"),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff1E1E2C),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: FutureBuilder(
                                  future: collectionProduc.getAllProduct(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snap) {
                                    if (snap.hasData) {
                                      List<Map<String, dynamic>> aux =
                                          snap.data;
                                      return GridView.count(
                                        crossAxisCount: 2,
                                        primary: true,
                                        shrinkWrap: true,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        physics: const ScrollPhysics(),
                                        children: aux.map((e) {
                                          return Container(
                                            height: 100,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  e["image"],
                                                ),
                                                //  "https://getstrong.es/wp-content/uploads/2021/10/dumbell-black-general.jpg"),
                                              ),
                                            ),
                                            // child:Text(e["brand"]),
                                          );
                                        }).toList(),
                                      );
                                    }
                                    return Container();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ]),
    );
  }
}
