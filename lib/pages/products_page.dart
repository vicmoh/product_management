import 'package:flutter/material.dart';
import '.././product_manager.dart';

class ProductsPage extends StatelessWidget{
  @override
    Widget build(BuildContext context) {
      return Scaffold(

        // app bar
        appBar: AppBar(
          title: Text("Title"),
          centerTitle: true,
        ),

        // body
        body: ProductManager(),

      );
    }
}