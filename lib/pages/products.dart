import 'package:flutter/material.dart';
import '../widgets/products/products.dart';
import '../drawers.dart';

class ProductsPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  // final Function addProduct;
  // final Function deleteProduct;

  ProductsPage(this.products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer
      drawer: MenuDrawer(),

      // app bar
      appBar: AppBar(
        title: Text("Easy List"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
          ),
        ],
        centerTitle: false,
      ),

      // body
      body: Products(this.products),
    );
  }
}
