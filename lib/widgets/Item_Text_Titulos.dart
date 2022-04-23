import 'package:flutter/material.dart';


class Item_TextTitulos extends StatelessWidget {
 String titulo;
 Item_TextTitulos({required this.titulo});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 15, vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
            Text(titulo
            ,
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
    );
  }
}
