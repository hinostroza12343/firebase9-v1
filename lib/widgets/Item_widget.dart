import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  String image;
  String nombre;
  Widget? goTo;
  double price;
  ItemWidget(
      {required this.price,
      required this.image,
      required this.nombre,
       this.goTo});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => goTo!)); 
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 180,
                  width: 200,
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        image,
                      ),
                      // "https://getstrong.es/wp-content/uploads/2021/10/dumbell-black-general.jpg"),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xffE42165).withOpacity(0.23),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                        margin: const EdgeInsets.all(8),
                        child: Text(
                          nombre,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 13,
                              fontWeight: FontWeight.w700),
                        )),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                decoration: BoxDecoration(
                  color: const Color(0xffE42165),
                  borderRadius: BorderRadius.circular(19),
                ),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  child: Text(
                    "S/${price.toString()}",
                    // "S/132",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
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
  }
}
