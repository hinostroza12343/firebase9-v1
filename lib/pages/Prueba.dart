import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_9_app/models/sale_model.dart';
import 'package:firebase_9_app/services/firebase_services.dart';
import 'package:firebase_9_app/widgets/ItemSearchWidget2.dart';
import 'package:flutter/material.dart';

class PruebaDart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<SaleModel> sale = [];
    FirestoreService saleDetail = FirestoreService(collection: "SaleDetail");
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Center(child: Text('PRUEBA')),
      ),
      body: SingleChildScrollView(
        primary: true,
        physics: ScrollPhysics(),
        child:   FutureBuilder(
                future: saleDetail.getSaleDetailModel(),
                builder: (BuildContext context, AsyncSnapshot snap) {
                  if (snap.hasError) {
                    return Container();
                  } else if (snap.hasData) {
                    List<SaleModel> saleaux = snap.data;
                    return Container(
                      constraints: const BoxConstraints(maxHeight: 500),
                      child: ListView.builder(
                          // scrollDirection: Axis.horizontal,
                          // primary: true,
                          // shrinkWrap: true,
                          itemCount: saleaux.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(    mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: saleaux[index]
                                            .saleDetail
                                            .map((e) =>
                                             ItemSearchWidget2(
                                               
                                              price: e.price2!,
                                                  image: e.image!,
                                                  name: e.name,
                                                  cantidad: e.quantity,
                                                  // cantidad: e.quantity,
                                                  // price: e.price2!
                                                ))
                                            .toList(),
                                      ),
                                    ],
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Total a pagar.",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white.withOpacity(0.9),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        "S/${saleaux[index].total.toStringAsFixed(0)}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
            
        
      ),
    );
  }
}
