import 'package:flutter/material.dart';
import '.././product_manager.dart';
import '../drawers.dart';

class ProductsPage extends StatelessWidget {

  final List<Map<String, String>> products;
  final Function addProduct;
  final Function deleteProduct;

  ProductsPage(this.products, this.addProduct, this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer
      drawer: MenuDrawer(),

      // app bar
      appBar: AppBar(
        title: Text("Title"),
        centerTitle: true,
      ),

      // body
      body: ProductManager(this.products, this.addProduct, this.deleteProduct),
    );
  }
}
