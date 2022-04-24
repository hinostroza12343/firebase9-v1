import 'package:flutter/material.dart';

class ItemListProductID extends StatelessWidget { 
Widget? goto;
String name;
String image;
double price;

ItemListProductID({
  required this.name,
required this.image,
required this.price,
required this.goto});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>goto!
                                //  ProductDetailPage(
                                //   productModel : aux[index],
                                //   // product: product2[index],
                                // ),
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
                                        image),
                                      ),
                                ),
                                child: Stack(
                                  children:const [
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
                                        name
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
                                            "S/${price}".toString(),
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
                      );
  }
}