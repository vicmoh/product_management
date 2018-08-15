import 'package:flutter/material.dart';
import '../widgets/products/products.dart';
import '../widgets/ui_elements/drawers.dart';

class ProductsPage extends StatelessWidget {
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
      body: Products(),
    );
  }
}
