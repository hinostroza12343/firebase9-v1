import 'package:firebase_9_app/services/firebase_services.dart';
import 'package:flutter/material.dart';

class ItemSearchWidget2 extends StatelessWidget {
  String image;
  String name;
  int? cantidad;
  double price;
  // String desciption;
  // String categoria;
  // String time;
  // String? brand;

  ItemSearchWidget2({
    required this.image,
    // required this.categoria,
    // this.brand,
    required this.name,
    // required this.desciption,
    this.cantidad,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    FirestoreService saleService = FirestoreService(collection: "SaleDetail");
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
      child:
          // Column(
          //   children: [
          Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 100.0,
            width: 90.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: FadeInImage(
                fit: BoxFit.cover,
                image: NetworkImage(image),
                placeholder: const AssetImage(
                  "assets/images/hk2.jpeg",
                ),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/images/hk2.jpeg",
                    height: 50,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            // child: Image.network(
            //   image,
            //   errorBuilder: (BuildContext context, Object exception,
            //       StackTrace? stackTrace) {
            //     // Appropriate logging or analytics, e.g.
            //     // myAnalytics.recordError(
            //     //   'An error occurred loading "https://example.does.not.exist/image.jpg"',
            //     //   exception,
            //     //   stackTrace,
            //     // );
            //     return Image.asset("assets/images/hk2.jpeg",);
            //   },
            // ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 80,
                child: Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              const Text(
                "Cant.",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontSize: 14),
              ),
              const SizedBox(
                height: 2.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.production_quantity_limits,
                    color: Colors.grey,
                    size: 16.0,
                  ),
                  const SizedBox(
                    width: 2.0,
                  ),
                  Text(
                    cantidad.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment:CrossAxisAlignment.end,
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "Precio",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "S/${price.toStringAsFixed(0)}",
                style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
