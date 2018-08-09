import "package:flutter/material.dart";
import '../widgets/ui_elements/drawers.dart';
import "./product_create.dart";
import "./product_list.dart";

class ProductAdminPage extends StatelessWidget{

  final Function addProduct;
  final Function deleteProduct;
  final List<Map<String, dynamic>> products;
  ProductAdminPage(this.addProduct, this.deleteProduct, this.products);
  

  @override
    Widget build(BuildContext context) {
      return DefaultTabController(
        length: 2, // number of tabs
        child: Scaffold(
          drawer: MenuDrawer(),

          appBar: AppBar(
            title: Text("Admin Page"),
            bottom: TabBar(
              tabs: [
                Tab(text: "Create Product", icon: Icon(Icons.create)),
                Tab(text: "My Product", icon: Icon(Icons.list)),
              ]
            ),
          ),

          body: TabBarView(
            children: <Widget>[
              ProductCreatePage(this.addProduct),
              ProductListPage(this.products),
            ],
          ),
        )
      );
    }
}