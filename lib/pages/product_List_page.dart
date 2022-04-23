import 'package:firebase_9_app/pages/cart_page.dart';
import 'package:firebase_9_app/pages/home_page.dart';
import 'package:firebase_9_app/pages/producl_Detail_page.dart';
import 'package:firebase_9_app/services/firebase_services.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatefulWidget {
  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  FirestoreService firestoreServiceProduct=FirestoreService(collection: "productos");

  @override
  void initState() { 
    super.initState();
    
  }

  bool loading = true;
  List banner = [];
  // List categorias = [];
  List brand = [];
  bool activo = true;
  @override
  Widget build(BuildContext context) {
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
      body: loading == false
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xffE42165),
              ),
            )
          : Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: SafeArea(
                child:FutureBuilder(
                  future: firestoreServiceProduct.getAllProduct(),
                  builder: (BuildContext context,AsyncSnapshot snapshot){
                      if(snapshot.hasData){
                        List<Map<String,dynamic>> aux=snapshot.data;
                         return  GridView.count(
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
                      (index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailPage(
                                  product: aux[index],
                                  // product: product2[index],
                                ),
                              ));
                        },
                        child: Container(
                          margin:
                              const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Column(
                            children: [
                              Container(
                                height: 160.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.transparent,
                                  image:  DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                      //     "https://getstrong.es/wp-content/uploads/2021/10/dumbell-black-general.jpg")
                                      aux[index]["image"]),
                                      ),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      right: 10.0,
                                      top: 10.0,
                                      child: Icon(
                                        Icons.more_vert,
                                        color: Color(0xffE42165),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                         aux[index]["name"]
                                                .toString()
                                                .toUpperCase(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                                fontSize: 13.0,
                                                height: 1.2),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                        Text(
                                            "S/${aux[index]["price"]}",
                                            style:const   TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(
                                      Icons.favorite_border,
                                      color: Color(0xffE42165),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                        }
                      return Container();
                  },
                 
                ),

                //   GridView.count(
                //              crossAxisCount: 2,
                //           crossAxisSpacing: 1,
                //           childAspectRatio: 0.72,
                //           primary: true,
                //           shrinkWrap: true,
                //   children: product2
                //       .map<Widget>(
                //         (e) => GestureDetector(
                //           onTap: () {
                //             // Navigator.push(
                //             //   context,
                //             //   MaterialPageRoute(
                //             //     builder: (context) => ProductDetailPage(
                //             //       sneaker: e,
                //             //     ),
                //             //   ),
                //             // );
                //           },
                //           child: Container(
                //             margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                //             child: Column(
                //               children: [
                //                 Container(
                //                   height: 160.0,
                //                   decoration: BoxDecoration(
                //                     borderRadius: BorderRadius.circular(20.0),
                //                     color: Colors.transparent,
                //                     image: DecorationImage(
                //                       fit: BoxFit.cover,
                //                       image: NetworkImage(e.image),
                //                     ),
                //                   ),
                //                   child: Stack(
                //                     children: [
                //                       Positioned(
                //                         right: 10.0,
                //                         top: 10.0,
                //                         child: Icon(
                //                           Icons.more_vert,
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //                 Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Row(
                //                     crossAxisAlignment: CrossAxisAlignment.center,
                //                     children: [
                //                       Expanded(
                //                         child: Column(
                //                           crossAxisAlignment: CrossAxisAlignment.start,
                //                           children: [
                //                             Text(
                //                               e.name.toString().toUpperCase(),
                //                               style: TextStyle(
                //                                   fontWeight: FontWeight.bold,
                //                                   color: Color(0xff121212),
                //                                   fontSize: 13.0,
                //                                   height: 1.2),
                //                               maxLines: 2,
                //                               overflow: TextOverflow.ellipsis,
                //                             ),
                //                             SizedBox(
                //                               height: 6,
                //                             ),
                //                             Text(
                //                               "S/ ${e.price}",
                //                               style: TextStyle(
                //                                   fontWeight: FontWeight.normal,
                //                                   fontSize: 12.0,
                //                                   color: Color(0xff121212)),
                //                             ),
                //                           ],
                //                         ),
                //                       ),
                //                       Icon(Icons.favorite_border)
                //                     ],
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       )
                //       .toList(),
                // ),
              ),
            ),
    );
  }
}
