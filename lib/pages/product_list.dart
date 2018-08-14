import 'package:flutter/material.dart';
import './product_edit.dart';

class ProductListPage extends StatelessWidget {
  final Function updateProduct;
  final List<Map<String, dynamic>> products;
  ProductListPage(this.products, this.updateProduct);

  _content(BuildContext context, int index) {
    print("---PRODUCTS LIST PAGE---");
    print("title: " + products[index]['title']);
    return Container(
        // padding: EdgeInsets.only(bottom: 3.0),
        child: Container(
            // color: Colors.white,
            child: Column(children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(products[index]['image']),
                ),
                title: Text(products[index]['title']),
                subtitle: Text('\$' + this.products[index]['price'].toString()),
                trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return ProductEditPage(
                          product: products[index],
                          updateProduct: this.updateProduct,
                          productIndex: index,
                        );
                      }));
                    }),
              ),
              Divider(),
            ])));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              return _content(context, index);
            }));
  }
}
