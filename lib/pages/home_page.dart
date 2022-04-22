import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  List categorias = [];
  @override
  void initState() {
    super.initState();
    getCategorias();
    getCategorias2();  
  } 

  getCategorias2() {
    categorias.clear();
    collection.get().then((value) {
      value.docs.map((e) {

        print(".......--------->${e.data()}");
        setState(() {});
      }).toList();
      // print("xxxxxxxxxx> ${categorias}");
    });
  }

  getCategorias() {
    categorias.clear();
    collection.get().then((value) {
      value.docs.map((e) {
        Map<String, dynamic> myMap = e.data() as Map<String, dynamic>;
        categorias.add(myMap);
        setState(() {});
      }).toList();
    print("xxxxxxxxxxZzz> ${categorias}");
    });
  }

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
      floatingActionButton: FloatingActionButton(onPressed: () {
        getCategorias();
      }),
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
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => CartPage(),
                      //     ));
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
      drawer: Drawer(),
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
                              // future: getCategorias(),
                              builder:
                                  (BuildContext context, AsyncSnapshot snap) {
                            // if (snap.hasData) {
                            // List aux123 = snap.data;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                categorias.length,
                                (index) => Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //         ProductListPage()));
                                    },
                                    child: Chip(
                                      shadowColor: const Color(0xffE42165)
                                          .withOpacity(0.90),
                                      avatar: SvgPicture.asset(
                                        "assets/images/weightlifting.svg",
                                        fit: BoxFit.cover,
                                        height: 23,
                                        color: Colors.white,
                                      ),
                                      backgroundColor: const Color(0xffE42165),
                                      elevation: 1,
                                      label: Text(
                                        categorias[index]["descripcion"],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                            // }
                            // return Container(child: Text("Categorias"),);

                            // return const LinearProgressIndicator(
                            //   color: Color(0xffE42165),
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
                                    // Navigator.push(context, MaterialPageRoute(
                                    //   builder: (context) {
                                    //     return ProductListPage();
                                    //   },
                                    // ));
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
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Lo mas Comprado",
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Container(
                          constraints: const BoxConstraints(
                            maxHeight: 245,
                            maxWidth: double.infinity,
                          ),
                          child: ListView.builder(
                            primary: true,
                            physics: const ScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: 12,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => ProductDetailPage(
                                  //             product: product2[index],
                                  //           )),
                                  // );
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  height: 200,
                                  width: 240,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff1E1E2C),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Stack(
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 180,
                                            width: 200,
                                            decoration: BoxDecoration(
                                              // color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    // product2[index].image
                                                    "https://getstrong.es/wp-content/uploads/2021/10/dumbell-black-general.jpg"),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 8),
                                              decoration: BoxDecoration(
                                                color: const Color(0xffE42165)
                                                    .withOpacity(0.23),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Container(
                                                  margin:
                                                      const EdgeInsets.all(8),
                                                  child: Text(
                                                    "Nombre",
                                                    style: TextStyle(
                                                        color: Colors.white
                                                            .withOpacity(0.85),
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 8),
                                          decoration: BoxDecoration(
                                            color: const Color(0xffE42165),
                                            borderRadius:
                                                BorderRadius.circular(19),
                                          ),
                                          child: Container(
                                            margin: const EdgeInsets.all(8),
                                            child: Text(
                                              // "S/.${product2[index].price.toString()}",
                                              "S/132",
                                              style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.85),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )

                      //  FutureBuilder(
                      //     future:getallData(),
                      //     builder: (BuildContext context, AsyncSnapshot snap) {
                      //       if (snap.hasData) {
                      //           product2=snap.data;
                      //         // List aux = snap.data;
                      //         // List<ProductModel> aux=snap.data;
                      //         return ListView.builder(
                      //             primary: true,
                      //             physics: const ScrollPhysics(),
                      //             scrollDirection: Axis.horizontal,
                      //             shrinkWrap: true,
                      //             itemCount: product2.length,
                      //             itemBuilder: (BuildContext context, int index) {
                      //               return GestureDetector(
                      //                 onTap: () {
                      //                   // Navigator.push(
                      //                   //   context,
                      //                   //   MaterialPageRoute(
                      //                   //       builder: (context) =>
                      //                   //           ProductDetailPage(
                      //                   //             product: aux[index],
                      //                   //           )),
                      //                   // );
                      //                 },
                      //                 child: Container(
                      //                   margin: const EdgeInsets.symmetric(
                      //                       horizontal: 10),
                      //                   height: 200,
                      //                   width: 240,
                      //                   decoration: BoxDecoration(
                      //                     color: const Color(0xff1E1E2C),
                      //                     borderRadius: BorderRadius.circular(12),
                      //                   ),
                      //                   child: Stack(
                      //                     children: [
                      //                       Column(
                      //                         mainAxisSize: MainAxisSize.max,
                      //                         crossAxisAlignment:
                      //                             CrossAxisAlignment.center,
                      //                         mainAxisAlignment:
                      //                             MainAxisAlignment.center,
                      //                         children: [
                      //                           Container(
                      //                             height: 180,
                      //                             width: 200,
                      //                             decoration: BoxDecoration(
                      //                               borderRadius:
                      //                                   BorderRadius.circular(12),
                      //                               image: DecorationImage(
                      //                                 fit: BoxFit.cover,
                      //                                 image: NetworkImage(
                      //                                     product2[index].image),
                      //                               ),
                      //                             ),
                      //                           ),
                      //                           Align(
                      //                             alignment:
                      //                                 Alignment.bottomCenter,
                      //                             child: Container(
                      //                               margin: const EdgeInsets
                      //                                       .symmetric(
                      //                                   vertical: 8,
                      //                                   horizontal: 8),
                      //                               decoration: BoxDecoration(
                      //                                 color:
                      //                                     const Color(0xffE42165)
                      //                                         .withOpacity(0.23),
                      //                                 borderRadius:
                      //                                     BorderRadius.circular(
                      //                                         12),
                      //                               ),
                      //                               child: Container(
                      //                                   margin:
                      //                                       const EdgeInsets.all(
                      //                                           8),
                      //                                   child: Text(
                      //                                     product2[index].name,
                      //                                     style: TextStyle(
                      //                                         color: Colors.white
                      //                                             .withOpacity(
                      //                                                 0.85),
                      //                                         fontSize: 13,
                      //                                         fontWeight:
                      //                                             FontWeight
                      //                                                 .w700),
                      //                                   )),
                      //                             ),
                      //                           ),
                      //                         ],
                      //                       ),
                      //                       Align(
                      //                         alignment: Alignment.topRight,
                      //                         child: Container(
                      //                           margin:
                      //                               const EdgeInsets.symmetric(
                      //                                   vertical: 15,
                      //                                   horizontal: 8),
                      //                           decoration: BoxDecoration(
                      //                             color: const Color(0xffE42165),
                      //                             borderRadius:
                      //                                 BorderRadius.circular(18),
                      //                           ),
                      //                           child: Container(
                      //                             margin: const EdgeInsets.all(8),
                      //                             child: Text(
                      //                               "S/.${product2[index].price.toString()}",
                      //                               style: TextStyle(
                      //                                   color: Colors.white
                      //                                       .withOpacity(0.85),
                      //                                   fontSize: 16,
                      //                                   fontWeight:
                      //                                       FontWeight.w700),
                      //                             ),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               );
                      //             });
                      //       }
                      //       return const Center(
                      //           child: CircularProgressIndicator(
                      //         color: Color(0xffE42165),
                      //       ));
                      //     }),
                      ,
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Las mejores Marcas",
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
                      // FutureBuilder(
                      //     future: getBrand(),
                      //     builder: (BuildContext context, AsyncSnapshot snap) {
                      //       if (snap.hasData) {
                      //         List auxmarcas = snap.data;
                      //         return
                      //       }
                      //       return Container();
                      //       // return const Center(
                      //       //     child: CircularProgressIndicator(
                      //       //   color: Color(0xffE42165),
                      //       // ));
                      //     }),
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
                                child: GridView.count(
                                  crossAxisCount: 2,
                                  primary: true,
                                  shrinkWrap: true,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  physics: const ScrollPhysics(),
                                  children: imgList.map((e) {
                                    return Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              "https://getstrong.es/wp-content/uploads/2021/10/dumbell-black-general.jpg"),
                                        ),
                                      ),
                                      // child:Text(e["brand"]),
                                    );
                                  }).toList(),
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
