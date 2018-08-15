import 'package:flutter/material.dart';
import './product_edit.dart';
import '../models/product.dart';
import '../scoped-models/products.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductListPage extends StatelessWidget {
  Widget _buildEditButton(
      BuildContext context, int index, ProductsModel model) {
    // return icon button
    return IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          model.selectProduct(index);
          Navigator
              .of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return ProductEditPage();
          }));
        });
  } //end edit build button func

  Widget _content(BuildContext context, int index, ProductsModel model) {
    print("---PRODUCTS LIST PAGE---");
    print("title: " + model.products[index].title);
    return Container(
        // padding: EdgeInsets.only(bottom: 3.0),
        child: Container(
            // color: Colors.white,
            child: Column(children: <Widget>[
      ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(model.products[index].image),
          ),
          title: Text(model.products[index].title),
          subtitle: Text('\$' + model.products[index].price.toString()),
          trailing: _buildEditButton(context, index, model)),
      Divider(),
    ])));
  } //end content func

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(child: ScopedModelDescendant<ProductsModel>(
        builder: (BuildContext context, Widget child, ProductsModel model) {
      // return the list view
      return ListView.builder(
          itemCount: model.products.length,
          itemBuilder: (BuildContext context, int index) {
            // dismissible to remove the item to swipe
            return Dismissible(
              background: Container(color: Colors.red),

              // condition when swipe
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.endToStart) {
                  print('swiped end to start');
                  model.selectProduct(index);
                  model.deleteProduct();
                } else if (direction == DismissDirection.startToEnd) {
                  print('swipe start to end');
                } else {
                  print('other swipe');
                }
              },

              // key data and its content
              key: Key(model.products[index].title),
              child: _content(context, index, model),
            );
          });
    }));
  }
}
