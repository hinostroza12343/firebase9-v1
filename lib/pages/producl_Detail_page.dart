import 'package:firebase_9_app/db/db_manager.dart';
import 'package:firebase_9_app/models/product_model.dart'; 
import 'package:firebase_9_app/services/firebase_services.dart';
import 'package:firebase_9_app/utils/preferences.dart';
import 'package:firebase_9_app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductDetailPage extends StatefulWidget {
  // Map? product;
  ProductModel? productModel;
  ProductDetailPage({
    //  this.product,
    this.productModel,
  });
  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool activo = false;
  FirestoreService collectionProduc = FirestoreService(collection: "productos");
  final preferences = CartPreference();

  // bool carrito = false;

  @override
  void initState() {
    super.initState();
    // getData();
   
  } 
  
 int counter = 0;
  saveQuantity() {
    widget.productModel!.quantity = counter;
    DBManager.db.insertModel(widget.productModel!).then((value) {
      // print(widget.productModel!.toJson());
      getmodal();
        counter = preferences.quantity;
          preferences.quantity = counter+widget.productModel!.quantity!;
      // saveQuantity();
        counter = 0;
      setState(() {});
    }); 
  }

  bool loading = true;
  List<ProductModel> listproduct = [];
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
              "Producto Agregado",
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
 
  List product2 = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0A0D15),
      appBar: PreferredSize(
        child: AppBarWidget(titulo: "Gymshark"),
        preferredSize: const Size.fromHeight(45),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  child: Container(
                    height: 310,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xff0A0D15), 
                    ),
                    child: Stack(
                      children: [
                        Container(
                          // height: 250,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(widget.productModel!.image),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 13,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff1E1E2C),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              widget.productModel!.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: counter == 0
                                      ? () {}
                                      : () {
                                          counter--;
                                          setState(() {});
                                        },
                                  icon: Icon(
                                    Icons.remove,
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                ),
                                Text(
                                  counter.toString(),
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: counter != 0
                                        ? Colors.grey.withOpacity(0.12)
                                        : Colors.transparent,
                                    // ? Colors.grey.withOpacity(0.2)
                                    // : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      counter++;
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
          
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff1E1E2C),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: Text(
                                widget.productModel!.description,
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Precio",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
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
                            horizontal: 12,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xff1E1E2C),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: Text(
                                "S/${widget.productModel!.price}".toString(),
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Marca",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
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
                            horizontal: 12,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xff1E1E2C),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: Text(
                                widget.productModel!.marca,
                                // widget.product["order"].toString(),
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Divider(
                    thickness: 0.1,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Productos que te pueden interesar",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                  child: Container(
                    constraints: const BoxConstraints(
                      maxHeight: 245,
                      maxWidth: double.infinity,
                    ),
                    child: loading == false
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xffE42165),
                            ),
                          )
                        : FutureBuilder(
                            future: collectionProduc.getProductModel(),
                            builder:
                                (BuildContext context, AsyncSnapshot snap) {
                              if (snap.hasData) {
                                List<ProductModel> aux = snap.data;
                                return ListView.builder(
                                    primary: true,
                                    physics: const ScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: aux.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetailPage(
                                                      productModel: aux[index],
                                                      // product: listproduct[index],
                                                    )),
                                          );
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          height: 200,
                                          width: 240,
                                          decoration: BoxDecoration(
                                            color: const Color(0xff1E1E2C),
                                            borderRadius:
                                                BorderRadius.circular(12),
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
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            aux[index].image),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Container(
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8,
                                                          horizontal: 8),
                                                      decoration: BoxDecoration(
                                                        // color: const Color(0xffE42165)
                                                        color: const Color(
                                                            0xff4C1F39)
                                                        // .withOpacity(0.23),
                                                        ,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          child: Text(
                                                            aux[index].name,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.85),
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 12,
                                                      horizontal: 8),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xffE42165),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            19),
                                                  ),
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.all(8),
                                                    child: Text(
                                                      "S/ ${aux[index].price.toString()}",
                                                      style: TextStyle(
                                                          color: Colors.white
                                                              .withOpacity(
                                                                  0.85),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }
                              return Container();
                            },
                          ),
                  
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50.0,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
              child: ElevatedButton.icon(
                onPressed: counter != 0
                    ? () {
                        // widget.productModel!.quantity = counter;

                        // DBManager.db
                        //     .insertModel(widget.productModel!)
                        //     .then((value) {
                        // getmodal();
                        saveQuantity();
                
                        // });
                        // print(widget.productModel!.toJson());
                        setState(() {});
                        // carrito = true;
                      
                        activo = true;
                     
                      }
                    : () {},
                icon: const Icon(Icons.shopping_cart_outlined),
                label: const Text("Agregar Al carro"),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff4C1F39),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
