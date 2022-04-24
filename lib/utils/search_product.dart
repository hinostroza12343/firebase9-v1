import 'package:firebase_9_app/models/product_model.dart';
import 'package:firebase_9_app/pages/producl_Detail_page.dart';
import 'package:firebase_9_app/widgets/item_seach_widget.dart';
import 'package:flutter/material.dart';

class SearchProduct extends SearchDelegate {
  final List<ProductModel>? productos;
  List<ProductModel>? lisProducts2 = [];

  String result = "";

  SearchProduct({
    this.productos,
    this.lisProducts2,
  });

  @override
  String get searchFieldLabel => "Buscar producto";

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      scaffoldBackgroundColor:    Color(0xff0A0D15),
      hintColor: Colors.white60,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
            color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w500),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Color (0xff0A0D15), 
        // backgroundColor: Color(0xffF5F5F5),
      ),
      textTheme: TextTheme(
        headline6: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, result);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // if (query
    //     .trim()
    //     .length == 0) {
    //   return Text('no hay valor en el query');
    // }

    return ListView.builder(
        itemCount: lisProducts2!.length,
        itemBuilder: (_, index) {
          return ItemSearchWidget(
            categoria: lisProducts2![index].category,
            image: lisProducts2![index].image,
            name: lisProducts2![index].name,
            desciption: lisProducts2![index].description,
            brand: lisProducts2![index].marca,
              rate: lisProducts2![index].rate,
            price: lisProducts2![index].price,
           goTo: ProductDetailPage(
              productModel: lisProducts2![index],
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    lisProducts2 = productos!.where((element) {
      return element.name.toLowerCase().contains(query.trim().toLowerCase());
    }).toList();

    return ListView.builder(
        itemCount: lisProducts2!.length,
        itemBuilder: (_, index) {
          return ItemSearchWidget(
            categoria: lisProducts2![index].category,
            image: lisProducts2![index].image,
            name: lisProducts2![index].name,
            brand: lisProducts2![index].marca,
            desciption: lisProducts2![index].description,
            // time: suggestions[index]['time'].toStringAsFixed(0),
              rate: lisProducts2![index].rate,
            price: lisProducts2![index].price,
            goTo: ProductDetailPage(
              productModel: lisProducts2![index],
            ),
          );
        });
  }
}
