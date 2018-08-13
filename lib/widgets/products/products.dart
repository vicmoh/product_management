import 'package:flutter/material.dart';
import './product_card.dart';

class Products extends StatelessWidget {
  // instances
  final List<Map<String, dynamic>> products;
  // constructor
  Products(this.products) {
    print("[Products Widget] Constructor");
  } //end contructor

  Widget _buildProductList() {
    Widget productCards =
        Center(child: Text("No product found, please add some"));
    if (products.length > 0) {
      productCards = ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            ProductCard(products[index], index),
        itemCount: products.length,
      );
    } //end if
    return productCards;
  } //end func

  @override
  Widget build(BuildContext context) {
    print("[product widget] build");
    return _buildProductList();
  } //end build
} //end class
