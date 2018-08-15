import 'package:flutter/material.dart';
import '../widgets/products/products.dart';
import '../widgets/ui_elements/drawers.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';

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
          ScopedModelDescendant<MainModel>(builder:
              (BuildContext context, Widget child, MainModel model) {
            //return icon button on app bar
            return IconButton(
              icon: Icon(model.displayFavoriteOnly
                  ? Icons.favorite
                  : Icons.favorite_border),
              onPressed: () {
                model.toggleDisplayMode();
              },
            );
          }),
        ],
        centerTitle: false,
      ),

      // body
      body: Products(),
    );
  }
}
