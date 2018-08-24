import "package:flutter/material.dart";
import '../widgets/ui_elements/drawers.dart';
import "./product_edit.dart";
import "./product_list.dart";
import '../models/product.dart';
import '../scoped-models/main.dart';

class ProductAdminPage extends StatelessWidget {
  final MainModel model;
  ProductAdminPage(this.model);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2, // number of tabs
        child: Scaffold(
          drawer: MenuDrawer(),
          appBar: AppBar(
            title: Text("Admin Page"),
            bottom: TabBar(tabs: [
              Tab(text: "Create Product", icon: Icon(Icons.create)),
              Tab(text: "My Product", icon: Icon(Icons.list)),
            ]),
          ),

          // tab bar view
          body: TabBarView(
            children: <Widget>[
              ProductEditPage(),
              ProductListPage(model),
            ],
          ),
        ));
  }
}
