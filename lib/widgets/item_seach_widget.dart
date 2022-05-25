import 'package:flutter/material.dart';

class ItemSearchWidget extends StatelessWidget {
  String image;
  String name;
  String desciption;
  String categoria;
  // String time;
  int? rate;
  double price;
  String? brand;
  Widget? goTo;

  ItemSearchWidget({
    required this.image,
    required this.categoria,
    this.brand,
    required this.name,
    required this.desciption,
    this.rate,
    required this.price,
    this.goTo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => goTo!));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Row(
          children: [
            Container(
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                color: const Color(0xff0A0D15),
                borderRadius: BorderRadius.circular(14.0),
                // image: DecorationImage(
                //   fit: BoxFit.cover,
                //   image: NetworkImage(
                //     image,
                //   ),
                // ),
              ),
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    brand!,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    desciption,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 14),
                  ),
                  const SizedBox(
                    height: 2.0,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color(0xffED9B00),
                        size: 16.0,
                      ),
                      const SizedBox(
                        width: 2.0,
                      ),
                      Text(
                        rate.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),

                      const SizedBox(
                        width: 2.0,
                      ),
                      // Text(
                      //   "$time min.",
                      //   style: TextStyle(
                      //     color: Colors.white60,
                      //     fontWeight: FontWeight.normal,
                      //     fontSize: 14.0,
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              "S/${price.toString()}",
              style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
