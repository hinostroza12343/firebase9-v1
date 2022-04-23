import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Category_widget extends StatelessWidget {
  String categoria;
  Widget goTo;

  Category_widget({required this.categoria, required this.goTo});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>  goTo));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Chip(
          shadowColor: const Color(0xffE42165).withOpacity(0.90),
          avatar: SvgPicture.asset(
            "assets/images/weightlifting.svg",
            fit: BoxFit.cover,
            height: 23,
            color: Colors.white,
          ),
          backgroundColor: const Color(0xffE42165),
          elevation: 1,
          label: Text(
            categoria,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
