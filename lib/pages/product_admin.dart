import "package:flutter/material.dart";
import "../drawers.dart";

class ProductAdminPage extends StatelessWidget{
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        drawer: MenuDrawer(),

        appBar: AppBar(
          title: Text("Admin Page"),
        ),

        body: Center(
          child: Text("Product admin page"),
        ),
      );
    }
}