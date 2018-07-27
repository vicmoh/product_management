import 'package:flutter/material.dart';
import '.././product_manager.dart';

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(title: Text("Choose"),
              // remove hamburger icon
              automaticallyImplyLeading: false,
            ),
            ListTile(
              title: Text("Manage Product"),
              onTap: () {},
            ),
          ],
        )
      ),

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
